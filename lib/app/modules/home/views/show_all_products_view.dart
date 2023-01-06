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
  // ignore: always_put_required_named_parameters_first
  const ShowAllProductsView({Key? key, required this.name, required this.isCollar, required this.id}) : super(key: key);

  final int id;
  final String name;
  final bool isCollar;

  @override
  State<ShowAllProductsView> createState() => _ShowAllProductsViewState();
}

class _ShowAllProductsViewState extends State<ShowAllProductsView> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.loading.value = 0;
    homeController.sortName.value = '';
    homeController.page.value = 1;
    homeController.sortMachineID.value = 0;
    _controller.clear();
    _controller1.clear();
    homeController.showAllList.clear();
    getData();
  }

  getData() {
    CategoryService().getCategoryByID(
      widget.id,
      parametrs: {
        'sort_by': '${homeController.sortName}',
        'min': _controller.text,
        'max': _controller1.text,
        'tag': '${homeController.sortMachineID.value == 0 ? '' : homeController.sortMachineID.value}',
        'page': '${homeController.page.value}',
        'limit': '${homeController.limit.value}',
      },
    ).then((value) {
      value.forEach((element) {
        if (widget.isCollar == true) {
          homeController.showAllList.add({
            'id': element.id,
            'name': element.name,
            'price': element.price,
            'createdAt': element.createdAt,
            'images': element.images,
            'files': element.files,
          });
        } else {
          homeController.showAllList.add({
            'id': element.id,
            'name': element.name,
            'price': element.price,
            'createdAt': element.createdAt,
            'images': element.images,
            'files': [],
          });
        }
      });
    });
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    homeController.showAllList.clear();
    homeController.page.value = 1;
    homeController.limit.value = 10;
    homeController.sortMachineID.value = 0;
    homeController.sortName.value = '';
    _controller.clear();
    _controller1.clear();
    value = 0;
    getData();
  }

  void _onLoading() async {
    // final int a = int.parse(homeController.page.value.toString());
    // final int b = int.parse(homeController.limit.value.toString());
    // if ((a * b) > homeController.showAllList.length) {
    // } else {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
    homeController.page.value += 1;
    homeController.limit.value = 10;

    getData();
    setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: SmartRefresher(
        footer: footer(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: true,
        physics: BouncingScrollPhysics(),
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
                        'min': _controller.text,
                        'max': _controller1.text,
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
                        'min': _controller.text,
                        'max': _controller1.text,
                        'machine_id': '${homeController.sortMachineID.value == 0 ? '' : homeController.sortMachineID.value}',
                        'page': homeController.page.value,
                        'limit': homeController.limit.value,
                      },
                    );
                  },
                ),
              );
            }
            return homeController.showAllList.length == 0
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(noData, width: 350, height: 350),
                        Text(
                          'noProductFound'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                : StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeController.showAllList.length,
                    itemBuilder: (context, index) {
                      return widget.isCollar
                          ? ProductCard(
                              image: homeController.showAllList[index]['images'] ?? [],
                              name: '${homeController.showAllList[index]['name']}',
                              price: '${homeController.showAllList[index]['price']}',
                              id: homeController.showAllList[index]['id'],
                              files: homeController.showAllList[index]['files'],
                              downloadable: true,
                              removeAddCard: false,
                              createdAt: homeController.showAllList[index]['createdAt'],
                            )
                          : ProductCard(
                              image: homeController.showAllList[index]['images'] ?? [],
                              name: '${homeController.showAllList[index]['name']}',
                              price: '${homeController.showAllList[index]['price']}',
                              id: homeController.showAllList[index]['id'],
                              downloadable: false,
                              removeAddCard: false,
                              files: [],
                              createdAt: homeController.showAllList[index]['createdAt'],
                            );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.count(
                      1,
                      1.8,
                    ),
                  );
          },
        ),
      ),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.name.tr,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: kPrimaryColor, statusBarIconBrightness: Brightness.dark),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          IconlyLight.arrowLeftCircle,
          color: Colors.black,
        ),
      ),
      actions: [leftSideAppBar(context)],
    );
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Padding selectMachineType(BuildContext context) {
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
                        index == 0 ? divider() : SizedBox.shrink(),
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

  int value = 0;

  Padding leftSideAppBar(BuildContext context) {
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
                        _controller.clear();
                        _controller1.clear();
                        homeController.showAllList.clear();

                        getData();
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
                      widget.isCollar ? selectMachineType(context) : SizedBox.shrink(),
                      widget.isCollar
                          ? Divider(
                              color: kPrimaryColor.withOpacity(0.4),
                              thickness: 2,
                            )
                          : SizedBox.shrink(),
                      twoTextEditingField(controller1: _controller, controller2: _controller1),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: AgreeButton(
                          onTap: () {
                            homeController.showAllList.clear();

                            getData();
                            homeController.sortName.value = '';
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
}
