import 'package:get/get.dart';
import 'package:yaka2/app/data/models/banner_model.dart';
import 'package:yaka2/app/data/models/category_model.dart';
import 'package:yaka2/app/data/services/banner_service.dart';
import 'package:yaka2/app/data/services/category_service.dart';

class HomeController extends GetxController {
  RxInt bannerDotsIndex = 0.obs;
  RxBool agreeButton = false.obs;
  late final Future<List<BannerModel>> future;
  late final Future<List<CategoryModel>> category;
  @override
  void onInit() {
    super.onInit();
    future = BannerService().getBanners();
    category = CategoryService().getCategories();
  }
}
