import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../domain/entities/user_model.dart';
import '../../domain/repositories/user_repository.dart';

final class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository({FirebaseFirestore? firestore})
    : _firestore =
          firestore ??
          FirebaseFirestore.instanceFor(
            app: Firebase.app(),
            databaseId: 'default',
          );

  static const _usersCollection = 'users';

  final FirebaseFirestore _firestore;

  @override
  Future<void> createUser({
    required String uid,
    required String email,
    required String name,
  }) => _firestore
      .collection(_usersCollection)
      .doc(uid)
      .set({
        'id': uid,
        'email': email.trim(),
        'name': name.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      })
      .timeout(const Duration(seconds: 15));

  @override
  Future<UserModel?> getUser(String uid) async {
    final snapshot = await _firestore
        .collection(_usersCollection)
        .doc(uid)
        .get();
    final data = snapshot.data();
    if (!snapshot.exists || data == null) return null;

    return UserModel(
      id: data['id'] as String,
      email: data['email'] as String,
      name: data['name'] as String,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }
}
