import 'package:flutter/material.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/utils/styles.dart';
import 'package:get/get.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int index;
  const PaymentOptionButton(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      bool selectedIndex = orderController.paymentIndex == index;

      return InkWell(
        onTap: () => orderController.setPaymentIndex(index),
        child: Ink(
          padding: EdgeInsets.only(bottom: Dimensions.height10 / 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ]),
          child: ListTile(
            leading: Icon(
              icon,
              size: Dimensions.height20 * 2,
              color: selectedIndex
                  ? AppColors.mainColor
                  : Theme.of(context).disabledColor,
            ),
            title: Text(title,
                style: robotoMedium.copyWith(
                  fontSize: Dimensions.font20,
                )),
            subtitle: Text(subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: robotoRegular.copyWith(
                  fontSize: Dimensions.font16,
                )),
            trailing: selectedIndex
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  )
                : null,
          ),
        ),
      );
    });
  }
}
