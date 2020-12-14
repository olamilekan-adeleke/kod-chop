import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartPage extends StatelessWidget {
  final Box cartBox;

  const CartPage({Key key, this.cartBox}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Cart page'),
    );
  }
}
