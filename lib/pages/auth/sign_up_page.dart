import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_snackbar.dart';
import 'package:food_app/controllers/auth_contoller.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    List<String> singUpImages = ['twitter.png', 'facebook.png', 'google.png'];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar('Type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Type in your phone number', title: 'Phone  number');
      } else if (email.isEmpty) {
        showCustomSnackBar('Type in your email', title: 'Email');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('Type in a valid email address',
            title: 'Valid email');
      } else if (password.isEmpty) {
        showCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password can not be less than six characters',
            title: 'Password');
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.25,
                      child: const Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 90,
                          backgroundImage: AssetImage('assets/image/logo1.png'),
                        ),
                      ),
                    ),
                    AppTextField(
                      textEditingController: emailController,
                      hintText: 'Email',
                      icon: Icons.email,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    AppTextField(
                      textEditingController: passwordController,
                      hintText: 'Password',
                      icon: Icons.password_sharp,
                      isObscure: true,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    AppTextField(
                      textEditingController: nameController,
                      hintText: 'Name',
                      icon: Icons.person,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    AppTextField(
                      textEditingController: phoneController,
                      hintText: 'Phone',
                      icon: Icons.phone,
                    ),
                    SizedBox(
                      height: Dimensions.height20 * 2,
                    ),
                    GestureDetector(
                      onTap: (() {
                        _registration(authController);
                      }),
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.screenHeight / 13,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.mainColor),
                        child: Center(
                          child: BigText(
                            text: 'Sign up',
                            size: Dimensions.font20 * 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    RichText(
                        text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: 'Have an account already?',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20))),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Sign up using one of the following methods',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font16))),
                    Wrap(
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: Dimensions.radius30,
                                  backgroundImage: AssetImage(
                                      'assets/image/' + singUpImages[index]),
                                ),
                              )),
                    )
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
