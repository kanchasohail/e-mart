import 'package:emart/views/category_screen/category_details.dart';
import 'package:get/get.dart';

import '../../common_widgets/bg_widget.dart';
import '../../consts/consts.dart';
import '../../consts/lists.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: categoryImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  Image.asset(
                    categoryImages[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  "${categoriesList[index]}"
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make()
                ],
              ).box.white.roundedSM.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                Get.to(()=> CategoryDetails(title: "${categoriesList[index]}",));
              });
            }),
      ),
    ));
  }
}
