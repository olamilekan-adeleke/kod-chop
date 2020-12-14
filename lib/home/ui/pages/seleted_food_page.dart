import 'package:flutter/material.dart';
import 'package:kod_chop/home/model/food_model.dart';
import 'package:kod_chop/home/ui/view/selected_food_page_view.dart';

class SelectedFoodPage extends StatelessWidget {
  final FoodItemModel foodItem;

  const SelectedFoodPage({Key key, @required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SelectedFoodImage(size: size, imageUrl: foodItem.imageUrl),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SelectedFoodDetails(size: size, foodItem: foodItem),
        ),
      ],
    );
  }
}
