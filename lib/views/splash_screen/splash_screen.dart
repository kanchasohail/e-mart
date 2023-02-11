import 'package:get/get.dart';

import 'package:emart/consts/consts.dart';

import '../../common_widgets/app_logo_widget.dart';

import 'package:emart/views/auth_screen/login_screen.dart';

import '../home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _changeScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      // Get.to(() => const LoginScreen());

      if (currentUser == null && mounted) {
        Get.to(() => const LoginScreen());
      } else {
        Get.to(() => Home());
      }
    });
  }

  @override
  void initState() {
    _changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.semiBold.white.make(),
            30.heightBox
          ],
        ),
      ),
    );
  }
}
