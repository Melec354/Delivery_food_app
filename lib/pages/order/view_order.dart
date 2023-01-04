import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/utils/styles.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (!orderController.isLoading) {
          late List<OrderModel> orderList;
          if (orderController.currentOrderList.isNotEmpty) {
            orderList = isCurrent
                ? orderController.currentOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          } else {
            return Text('Empty list');
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10 / 5,
                vertical: Dimensions.height10 / 5,
              ),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (() {}),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                right: Dimensions.width10,
                                left: Dimensions.width10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('order ID',
                                        style: robotoRegular.copyWith(
                                            fontSize: Dimensions.font12)),
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                    Text('#${orderList[index].id}')
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width10,
                                            vertical: Dimensions.width10 / 2),
                                        decoration: BoxDecoration(
                                            color: AppColors.mainColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 3)),
                                        child: Text(
                                            '${orderList[index].orderStatus}',
                                            style: robotoMedium.copyWith(
                                                fontSize: Dimensions.font12,
                                                color: Theme.of(context)
                                                    .cardColor))),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width10,
                                            vertical: Dimensions.width10 / 2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 3),
                                            border: Border.all(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/image/tracking.png',
                                              height: Dimensions.height20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10 / 2,
                                            ),
                                            Text('track order',
                                                style: robotoMedium.copyWith(
                                                    fontSize: Dimensions.font12,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
        } else {
          return const CustomLoader();
        }
      }),
    );
  }
}
