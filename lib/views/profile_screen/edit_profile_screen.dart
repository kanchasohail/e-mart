import 'dart:io';

import 'package:emart/common_widgets/custom_text_field.dart';
import 'package:emart/common_widgets/our_button.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../common_widgets/bg_widget.dart';
import '../../consts/consts.dart';
import '../../common_widgets/progress_indicator.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key, this.data}) : super(key: key);
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());
    // var profileController = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //If data image and image path is empty
            data['imageUrl'] == '' && profileController.profileImagePath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                // if data image is not empty but image path in empty
                : data['imageUrl'] != '' &&
                        profileController.profileImagePath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    //if image path is not empty
                    : Image.file(
                        File(profileController.profileImagePath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
                title: "Change",
                color: redColor,
                onPress: () {
                  profileController.changeImage(context);
                },
                textColor: whiteColor),
            const Divider(),
            20.heightBox,
            customTextField(
                title: name,
                hint: nameHint,
                controller: profileController.nameController),
            10.heightBox,

            customTextField(
                title: oldPass,
                hint: passwordHint,
                controller: profileController.oldPassController,
                isPass: true),
            10.heightBox,
            customTextField(
                title: newPass,
                hint: passwordHint,
                controller: profileController.newPassController,
                isPass: true),
            20.heightBox,
            profileController.isLoading.value
                ? progressIndicator()
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        title: "Save",
                        color: redColor,
                        textColor: whiteColor,
                        onPress: () async {
                          profileController.isLoading.value = true;
                          // If image is not selected
                          if (profileController.profileImagePath.isNotEmpty) {
                            await profileController.uploadProfileImage();
                          } else {
                            profileController.profileImageLink =
                                data['imageUrl'];
                          }
                          //if old password match the database password
                          if (data['password'] ==
                              profileController.oldPassController.text) {
                            await profileController.changeAuthPassword(
                                email: data['email'],
                                password: profileController
                                    .oldPassController.text
                                    .trim(),
                                newPassword: profileController
                                    .newPassController.text
                                    .trim());
                            await profileController.updateProfile(
                                name: profileController.nameController.text
                                    .trim(),
                                password: profileController
                                    .oldPassController.text
                                    .trim(),
                                imgUrl: profileController.profileImageLink);
                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context,
                                msg: "The provided old password did not match");
                            profileController.isLoading.value = false;
                          }
                        }),
                  )
          ],
        )
            .box
            .white
            .shadowSm
            .rounded
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 15, left: 12, right: 12))
            .make(),
      ),
    ));
  }
}
