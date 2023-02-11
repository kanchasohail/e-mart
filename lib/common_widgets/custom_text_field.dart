import 'package:emart/consts/consts.dart';

Widget customTextField(
    {required String title,
    required String hint,
    required TextEditingController controller,
    bool? isPass,
    bool? isEmail}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass != null && isPass == true ? true : false,
        keyboardType: isEmail != null && isEmail == true
            ? TextInputType.emailAddress
            : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
            hintStyle:
                const TextStyle(fontFamily: semibold, color: textfieldGrey),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      ),
      5.heightBox
    ],
  );
}
