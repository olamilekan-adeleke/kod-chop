import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kod_chop/home/ui/view/check_out_page_view.dart';

class CheckOutPage extends StatelessWidget {
  final int totalAmount;

  const CheckOutPage({Key key, this.totalAmount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Box addressBox = Hive.box('addressData');

    return Column(
      children: [
        CheckOutAddressUi(size: size, addressBox: addressBox),
        CheckOutPaymentUi(amount: totalAmount, size: size),
      ],
    );
  }
}
