import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/about_us_service.dart';
import 'package:yaka2/app/data/services/auth_service.dart';
import 'package:yaka2/app/data/services/fav_service.dart';
import 'package:yaka2/app/modules/user_profil/controllers/user_profil_controller.dart';

import '../../../data/models/banner_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/services/banner_service.dart';
import '../../../data/services/category_service.dart';
import '../../../data/services/collars_service.dart';
import '../../../data/services/dresses_service.dart';

class HomeController extends GetxController {
  RxString balance = '0'.obs;
  RxInt bannerDotsIndex = 0.obs;
  late final Future<List<CollarModel>> favCollars;
  late final Future<List<DressesModel>> favProducts;
  late final Future<List<BannerModel>> getBanners;
  late final Future<List<CategoryModel>> getCategories;
  RxInt limit = 30.obs;
  RxInt loading = 0.obs;
  RxInt page = 1.obs;
  RxList showAllList = [].obs;
  RxInt sortMachineID = 0.obs;
  RxString sortMachineName = 'Yaka'.obs;
  RxString sortName = ''.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getFavorites();
    userMoney();
    getBanners = BannerService().getBanners();
    getCategories = CategoryService().getCategories();
  }

  dynamic getAllProducts() {
    collarList.clear();
    clothesList.clear();
    goodsList.clear();
    collarPage.value = 1;
    page.value = 1;
    clothesPage.value = 1;
    goodsPage.value = 1;
    goodsLoading.value = 0;
    clothesLoading.value = 0;
    collarLoading.value = 0;
    getData();
    getDataClothes();
    getDataGoods();
  }

  dynamic savePhoneNumber(String number) {
    storage.write('phoneNumber', number);
  }

  Future<String> returnPhoneNumber() async {
    String number = '';
    if (await storage.read('phoneNumber') == null) {
      number = 'belginiz yok';
    } else {
      number = await storage.read('phoneNumber');
    }
    return number;
  }

  dynamic userMoney() async {
    final token = await Auth().getToken();
    final UserProfilController controller = Get.put(UserProfilController());
    if (token == null) {
      balance.value = '0';
      controller.userLogin.value = false;
    } else {
      await AboutUsService().getuserData().then((value) {
        balance.value = '${value.balance! / 100}';
      });
      controller.userLogin.value = true;
    }
  }

  dynamic getFavorites() async {
    final token = await Auth().getToken();
    if (token == null) {
    } else {
      favProducts = FavService().getProductFavList();
      favCollars = FavService().getCollarFavList();
    }
  }

// Collar
  RxInt collarPage = 1.obs;
  RxInt collarLimit = 10.obs;
  RxInt collarLoading = 0.obs;
  RxList collarList = [].obs;
  dynamic getData() async {
    await CollarService().getCollars(
      parametrs: {
        'page': '${collarPage.value}',
        'limit': '${collarLimit.value}',
      },
    ).then((value) {
      for (var element in value) {
        collarList.add({
          'images': element.image,
          'name': element.name,
          'price': element.price,
          'id': element.id,
          'createdAt': element.createdAt,
        });
      }
    });
  }

  // Collar
  //Clothes
  RxInt clothesPage = 1.obs;
  RxInt clothesLimit = 10.obs;
  RxInt clothesLoading = 0.obs;
  RxList clothesList = [].obs;
  dynamic getDataClothes() async {
    await DressesService().getDresses(
      parametrs: {'page': '${clothesPage.value}', 'limit': '${clothesLimit.value}', 'home': '1'},
    ).then((value) {
      for (var element in value) {
        clothesList.add({
          'id': element.id,
          'name': element.name,
          'desc': element.description,
          'barcode': element.barcode,
          'price': element.price,
          'views': element.views,
          'createdAt': element.createdAt,
          'images': element.image,
          'category': element.category,
        });
      }
    });
  }
  //Clothes
  //Goods

  RxInt goodsPage = 1.obs;
  RxInt goodsLimit = 10.obs;
  RxInt goodsLoading = 0.obs;
  RxList goodsList = [].obs;
  dynamic getDataGoods() async {
    await DressesService().getGoods(
      parametrs: {
        'page': '${goodsPage.value}',
        'limit': '${goodsLimit.value}',
      },
    ).then((value) {
      for (var element in value) {
        goodsList.add({
          'id': element.id,
          'name': element.name,
          'desc': element.description,
          'barcode': element.barcode,
          'price': element.price,
          'views': element.views,
          'createdAt': element.createdAt,
          'images': element.image,
          'category': element.category,
        });
      }
    });
  }
  //Goods
}
