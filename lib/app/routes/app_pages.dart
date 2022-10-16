import 'package:get/get.dart';
import 'package:yaka2/app/modules/auth/connection_check/bindings/connection_check_binding.dart';
import 'package:yaka2/app/modules/auth/connection_check/views/connection_check_view.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/bindings/sign_in_page_binding.dart';
import 'package:yaka2/app/modules/auth/sign_in_page/views/sign_in_page_view.dart';
import 'package:yaka2/app/modules/favorites/bindings/favorites_binding.dart';
import 'package:yaka2/app/modules/favorites/views/favorites_view.dart';
import 'package:yaka2/app/modules/home/bindings/home_binding.dart';
import 'package:yaka2/app/modules/home/views/home_view.dart';
import 'package:yaka2/app/modules/product_profil/bindings/product_profil_binding.dart';
import 'package:yaka2/app/modules/product_profil/views/product_profil_view.dart';
import 'package:yaka2/app/modules/user_profil/bindings/user_profil_binding.dart';
import 'package:yaka2/app/modules/user_profil/views/user_profil_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN_PAGE,
      page: () => const SignInPageView(),
      binding: SignInPageBinding(),
    ),
    GetPage(
      name: _Paths.CONNECTION_CHECK,
      page: () => const ConnectionCheckView(),
      binding: ConnectionCheckBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFIL,
      page: () => UserProfilView(),
      binding: UserProfilBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_PROFIL,
      page: () => ProductProfilView(''),
      binding: ProductProfilBinding(),
    ),
  ];
}
