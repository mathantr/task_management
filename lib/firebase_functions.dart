import 'package:cloud_firestore/cloud_firestore.dart';

// This function should only be accessible to admin users
Future<Object?> getUserInfo(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  return userSnapshot.data();
}
