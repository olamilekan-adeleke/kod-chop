import 'package:flutter/material.dart';
import 'package:kod_chop/home/ui/view/cart_page_view.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Cart',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        CartPageOrders(size: size),
        CartTotalAmountUi(size: size),
      ],
    );
  }
}
