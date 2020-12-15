import 'package:flutter/material.dart';

class CheckOutPage extends StatelessWidget {
  final int totalAmount;

  const CheckOutPage({Key key, this.totalAmount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Total: $totalAmount')),
    );
  }
}
