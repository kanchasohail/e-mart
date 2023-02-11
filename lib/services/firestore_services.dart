import 'package:emart/consts/consts.dart';

class FireStoreServices {
  //Get users data
  static getUser(uid) {
    return fireStore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }
}
