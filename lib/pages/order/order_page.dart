import 'package:flutter/material.dart';
import 'package:food_app/controllers/auth_contoller.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/pages/order/view_order.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController tabController;
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = Get.find<AuthController>().userLoggedIn();
    tabController = TabController(length: 2, vsync: this);
    if (isLoggedIn) {
      Get.find<OrderController>().getOrderList();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My orders',
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        children: [
          SizedBox(
            width: Dimensions.screenWidth,
            height: Dimensions.height45,
            child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: 3,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: AppColors.yellowColor,
                controller: tabController,
                tabs: const [
                  Text('Current'),
                  Text('History'),
                ]),
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: const [
              ViewOrder(isCurrent: true),
              ViewOrder(isCurrent: false)
            ]),
          )
        ],
      ),
    );
  }
}
