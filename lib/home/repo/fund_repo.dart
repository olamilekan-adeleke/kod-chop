import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:kod_chop/auth/model/user_model.dart';
import 'package:kod_chop/home/model/orders_model.dart';
import 'package:kod_chop/local_db/hive_methods.dart';

import '../../constant.dart';

class FundWallet {
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().microsecondsSinceEpoch}';
  }

  Future<String> createAccessCode(skTest, _getReference) async {
    // skTest -> Secret key
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $skTest'
    };

    Map data = {
      "amount": 600,
      "email": "johnsonoye34@gmail.com",
      "reference": _getReference
    };

    String payload = json.encode(data);
    http.Response response = await http.post(
      'https://api.paystack.co/transaction/initialize',
      headers: headers,
      body: payload,
    );

    final Map _data = jsonDecode(response.body);
    String accessCode = _data['data']['access_code'];

    return accessCode;
  }

  Future<void> _verifyOnServer(String reference,
      {@required BuildContext context}) async {
    String skTest = secretKey;

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $skTest',
      };

      http.Response response = await http.get(
        'https://api.paystack.co/transaction/verify/' + reference,
        headers: headers,
      );

      final Map body = json.decode(response.body);

      if (body['data']['status'] == 'success') {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Payment sucessfull'),
          backgroundColor: Colors.green,
        ));
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Error Occured')));
      }
    } catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Err: $e')));
    }
  }

  Future chargeCard({
    @required int price,
    @required BuildContext context,
    @required Map address,
  }) async {
    UserModel userData = await HiveMethods().getUserDataInModel();

    Charge charge = Charge()
      ..amount = (price * 100).toInt()
      ..reference = _getReference()
      ..email = userData.email;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status == true) {
      await _verifyOnServer(response.reference, context: context);
      saveOrder(price, address);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Order Confirm'),
          backgroundColor: Colors.green,
        ),
      );

      await Hive.box('cartData').clear();
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      print('error');
    }
  }

  Future<void> saveOrder(int amount, Map address) async {
    String userUid = await HiveMethods().getUserUid();
    List orderList = Hive.box('cartData').values.toList();
    CollectionReference orderCollectionRef =
        FirebaseFirestore.instance.collection('orders');

    try {
      DocumentReference orderRef = orderCollectionRef.doc();

      OrdersModel ordersModel = OrdersModel(
        id: orderRef.id,
        timestamp: Timestamp.now(),
        orders: orderList,
        numberOfItem: orderList.length,
        amountPaid: amount,
        address: address,
        userId: userUid,
        status: 0,
      );

      debugPrint(ordersModel.toMap().toString());

      await orderRef.set(ordersModel.toMap());
    } catch (e) {
      print(e);
    }
  }
}
