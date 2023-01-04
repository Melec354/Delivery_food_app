import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/controllers/auth_contoller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/account_widget.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        Get.find<LocationController>().getUserAddress();
      } else {
        Get.find<LocationController>().getAddressList();
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        var userModel;
        if (userController.isLoading) {
          userModel = userController.userModel;
        }

        return userLoggedIn
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        //profile icon
                        AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height15 * 5,
                          size: Dimensions.height15 * 10,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //name
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(text: userModel.name!)),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                //phone
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(text: userModel.phone!)),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                //email
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(text: userModel.email!)),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                //address
                                GetBuilder<LocationController>(
                                    builder: (locationController) {
                                  String bigAddressText = '';
                                  if (userLoggedIn &&
                                      locationController.addressList.isEmpty) {
                                    bigAddressText = 'Fill in your address';
                                  } else {
                                    bigAddressText = 'Your address';
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.getAddressPage());
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: bigAddressText)),
                                  );
                                }),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                //message
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.message_outlined,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(text: 'Messages')),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      Get.offNamed(RouteHelper.getSignInPage());
                                      Get.find<LocationController>()
                                          .clearAddressList();
                                    }
                                  },
                                  child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(text: 'Logout')),
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const CustomLoader())
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height30 * 12,
                    margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/image/login.png'))),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.height30 * 3,
                      margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Center(
                        child: BigText(
                          text: 'Sign in',
                          color: Colors.white,
                          size: Dimensions.font26,
                        ),
                      ),
                    ),
                  ),
                ],
              ));
      }),
    );
  }
}
