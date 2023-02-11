import 'package:emart/common_widgets/app_logo_widget.dart';
import 'package:emart/common_widgets/bg_widget.dart';
import 'package:emart/common_widgets/custom_text_field.dart';
import 'package:emart/common_widgets/our_button.dart';
import 'package:emart/common_widgets/progress_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/views/auth_screen/signup_screen.dart';
import 'package:emart/views/home_screen/home.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          appLogoWidget(),
          10.heightBox,
          "Log into $appname".text.size(18).white.fontFamily(bold).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    title: email,
                    hint: emailHint,
                    controller: authController.emailController,
                    isEmail: true),
                customTextField(
                    title: password,
                    hint: passwordHint,
                    controller: authController.passwordController,
                    isPass: true),
                Align(
                    alignment: FractionalOffset.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPass.text.make())),
                5.heightBox,
                // ourButton(() {
                //   Get.to(() => Home());
                // }, redColor, whiteColor, login)
                authController.isLoading.value
                    ? progressIndicator()
                    : ourButton(
                            onPress: () async {
                              FocusScope.of(context).unfocus();
                              authController.isLoading.value = true;
                              await authController
                                  .loginMethod(ctx: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedIn);
                                  Get.offAll(() => Home());
                                } else {
                                  authController.isLoading.value = false;
                                }
                              });
                            },
                            color: redColor,
                            textColor: whiteColor,
                            title: login)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                // ourButton(() {
                //   Get.to(() => const SingUpScreen());
                // }, lightGolden, redColor, signup)
                ourButton(
                        onPress: () {
                          Get.to(() => const SingUpScreen());
                        },
                        color: redColor,
                        textColor: lightGolden,
                        title: signup)
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                )
              ],
            )
                .box
                .rounded
                .width(context.screenWidth - 70)
                .padding(const EdgeInsets.all(16))
                .white
                .shadowSm
                .make(),
          )
        ],
      )),
    ));
  }
}
