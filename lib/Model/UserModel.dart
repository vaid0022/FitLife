import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String createAt;
  final String password;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.createAt,
    required this.password
  });

  // Convert Firebase document in to user object

  factory UserModel.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String,dynamic>;

    return  UserModel(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      createAt: data['createAt'] ?? '',
      password: data['password'] ?? '',

      );
  }
}
