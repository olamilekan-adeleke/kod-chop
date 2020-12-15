import 'package:flutter/material.dart';

class AddressModel {
  String title;
  String streetName;
  String address;
  String state;
  bool isSelected;

  AddressModel({
    @required this.title,
    @required this.streetName,
    @required this.address,
    @required this.state,
    @required this.isSelected,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'streetName': this.streetName,
      'address': this.address,
      'state': this.state,
      'isSelected': this.isSelected,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return new AddressModel(
      title: map['title'] as String,
      streetName: map['streetName'] as String,
      address: map['address'] as String,
      state: map['state'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }
}
