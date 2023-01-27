import 'package:get/get.dart';
import 'package:yaka2/app/data/services/dresses_service.dart';

import '../../../data/services/collars_service.dart';

class CollarController extends GetxController {
  RxInt collarPage = 1.obs;
  RxInt collarLimit = 10.obs;
  RxInt collarLoading = 0.obs;
  RxList collarList = [].obs;
  getData() async {
    await CollarService().getCollars(
      parametrs: {
        'page': '${collarPage.value}',
        'limit': '${collarLimit.value}',
      },
    ).then((value) {
      value.forEach((element) {
        collarList.add({
          'images': element.images,
          'name': element.name,
          'price': element.price,
          'id': element.id,
          'files': element.files,
          'createdAt': element.createdAt,
        });
      });
    });
  }
}

class ClothesController extends GetxController {
  RxInt clothesPage = 1.obs;
  RxInt clothesLimit = 10.obs;
  RxInt clothesLoading = 0.obs;
  RxList clothesList = [].obs;
  getDataClothes() async {
    await DressesService().getDresses(
      parametrs: {'page': '${clothesPage.value}', 'limit': '${clothesLimit.value}', 'home': '1'},
    ).then((value) {
      value.forEach((element) {
        clothesList.add({
          'id': element.id,
          'name': element.name,
          'desc': element.description,
          'barcode': element.barcode,
          'price': element.price,
          'views': element.views,
          'createdAt': element.createdAt,
          'images': element.images,
          'category': element.category,
        });
      });
    });
  }
}

class GoodsController extends GetxController {
  RxInt goodsPage = 1.obs;
  RxInt goodsLimit = 10.obs;
  RxInt goodsLoading = 0.obs;
  RxList goodsList = [].obs;
  getDataGoods() async {
    await DressesService().getGoods(
      parametrs: {
        'page': '${goodsPage.value}',
        'limit': '${goodsLimit.value}',
      },
    ).then((value) {
      value.forEach((element) {
        goodsList.add({
          'id': element.id,
          'name': element.name,
          'desc': element.description,
          'barcode': element.barcode,
          'price': element.price,
          'views': element.views,
          'createdAt': element.createdAt,
          'images': element.images,
          'category': element.category,
        });
      });
    });
  }
}
