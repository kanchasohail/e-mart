import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widgets/bg_widget.dart';
import 'package:emart/common_widgets/progress_indicator.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/auth_screen/login_screen.dart';
import 'package:emart/views/profile_screen/components/details_card.dart';
import 'package:emart/views/profile_screen/edit_profile_screen.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());
    print("Current user ************** ${currentUser?.uid}");
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FireStoreServices.getUser(currentUser?.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return progressIndicator();
        } else {
          var data = snapshot.data?.docs[0];
          return SafeArea(
            child: Column(
              children: [
                //Edit profile button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.edit,
                        color: whiteColor,
                      )).onTap(() {
                    profileController.nameController.text = data!['name'];
                    Get.to(() => EditProfileScreen(
                          data: data,
                        ));
                  }),
                ),
                // User details section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      data!['imageUrl'] == ''
                          ?  Image.asset(
                              imgProfile2,
                              height: 80,
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                      :Image.network(
                        data['imageUrl'],
                        height: 80,
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // "Dummy User"
                          "${data['name']}"
                              .text
                              .fontFamily(semibold)
                              .color(whiteColor)
                              .make(),
                          "${data['email']}".text.color(whiteColor).make(),
                        ],
                      )),
                      OutlinedButton(
                          onPressed: () async {
                            Get.put(AuthController()).logoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                            color: whiteColor,
                          )),
                          child: logOut.text
                              .color(whiteColor)
                              .fontFamily(semibold)
                              .make())
                    ],
                  ),
                ),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    detailsCard(
                        width: context.screenWidth / 3.4,
                        count: '${data['cart_count']}',
                        title: 'In your cart'),
                    detailsCard(
                        width: context.screenWidth / 3.4,
                        count: '${data['wishlist_count']}',
                        title: 'In your wishlist'),
                    detailsCard(
                        width: context.screenWidth / 3.4,
                        count: '${data['order_count']}',
                        title: 'Your orders'),
                  ],
                ),
                //Buttons Section

                ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            leading: Image.asset(
                              profileButtonsIcons[index],
                              width: 22,
                            ),
                            title: "${profileButtonsList[index]}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider(
                            color: lightGrey,
                          );
                        },
                        itemCount: profileButtonsList.length)
                    .box
                    .white
                    .shadowSm
                    .rounded
                    .margin(const EdgeInsets.all(12))
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .make()
                    .box
                    .color(redColor)
                    .make(),
              ],
            ),
          );
        }
      },
    )));
  }
}
