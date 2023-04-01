import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/constants/empty_state/empty_state.dart';
import 'package:yaka2/app/constants/error_state/error_state.dart';
import 'package:yaka2/app/data/models/clothes_model.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/category_service.dart';
import 'package:yaka2/app/modules/home/views/show_all_product_widgets.dart';

import '../../../constants/loadings/loading.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/about_us_model.dart';
import '../../../data/services/about_us_service.dart';
import '../../../others/buttons/agree_button.dart';
import '../../../others/cards/product_card.dart';

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
  int page = 1;
  int limit = 10;
  String sortMachineName = '';
  int sortMachineID = 0;
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  List<CollarModel> showAllList = [];
  List<DressesModel> showAllListProducts = [];

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool loading = false;
  dynamic getData() async {
    final List<dynamic> list = await CategoryService().getCategoryByID(
      id: widget.id,
      parametrs: {
        'page': '${page}',
        'limit': '${limit}',
        'sort_by': '$sortMachineName',
        'min': controller.text,
        'max': controller1.text,
        'tag': '${sortMachineID == 0 ? '' : sortMachineID}',
      },
    );
    if (widget.name == 'Ýakalar') {
      final List<CollarModel> tryList = list.cast<CollarModel>();
      showAllList = showAllList + tryList;
    } else {
      final List<DressesModel> tryList2 = list.cast<DressesModel>();
      showAllListProducts = showAllListProducts + tryList2;
    }
    loading = true;
    setState(() {});
  }

  void _onRefresh() {
    Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
    showAllList.clear();
    showAllListProducts.clear();
    page = 1;
    controller.clear();
    controller1.clear();
    sortMachineID = 0;
    sortMachineName = '';
    getData();
  }

  void _onLoading() {
    Future.delayed(Duration(milliseconds: 1000));
    refreshController.loadComplete();
    page += 1;
    getData();
  }

  Widget collarGridView() {
    return loading == false
        ? Loading()
        : showAllList.length == 0 && sortMachineName != ''
            ? EmptyState(name: 'emptyData')
            : GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: showAllList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 16),
                itemBuilder: (BuildContext context, int index) {
                  final double a = double.parse(showAllList[index].price.toString());
                  final double b = a / 100.0;
                  return ProductCard(
                    categoryName: 'collars'.tr,
                    image: showAllList[index].image!,
                    name: showAllList[index].name!,
                    price: b.toString(),
                    id: showAllList[index].id!,
                    downloadable: widget.name == 'Ýakalar' ? true : false,
                    createdAt: showAllList[index].createdAt!,
                  );
                },
              );
  }

  Widget productGridView() {
    return loading == false
        ? Loading()
        : showAllListProducts.length == 0 && sortMachineName != ''
            ? EmptyState(name: 'emptyData')
            : GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: showAllListProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 16),
                itemBuilder: (BuildContext context, int index) {
                  final double a = double.parse(showAllListProducts[index].price.toString());
                  final double b = a / 100.0;
                  return ProductCard(
                    categoryName: widget.name.tr,
                    image: showAllListProducts[index].image!,
                    name: showAllListProducts[index].name!,
                    price: b.toString(),
                    id: showAllListProducts[index].id!,
                    downloadable: widget.name == 'Ýakalar' ? true : false,
                    createdAt: showAllListProducts[index].createdAt!,
                  );
                },
              );
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
      actions: [_leftSideAppBar()],
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconlyLight.arrowLeftCircle,
          color: Colors.black,
        ),
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
        header: const MaterialClassicHeader(
          color: kPrimaryColor,
        ),
        child: widget.name == 'Ýakalar' ? collarGridView() : productGridView(),
      ),
    );
  }

  int value = 0;
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
                        sortMachineName = sortData[index]['sort_column'];
                        sortMachineID = 0;
                        controller.clear();
                        controller1.clear();
                        showAllList.clear();
                        showAllListProducts.clear();
                        loading = false;

                        setState(() {});
                        getData();

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
              sortMachineName = 'selectMachine'.tr;
              defaultBottomSheet(
                name: 'Filter'.tr,
                child: StatefulBuilder(
                  builder: (context, setStatee) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('selectMachine'.tr, style: const TextStyle(color: Colors.grey, fontFamily: normsProLight, fontSize: 14)),
                                  Text(sortMachineName, style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18))
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
                                        return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: ErrorState(
                                            onTap: () {
                                              AboutUsService().getFilterElements();
                                            },
                                          ),
                                        );
                                      } else if (snapshot.data == null) {
                                        return Center(
                                          child: EmptyState(
                                            name: 'emptyData',
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
                                                  setStatee(() {
                                                    sortMachineName = snapshot.data![index].name!;
                                                    sortMachineID = snapshot.data![index].id!;
                                                  });

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
                          ),
                          Divider(
                            color: kPrimaryColor.withOpacity(0.4),
                            thickness: 2,
                          ),
                          twoTextEditingField(controller1: controller, controller2: controller1),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: AgreeButton(
                              onTap: () {
                                if (sortMachineName == 'selectMachine') sortMachineName = '';
                                showAllList.clear();
                                showAllListProducts.clear();
                                page = 1;
                                loading = false;

                                setState(() {});
                                getData();
                                Get.back();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
