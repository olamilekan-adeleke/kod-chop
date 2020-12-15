import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersModel {
  String id;
  String userId;
  Timestamp timestamp;
  List orders;
  int numberOfItem;
  int amountPaid;
  Map address;
  int status;

  OrdersModel({
    @required this.id,
    @required this.userId,
    @required this.timestamp,
    @required this.orders,
    @required this.numberOfItem,
    @required this.amountPaid,
    @required this.address,
    @required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userId': this.userId,
      'timestamp': this.timestamp,
      'orders': this.orders,
      'numberOfItem': this.numberOfItem,
      'amountPaid': this.amountPaid,
      'address': this.address,
      'status': this.status,
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return new OrdersModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      timestamp: map['timestamp'] as Timestamp,
      orders: map['orders'] as List,
      numberOfItem: map['numberOfItem'] as int,
      amountPaid: map['amountPaid'] as int,
      address: map['address'] as Map,
      status: map['status'] as int,
    );
  }
}
