import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
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
    homeController.sortName.value = '';
    homeController.sortMachineID.value = 0;
    _controller.clear();
    _controller1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SmartRefresher(
        footer: footer(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: true,
        physics: const BouncingScrollPhysics(),
        header: const MaterialClassicHeader(
          color: kPrimaryColor,
        ),
        child: FutureBuilder<List<dynamic>>(
          future: CategoryService().getCategoryByID(widget.id, parametrs: {'sort_by': '${homeController.sortName}', 'min': _controller.text, 'max': _controller1.text, 'machine_id': '${homeController.sortMachineID.value == 0 ? '' : homeController.sortMachineID.value}'}),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.data!.isEmpty) {
              return Center(child: const Text('No Kategory Image'));
            }
            print(snapshot.error);
            return StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return widget.isCollar
                    ? ProductCard(
                        image: snapshot.data![index].images ?? [],
                        name: '${snapshot.data![index].name}',
                        price: '${snapshot.data![index].price}',
                        id: snapshot.data![index].id!,
                        files: snapshot.data![index].files!,
                        downloadable: true,
                        createdAt: snapshot.data![index].createdAt!,
                      )
                    : ProductCard(
                        image: snapshot.data![index].images!,
                        name: '${snapshot.data![index].name}',
                        price: '${snapshot.data![index].price}',
                        id: snapshot.data![index].id!,
                        downloadable: false,
                        files: [],
                        createdAt: snapshot.data![index].createdAt!,
                      );
              },
              staggeredTileBuilder: (index) => StaggeredTile.count(
                1,
                index % 2 == 0 ? 1.3 : 1.5,
              ),
            );
          },
        ),
      ),
    );
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  Padding selectMachineType(BuildContext context) {
    // String _name = 'Janomeeeee';
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
            content: FutureBuilder<List<GetMachinesModel>>(
              future: AboutUsService().getmMchines(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.hasError) {
                  return const Text('error');
                } else if (snapshot.data == null) {
                  return const Text('null');
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

  Padding leftSideAppBar(BuildContext context) {
    int value = 0;

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
