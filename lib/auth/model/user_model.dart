import 'package:flutter/material.dart';

class UserModel {
  String uid;
  String email;
  String fullName;
  int phoneNumber;
  String profilePicUrl;
  var timestamp;

  UserModel({
    @required this.uid,
    @required this.email,
    @required this.fullName,
    @required this.phoneNumber,
    @required this.profilePicUrl,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'fullName': this.fullName,
      'phoneNumber': this.phoneNumber,
      'profilePicUrl': this.profilePicUrl,
      'timestamp': this.timestamp,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return new UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as int,
      profilePicUrl: map['profilePicUrl'] as String,
      timestamp: map['timestamp'],
    );
  }
}
