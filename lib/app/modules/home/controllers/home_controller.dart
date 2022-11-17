import 'package:get/get.dart';
import 'package:yaka2/app/data/models/banner_model.dart';
import 'package:yaka2/app/data/models/category_model.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/models/machines_model.dart';
import 'package:yaka2/app/data/services/about_us_service.dart';
import 'package:yaka2/app/data/services/auth_service.dart';
import 'package:yaka2/app/data/services/banner_service.dart';
import 'package:yaka2/app/data/services/category_service.dart';
import 'package:yaka2/app/data/services/collars_service.dart';
import 'package:yaka2/app/data/services/dresses_service.dart';
import 'package:yaka2/app/data/services/fav_service.dart';
import 'package:yaka2/app/data/services/machines_service.dart';
import 'package:yaka2/app/modules/user_profil/controllers/user_profil_controller.dart';

class HomeController extends GetxController {
  RxInt bannerDotsIndex = 0.obs;
  RxString balance = ''.obs;
  RxString sortName = ''.obs;
  RxInt sortMachineID = 0.obs;
  RxString sortMachineName = 'Janome'.obs;
  late final Future<List<BannerModel>> future;
  late final Future<List<CategoryModel>> category;
  late final Future<List<CollarModel>> collars;
  late final Future<List<DressesModel>> dresses;
  late final Future<List<MachineModel>> machines;
  late final Future<List<DressesModel>> favProducts;
  late final Future<List<CollarModel>> favCollars;

  @override
  void onInit() {
    super.onInit();
    future = BannerService().getBanners();
    category = CategoryService().getCategories();
    collars = CollarService().getCollars();
    dresses = DressesService().getDresses();
    machines = MachineService().getMachines();
    favProducts = FavService().getProductFavList();
    favCollars = FavService().getCollarFavList();
    userMoney();
  }

  dynamic userMoney() async {
    final token = await Auth().getToken();
    final UserProfilController controller = Get.put(UserProfilController());
    if (token == null) {
      balance.value = '0';
      controller.userLogin.value = false;
    } else {
      await AboutUsService().getuserData().then((value) {
        print(value.balance);
        balance.value = '${value.balance! / 100}';
      });
      controller.userLogin.value = true;
    }
  }
}
