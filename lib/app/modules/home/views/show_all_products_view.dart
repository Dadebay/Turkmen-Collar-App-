import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/about_us_model.dart';
import 'package:yaka2/app/data/services/about_us_service.dart';
import 'package:yaka2/app/data/services/category_service.dart';
import 'package:yaka2/app/modules/home/controllers/home_controller.dart';
import 'package:yaka2/app/modules/home/views/show_all_product_widgets.dart';
import 'package:yaka2/app/others/buttons/agree_button.dart';
import 'package:yaka2/app/others/cards/product_card.dart';

import '../../../constants/widgets.dart';

class ShowAllProductsView extends StatefulWidget {
  final int id;
  final String name;
  const ShowAllProductsView({
    required this.name,
    required this.id,
    Key? key,
  }) : super(key: key);
  @override
  State<ShowAllProductsView> createState() => _ShowAllProductsViewState();
}

class _ShowAllProductsViewState extends State<ShowAllProductsView> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  final HomeController homeController = Get.put(HomeController());
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  int value = 0;

  @override
  void initState() {
    super.initState();
    homeController.loading.value = 0;
    homeController.sortName.value = '';
    homeController.page.value = 1;
    homeController.sortMachineID.value = 0;
    controller.clear();
    controller1.clear();
    homeController.showAllList.clear();
    getData();
  }

  dynamic getData() {
    CategoryService().getCategoryByID(
      widget.id,
      parametrs: {
        'sort_by': '${homeController.sortName}',
        'min': controller.text,
        'max': controller1.text,
        'tag': '${homeController.sortMachineID.value == 0 ? '' : homeController.sortMachineID.value}',
        'page': '${homeController.page.value}',
        'limit': '${homeController.limit.value}',
      },
    );
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    refreshController.refreshCompleted();
    homeController.showAllList.clear();
    homeController.page.value = 1;
    homeController.limit.value = 30;
    homeController.sortMachineID.value = 0;
    homeController.sortName.value = '';
    controller.clear();
    controller1.clear();
    value = 0;
    homeController.loading.value = 0;
    getData();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    refreshController.loadComplete();
    homeController.page.value += 1;
    homeController.limit.value = 30;
    getData();
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.name.tr,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconlyLight.arrowLeftCircle,
          color: Colors.black,
        ),
      ),
      actions: [_leftSideAppBar()],
    );
  }

  Padding _selectMachineType() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('selectMachine'.tr, style: const TextStyle(color: Colors.grey, fontFamily: normsProLight, fontSize: 14)),
            Obx(() {
              return Text(homeController.sortMachineName.value, style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18));
            }),
          ],
        ),
        leading: const Icon(
          IconlyLight.location,
          size: 30,
        ),
        trailing: const Icon(IconlyLight.arrowRightCircle),
        onTap: () {
          Get.defaultDialog(
            title: 'selectMachine'.tr,
            titleStyle: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: normsProMedium),
            radius: 5,
            backgroundColor: Colors.white,
            titlePadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            content: FutureBuilder<List<GetFilterElements>>(
              future: AboutUsService().getFilterElements(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.hasError) {
                  return Center(
                    child: errorPage(
                      onTap: () {
                        AboutUsService().getFilterElements();
                      },
                    ),
                  );
                } else if (snapshot.data == null) {
                  return Center(
                    child: emptyPageImage(
                      onTap: () {
                        AboutUsService().getFilterElements();
                      },
                    ),
                  );
                }
                return Column(
                  children: List.generate(
                    snapshot.data!.length,
                    (index) => Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        index == 0 ? divider() : const SizedBox.shrink(),
                        TextButton(
                          onPressed: () {
                            homeController.sortMachineName.value = snapshot.data![index].name!;
                            homeController.sortMachineID.value = snapshot.data![index].id!;
                            Get.back();
                          },
                          child: Text(
                            snapshot.data![index].name!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 16),
                          ),
                        ),
                        divider(),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Padding _leftSideAppBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              defaultBottomSheet(
                name: 'sort'.tr,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sortData.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      value: index,
                      tileColor: kBlackColor,
                      selectedTileColor: kBlackColor,
                      activeColor: kPrimaryColor,
                      groupValue: value,
                      onChanged: (ind) {
                        final int a = int.parse(ind.toString());
                        value = a;
                        homeController.sortName.value = sortData[index]['sort_column'];
                        homeController.sortMachineID.value = 0;
                        controller.clear();
                        controller1.clear();
                        homeController.showAllList.clear();

                        getData();
                        if (!mounted) {
                          return;
                        }
                        setState(() {});
                        Get.back();
                      },
                      title: Text(
                        "${sortData[index]["name"]}".tr,
                        style: const TextStyle(color: Colors.black, fontFamily: normsProRegular),
                      ),
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              IconlyLight.filter,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              defaultBottomSheet(
                name: 'Filter'.tr,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _selectMachineType(),
                      Divider(
                        color: kPrimaryColor.withOpacity(0.4),
                        thickness: 2,
                      ),
                      twoTextEditingField(controller1: controller, controller2: controller1),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: AgreeButton(
                          onTap: () {
                            homeController.showAllList.clear();
                            homeController.page.value = 1;
                            getData();
                            homeController.sortName.value = '';
                            if (!mounted) {
                              return;
                            }
                            setState(() {});
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const Icon(
              IconlyLight.filter2,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: SmartRefresher(
        footer: footer(),
        controller: refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: true,
        physics: const BouncingScrollPhysics(),
        header: const MaterialClassicHeader(
          color: kPrimaryColor,
        ),
        child: Obx(
          () {
            if (homeController.loading.value == 0) {
              return Center(child: spinKit());
            } else if (homeController.loading.value == 1) {
              return Center(
                child: errorPage(
                  onTap: () {
                    CategoryService().getCategoryByID(
                      widget.id,
                      parametrs: {
                        'sort_by': '${homeController.sortName}',
                        'min': controller.text,
                        'max': controller1.text,
                        'machine_id': '${homeController.sortMachineID.value == 0 ? '' : homeController.sortMachineID.value}',
                        'page': homeController.page.value,
                        'limit': homeController.limit.value,
                      },
                    );
                  },
                ),
              );
            } else if (homeController.loading.value == 2) {
              return Center(
                child: emptyPageImage(
                  onTap: () {
                    CategoryService().getCategoryByID(
                      widget.id,
                      parametrs: {
                        'sort_by': '${homeController.sortName}',
                        'min': controller.text,
                        'max': controller1.text,
                        'machine_id': '${homeController.sortMachineID.value == 0 ? '' : homeController.sortMachineID.value}',
                        'page': homeController.page.value,
                        'limit': homeController.limit.value,
                      },
                    );
                  },
                ),
              );
            }
            return homeController.showAllList.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(noData, width: 350, height: 350),
                        Text(
                          'noProductFound'.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                : StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeController.showAllList.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        image: homeController.showAllList[index]['images'],
                        name: '${homeController.showAllList[index]['name']}',
                        price: '${homeController.showAllList[index]['price']}',
                        id: homeController.showAllList[index]['id'],
                        downloadable: widget.name == 'collar'.tr ? true : false,
                        removeAddCard: false,
                        createdAt: homeController.showAllList[index]['createdAt'],
                      );
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.count(
                      1,
                      1.8,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
