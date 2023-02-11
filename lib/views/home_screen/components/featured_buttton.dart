import 'package:emart/consts/consts.dart';

Widget featuredButton({required String title , required String image}){
  return Row(
    children: [
      Image.asset(image , width: 60, fit: BoxFit.fill,),
      10.widthBox,
      title.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.width(200).margin(const EdgeInsets.symmetric(horizontal: 4)).white.padding(const EdgeInsets.all(4)).roundedSM.outerShadowSm.make();
}