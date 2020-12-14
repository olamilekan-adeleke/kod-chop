import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kod_chop/home/ui/view/home_page_views.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size size;
  Box cartBox;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: homeBodyUiList(),
      ),
    );
  }

  Widget homeBodyUiList() {
    size = MediaQuery.of(context).size;
    cartBox = Hive.box('cartData');

    return Container(
      height: size.height,
      child: Column(
        children: [
          HomePageHeader(size: size),
          SizedBox(height: 15.0),
          Row(
            children: [
              HomePageSearchBar(size: size),
              HomeCartIcon(size: size, cartBox: cartBox),
            ],
          ),
          SizedBox(height: 15.0),
          HomePageOptions(size: size),
          SizedBox(height: 5.0),
          HomePageFoodItemView(size: size, cartBox: cartBox)
        ],
      ),
    );
  }
}
