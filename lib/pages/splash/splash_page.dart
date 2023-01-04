import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/auth_contoller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);
    // Get.find<AuthController>().clearSharedData();
    if (Get.find<AuthController>().userLoggedIn()) {
      Timer(Duration(seconds: 2), () => Get.offNamed(RouteHelper.getInitial()));
    } else {
      Timer(Duration(seconds: 2),
          () => Get.offNamed(RouteHelper.getSignInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/image/logo1.png',
                width: Dimensions.splasgImg,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/image/logo2.png',
              width: Dimensions.splasgImg,
            ),
          )
        ],
      ),
    );
  }
}
