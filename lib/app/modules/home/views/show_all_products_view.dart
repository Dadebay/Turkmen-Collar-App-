import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/modules/buttons/agree_button.dart';
import 'package:yaka2/app/modules/buttons/product_card.dart';

import '../../../constants/widgets.dart';

class ShowAllProductsView extends StatefulWidget {
  const ShowAllProductsView(this.name, {Key? key}) : super(key: key);

  final String name;

  @override
  State<ShowAllProductsView> createState() => _ShowAllProductsViewState();
}

class _ShowAllProductsViewState extends State<ShowAllProductsView> {
  String name = 'Janome';
  int value = 0;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Padding leftSideAppBar() {
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
                      selectMachineType(),
                      Divider(
                        color: kPrimaryColor.withOpacity(0.4),
                        thickness: 2,
                      ),
                      twoTextEditingField(controller1: _controller, controller2: _controller1),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: AgreeButton(
                          onTap: () {
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

  Widget twoTextEditingField({required TextEditingController controller1, required TextEditingController controller2}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: Text('priceRange'.tr, style: const TextStyle(fontFamily: normsProRegular, fontSize: 19, color: Colors.black)),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontFamily: normsProMedium, fontSize: 18),
                  cursorColor: kPrimaryColor,
                  controller: controller1,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text('TMT', textAlign: TextAlign.center, style: TextStyle(fontFamily: normProBold, fontSize: 14, color: Colors.grey.shade400)),
                    ),
                    suffixIconConstraints: const BoxConstraints(minHeight: 15),
                    isDense: true,
                    hintText: 'minPrice'.tr,
                    hintStyle: TextStyle(fontFamily: normsProMedium, fontSize: 16, color: Colors.grey.shade400),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                    ),
                  ),
                ),
              ),
              Container(
                width: 15,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 2,
                color: Colors.grey,
              ),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontFamily: normsProMedium, fontSize: 18),
                  cursorColor: kPrimaryColor,
                  controller: controller2,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: Padding(padding: const EdgeInsets.only(right: 8), child: Text('TMT', textAlign: TextAlign.center, style: TextStyle(fontFamily: normProBold, fontSize: 14, color: Colors.grey.shade400))),
                    suffixIconConstraints: const BoxConstraints(minHeight: 15),
                    isDense: true,
                    hintText: 'maxPrice'.tr,
                    hintStyle: TextStyle(fontFamily: normsProMedium, fontSize: 16, color: Colors.grey.shade400),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius15,
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        elevation: 2,
        actions: [leftSideAppBar()],
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
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: 13,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductCard(
              index: index,
              downloadable: false,
              removeFavButton: false,
            ),
          ),
          staggeredTileBuilder: (index) => StaggeredTile.count(
            1,
            index % 2 == 0 ? 1.4 : 1.6,
          ),
        ),
      ),
    );
  }

  Padding selectMachineType() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('selectMachine'.tr, style: const TextStyle(color: Colors.grey, fontFamily: normsProLight, fontSize: 14)),
            Text(name.tr, style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 18)),
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
            contentPadding: const EdgeInsets.only(),
            content: Column(
              children: List.generate(
                5,
                (index) => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    divider(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          name = machineName[index];
                        });
                        Get.back();
                      },
                      child: Text(
                        machineName[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black, fontFamily: normsProRegular, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
