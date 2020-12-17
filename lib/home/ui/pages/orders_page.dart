import 'package:flutter/material.dart';
import 'package:kod_chop/home/ui/view/orders_page_view.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Orders', style: TextStyle(color: Colors.black)),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OrderPageBody(size: size);
  }
}
