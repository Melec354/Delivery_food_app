import 'package:flutter/material.dart';
import 'package:food_app/base/common_text_button.dart';
import 'package:food_app/base/no_data_page.dart';
import 'package:food_app/base/show_custom_snackbar.dart';
import 'package:food_app/controllers/auth_contoller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/pages/order/delivery_option.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/utils/styles.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/pages/order/payment_option_button.dart';
import 'package:food_app/widgets/small_test.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios_new,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_sharp,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            )),
        GetBuilder<CartController>(builder: (cartController) {
          return cartController.getItems.isNotEmpty
              ? Positioned(
                  top: Dimensions.height20 * 5,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (controller) {
                        List<CartModel> cartList = controller.getItems;
                        return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (context, index) {
                              CartModel cartModel = cartList[index];
                              return Container(
                                height: Dimensions.height20 * 5,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                            Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    cartModel.productModel);
                                        if (popularIndex >= 0) {
                                          Get.toNamed(
                                              RouteHelper.getPopularFood(
                                                  popularIndex, "cartPage"));
                                        } else {
                                          var recommendedIndex = Get.find<
                                                  RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(cartModel.productModel);

                                          if (recommendedIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    recommendedIndex,
                                                    "cartPage"));
                                          }
                                          if (recommendedIndex < 0) {
                                            Get.snackbar('History product',
                                                'Product review is not available  for history products',
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                colorText: Colors.white);
                                          }
                                        }
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        width: Dimensions.width20 * 5,
                                        height: Dimensions.height20 * 5,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    AppConstants.baseUrl +
                                                        AppConstants.uploadURL +
                                                        cartModel.img!),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.width10,
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: Dimensions.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: cartModel.name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(text: cartModel.name!),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    '\$ ${cartModel.price.toString()}',
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    right: Dimensions.width10,
                                                    left: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.addItem(
                                                            cartModel
                                                                .productModel!,
                                                            -1);
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2,
                                                    ),
                                                    BigText(
                                                        text: cartModel
                                                            .quantity!
                                                            .toString()),
                                                    SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: (() {
                                                        controller.addItem(
                                                            cartModel
                                                                .productModel!,
                                                            1);
                                                      }),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            });
                      }),
                    ),
                  ))
              : const NoDataPage(text: 'Your cart is empty');
        }),
      ]),
      bottomNavigationBar:
          GetBuilder<OrderController>(builder: (orderController) {
        textEditingController.text = orderController.orderNote;
        return GetBuilder<CartController>(builder: (controller) {
          return Container(
            height: Dimensions.bottomHeightBar + 50,
            padding: EdgeInsets.only(
              top: Dimensions.height10,
              bottom: Dimensions.height10,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2))),
            child: controller.getItems.isNotEmpty
                ? Column(
                    children: [
                      InkWell(
                        onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Ink(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.9,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        Dimensions.radius20),
                                                    topRight: Radius.circular(
                                                        Dimensions.radius20))),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions.width20,
                                                      right: Dimensions.width20,
                                                      top: Dimensions.height20),
                                                  height: 520,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const PaymentOptionButton(
                                                        icon: Icons.money,
                                                        index: 0,
                                                        subtitle:
                                                            'you pay after getting the delivery',
                                                        title:
                                                            'Cash on delivery',
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height10,
                                                      ),
                                                      const PaymentOptionButton(
                                                        icon: Icons
                                                            .paypal_outlined,
                                                        index: 1,
                                                        subtitle:
                                                            'safer and faster way of payment',
                                                        title:
                                                            'Digital payment',
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height30,
                                                      ),
                                                      Text(
                                                        'Delivery option',
                                                        style: robotoMedium,
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                                .height10 /
                                                            2,
                                                      ),
                                                      DeliveryOption(
                                                          value: 'delivery',
                                                          title:
                                                              'Home delivery',
                                                          amount: controller
                                                              .totalAmount,
                                                          isFree: false),
                                                      SizedBox(
                                                        height: Dimensions
                                                                .height10 /
                                                            2,
                                                      ),
                                                      const DeliveryOption(
                                                          value: 'take away',
                                                          title: 'Take away',
                                                          amount: 10.0,
                                                          isFree: true),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height20,
                                                      ),
                                                      Text(
                                                        'Additional info',
                                                        style: robotoMedium,
                                                      ),
                                                      AppTextField(
                                                        textEditingController:
                                                            textEditingController,
                                                        hintText: '',
                                                        icon: Icons.note,
                                                        maxLines: true,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                            .whenComplete(() => orderController.setOrderNote(
                                textEditingController.text.trim())),
                        child: const SizedBox(
                          width: double.maxFinite,
                          child: CommonTextButton(text: 'Payment'),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20,
                                right: Dimensions.width20,
                                left: Dimensions.width20),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                                BigText(text: '\$ ${controller.totalAmount}'),
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: (() async {
                                if (Get.find<AuthController>().userLoggedIn()) {
                                  await Get.find<UserController>()
                                      .getUserInfo();
                                  if (Get.find<LocationController>()
                                      .addressList
                                      .isEmpty) {
                                    Get.toNamed(RouteHelper.getAddressPage());
                                  } else {
                                    AddressModel addressModel =
                                        Get.find<LocationController>()
                                            .getUserAddress();
                                    List<CartModel> cartItems =
                                        Get.find<CartController>().getItems;
                                    UserModel userModel =
                                        Get.find<UserController>().userModel;
                                    PlaceOrderBody placeOrder = PlaceOrderBody(
                                        cart: cartItems,
                                        orderAmount: 100.00,
                                        distance: 10.0,
                                        scheduleAt: '',
                                        orderNote: orderController.orderNote,
                                        address: addressModel.address,
                                        latitude: addressModel.latitude,
                                        longitude: addressModel.longitude,
                                        contactPersonName: userModel.name ?? '',
                                        contactPersonNumber:
                                            userModel.phone ?? '',
                                        orderType: orderController.orderType,
                                        paymentMethod:
                                            orderController.paymentIndex == 0
                                                ? 'cash_on_delivery'
                                                : 'digital_payment');
                                    Get.find<OrderController>()
                                        .placeOrder(placeOrder, _callBack);
                                    // Get.offNamed(RouteHelper.getPaymentPage('100127',
                                    //     Get.find<UserController>().userModel.id!));

                                    // controller.addToHistory();
                                  }
                                } else {
                                  Get.toNamed(RouteHelper.getSignInPage());
                                }
                              }),
                              child: const CommonTextButton(
                                text: 'Check out',
                              )),
                        ],
                      ),
                    ],
                  )
                : Container(),
          );
        });
      }),
    );
  }

  void _callBack(bool isSuccess, String message, String orderId) {
    if (isSuccess) {
      Get.find<CartController>().clearItems();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderId, 'success'));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(
            orderId, Get.find<UserController>().userModel.id!));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
