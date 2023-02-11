import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // Text Editing controllers for login screen
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Login method
  Future<UserCredential?> loginMethod({required BuildContext ctx}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      VxToast.show(ctx, msg: e.message.toString());
    }
    return userCredential;
  }

  // Sing up method
  Future<UserCredential?> signupMethod(
      {required String email,
      required String password,
      required BuildContext ctx}) async {
    UserCredential? userCredential;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(ctx, msg: e.message.toString());
    }
    return userCredential;
  }

  //Store user data
  storeUserData(
      {required String name,
      required String email,
      required String password,
      required BuildContext ctx}) async {
    DocumentReference store =
        fireStore.collection(userCollection).doc(currentUser?.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser?.uid,
      'cart_count': '00',
      'order_count': '00',
      'wishlist_count': '00',
    });
  }

  logoutMethod(BuildContext ctx) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(ctx, msg: e.toString());
    }
  }
}
