import 'package:get/get.dart';
import 'package:yaka2/app/data/models/banner_model.dart';
import 'package:yaka2/app/data/models/category_model.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/models/machines_model.dart';
import 'package:yaka2/app/data/services/banner_service.dart';
import 'package:yaka2/app/data/services/category_service.dart';
import 'package:yaka2/app/data/services/collars_service.dart';
import 'package:yaka2/app/data/services/dresses_service.dart';
import 'package:yaka2/app/data/services/machines_service.dart';

class HomeController extends GetxController {
  RxInt bannerDotsIndex = 0.obs;
  RxBool agreeButton = false.obs;

  late final Future<List<BannerModel>> future;
  late final Future<List<CategoryModel>> category;
  late final Future<List<CollarModel>> collars;
  late final Future<List<DressesModel>> dresses;
  late final Future<List<MachineModel>> machines;

  @override
  void onInit() {
    super.onInit();
    future = BannerService().getBanners();
    category = CategoryService().getCategories();
    collars = CollarService().getCollars();
    dresses = DressesService().getDresses();
    machines = MachineService().getMachines();
  }
}
