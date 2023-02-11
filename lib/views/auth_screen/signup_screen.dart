import 'package:emart/common_widgets/progress_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../common_widgets/app_logo_widget.dart';
import '../../common_widgets/bg_widget.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../common_widgets/our_button.dart';
import '../home_screen/home.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  bool isChecked = false;
  var controller = Get.put(AuthController());

// Text editing controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetypeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordRetypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          appLogoWidget(),
          10.heightBox,
          "Join the $appname".text.size(18).white.fontFamily(bold).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    title: name, hint: nameHint, controller: nameController),
                customTextField(
                    title: email,
                    hint: emailHint,
                    controller: emailController,
                    isEmail: true),
                customTextField(
                    title: password,
                    hint: passwordHint,
                    controller: passwordController,
                    isPass: true),
                customTextField(
                    title: retypePass,
                    hint: passwordHint,
                    controller: passwordRetypeController,
                    isPass: true),
                // Align(
                //     alignment: FractionalOffset.centerRight,
                //     child: TextButton(
                //         onPressed: () {}, child: forgetPass.text.make())),
                5.heightBox,
                Row(
                  children: [
                    Checkbox(
                        checkColor: lightGolden,
                        activeColor: redColor,
                        value: isChecked,
                        onChanged: (newValue) {
                          setState(() {
                            isChecked = newValue!;
                          });
                        }),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                                fontFamily: regular, color: fontGrey)),
                        TextSpan(
                            text: termsAndConditions,
                            style: TextStyle(
                                fontFamily: regular, color: redColor)),
                        TextSpan(
                            text: " & ",
                            style: TextStyle(
                                fontFamily: regular, color: fontGrey)),
                        TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(
                                fontFamily: regular, color: redColor)),
                      ])),
                    )
                  ],
                ),
                5.heightBox,
                // ourButton(() {
                //
                // }, isChecked ? redColor : lightGrey, whiteColor,
                //         signup)
                controller.isLoading.value
                    ? progressIndicator()
                    : ourButton(
                            onPress: () async {
                              if (isChecked != false) {
                                FocusScope.of(context).unfocus();
                                controller.isLoading.value = true;
                                try {
                                  await controller
                                      .signupMethod(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          ctx: context)
                                      .then((value) {
                                    return controller.storeUserData(
                                        name: nameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        ctx: context);
                                  }).then((value) {
                                    VxToast.show(context, msg: loggedIn);
                                    Get.offAll(() => Home());
                                  });
                                } catch (e) {
                                  controller.isLoading.value = false;
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                }
                              }
                            },
                            color: isChecked ? redColor : lightGrey,
                            textColor: whiteColor,
                            title: signup)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alreadyHaveAnAccount.text.color(fontGrey).make(),
                    5.widthBox,
                    login.text
                        .fontFamily(bold)
                        .color(redColor)
                        .make()
                        .onTap(() {
                      Get.back();
                    }),
                  ],
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
