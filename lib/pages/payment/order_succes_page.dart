import 'package:flutter/material.dart';
import 'package:food_app/base/custom_buttom.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderId;
  final int status;
  const OrderSuccessPage(
      {Key? key, required this.orderId, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1));
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                status == 1
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_outlined,
                size: Dimensions.height20 * 5,
                color: AppColors.mainColor,
              ),
              // Image.asset(
              //   status == 1
              //       ? 'assets/image/checked.png'
              //       : 'assets/image/warning.png',
              //   width: Dimensions.height20 * 5,
              //   height: Dimensions.height20 * 5,
              // ),
              SizedBox(
                height: Dimensions.height45,
              ),
              Text(
                status == 1
                    ? 'Your placed order successfully'
                    : 'Your order failed',
                style: TextStyle(fontSize: Dimensions.font20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height20,
                    vertical: Dimensions.height20),
                child: Text(
                  status == 1 ? 'Successful order' : 'Failed order',
                  style: TextStyle(
                      fontSize: Dimensions.font16,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height20),
                child: CustomButtom(
                  buttonText: 'Back to home',
                  onPressed: () => Get.offAllNamed(RouteHelper.getInitial()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
