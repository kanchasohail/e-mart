import 'package:emart/consts/consts.dart';

Widget ourButton ({onPress, Color? color, textColor, required String title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color ,
      padding: const EdgeInsets.all(12)
    ),
      onPressed: onPress, child: title.text.color(textColor).fontFamily(bold).make());
}