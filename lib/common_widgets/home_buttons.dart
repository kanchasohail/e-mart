import '../consts/consts.dart';

Widget homeButton({required double width, required double height , required String icon , required String title , onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 26,
        ),
        10.heightBox,
        title.text.fontFamily(semibold).color(darkFontGrey).make()
      ],
    ).box.rounded.white.size(width, height).make(),
  );
}
