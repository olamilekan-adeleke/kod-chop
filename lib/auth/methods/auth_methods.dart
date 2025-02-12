import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../auth/model/login_model.dart';
import '../../auth/model/user_model.dart';
import '../../local_db/hive_methods.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection('userData');

  LoginUserModel userFromFirebase(User user) {
    return user != null ? LoginUserModel(uid: user.uid) : null;
  }

  Stream<LoginUserModel> get userStream {
    /// emit a stream of user current state(e.g emit an event when the user
    /// log out so the UI can be notify and update as needed or emit a event when
    /// a user log in so the UI can also be updated

    return auth.authStateChanges().map(userFromFirebase);
  }

  Future<dynamic> loginWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = result.user;
      await getUserDetails(uid: user.uid);

      return userFromFirebase(user);
    } on SocketException {
      debugPrint('No Internet Connection!');
      throw Exception('Erro: No Internet Connection!');
    } catch (e, s) {
      print(e);
      print(e.message);
      print(s);
      throw Exception('Error: ${e.message}');
    }
  }

  Future registerUserWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String fullName,
    @required int phoneNumber,
  }) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = result.user;

      UserModel userData = UserModel(
        uid: user.uid,
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        profilePicUrl: null,
        timestamp: Timestamp.now(),
      );

      await checkPhoneNumber(phoneNumber: userData.phoneNumber)
          .then((exist) async {
        /// check if phone number is already taken.
        ///
        if (exist) {
          throw Exception('Phone Number Already Exist');
        } else {
          await writeUserDataToDataBase(userData: userData);
          await HiveMethods().saveUserDataToLocalDb(userData: userData.toMap());
        }
      });

      return userFromFirebase(user);
    } catch (e, s) {
      debugPrint(e);
      debugPrint(s.toString());
      throw Exception('Erro: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception('Erro: $e');
    }
  }

  Future<void> resetEmail({@required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception('Erro: $e');
    }
  }

  Future<bool> checkPhoneNumber({@required int phoneNumber}) async {
    bool phoneNumberExist = false;
    await userCollectionRef
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.length > 1) {
        phoneNumberExist = true;
      }
    });

    return phoneNumberExist;
  }

  Future<void> writeUserDataToDataBase({@required UserModel userData}) async {
    DocumentReference userRef = userCollectionRef.doc(userData.uid);

    await userRef.set(userData.toMap());
  }

  Future<UserModel> getUserDetails({@required String uid}) async {
    UserModel user;

    try {
      DocumentSnapshot document = await userCollectionRef.doc(uid).get();
      user = UserModel.fromMap(document.data());
      await HiveMethods().saveUserDataToLocalDb(userData: user.toMap());
    } on SocketException {
      throw Exception('No Internet Connection!');
    } catch (e, s) {
      print(e);
      print(s);
      throw Exception('Error: $e');
    }

    return user;
  }
}
