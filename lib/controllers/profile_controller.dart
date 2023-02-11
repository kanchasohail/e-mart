import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImagePath = ''.obs;
  var profileImageLink = '';

  var isLoading = false.obs;

//Text editing controller
  TextEditingController nameController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  changeImage(BuildContext context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var fileName = basename(profileImagePath.value);
    var destination = 'images/${currentUser?.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile(
      {required String name,
      required String password,
      required String imgUrl}) async {
    var store = fireStore.collection(userCollection).doc(currentUser?.uid);
    await store.set({
      'name': name,
      'password': password,
      'imageUrl': imgUrl,
    }, SetOptions(merge: true));
    isLoading.value = false;
  }

  changeAuthPassword(
      {required String email,
      required String password,
      required String newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser?.reauthenticateWithCredential(cred).then((value) {
      currentUser?.updatePassword(newPassword);
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
