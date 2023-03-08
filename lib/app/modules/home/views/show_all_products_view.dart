import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yaka2/app/constants/constants.dart';
import 'package:yaka2/app/data/models/collar_model.dart';
import 'package:yaka2/app/data/services/category_service.dart';

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
  int page = 0;
  int limit = 10;

  List<CollarModel> showAllList = [];
  // List<CollarModel> showAllList = [];

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getData();
  }

  dynamic getData() async {
    final List<dynamic> list = await CategoryService().getCategoryByID(
      id: widget.id,
      parametrs: {
        'page': '${page}',
        'limit': '${limit}',
      },
    );

    final List<CollarModel> tryList = list.cast<CollarModel>();
    showAllList = showAllList + tryList;

    setState(() {});
  }

  void _onRefresh() {
    Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
    showAllList.clear();
    page = 1;
    getData();
  }

  void _onLoading() {
    Future.delayed(Duration(milliseconds: 1000));
    refreshController.loadComplete();
    page += 1;
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
      // actions: [_leftSideAppBar()],
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
        // child: productGridView(),
      ),
    );
  }

  // GridView productGridView() {
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: BouncingScrollPhysics(),
  //     itemCount: showAllListForProducts.length,
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 16),
  //     itemBuilder: (BuildContext context, int index) {
  //       final double a = double.parse(showAllListForProducts[index].price.toString());
  //       final double b = a / 100.0;
  //       return ProductCard(
  //         image: showAllListForProducts[index].image!,
  //         name: showAllListForProducts[index].name!,
  //         price: b.toString(),
  //         id: showAllListForProducts[index].id!,
  //         downloadable: widget.name == 'Ýakalar' ? true : false,
  //         createdAt: showAllListForProducts[index].createdAt!,
  //       );
  //     },
  //   );
  // }
}
