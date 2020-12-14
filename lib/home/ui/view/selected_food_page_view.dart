import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kod_chop/constant.dart';
import 'package:kod_chop/home/model/food_cart_model.dart';
import 'package:kod_chop/home/model/food_model.dart';
import 'package:kod_chop/local_db/hive_methods.dart';

class SelectedFoodImage extends StatelessWidget {
  final Size size;
  final String imageUrl;

  const SelectedFoodImage({Key key, this.size, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image(),
        Positioned(
          left: 10.0,
          top: 10.0,
          child: backIcon(context),
        ),
      ],
    );
  }

  Widget backIcon(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: size.height * 0.06,
        width: size.height * 0.06,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(Icons.arrow_back, size: 22, color: Colors.white),
        ),
      ),
    );
  }

  Widget image() {
    return Container(
      height: size.height * 0.45,
      width: size.width,
      color: Colors.grey[200],
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (_, string, progress) {
          return Center(
            child: CircularProgressIndicator(
              value: progress.progress,
            ),
          );
        },
      ),
    );
  }
}

class SelectedFoodDetails extends StatelessWidget {
  final Size size;
  final FoodItemModel foodItem;
  final Box cartBox;

  SelectedFoodDetails({Key key, this.size, this.foodItem, this.cartBox}) : super(key: key);
  final ValueNotifier<int> priceValue = ValueNotifier<int>(0);
  final ValueNotifier<int> numberOfPlateValue = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    priceValue.value = foodItem.price;

    return Container(
      height: size.height * 0.60,
      width: size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          foodNameAndRatingUi(context),
          foodDes(),
          Spacer(),
          priceAndAmountInfo(context),
          Spacer(),
          button(context),
        ],
      ),
    );
  }

  Widget priceAndAmountInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      height: size.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          price(),
          divider(),
          numberOfPlate(context),
        ],
      ),
    );
  }

  Widget button(BuildContext context) {
    return InkWell(
      onTap: () async {
        CartFoodItemModel cartItem = CartFoodItemModel(
          foodName: foodItem.foodName,
          price: priceValue.value,
          numberOfPlate: numberOfPlateValue.value,
          description: foodItem.description,
          rating: foodItem.rating,
          foodType: foodItem.foodType,
          imageUrl: foodItem.imageUrl,
          searchKeys: foodItem.searchKeys,
        );

        await cartBox.add(cartItem.toMap());
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Addde To Cart'),
          backgroundColor: Colors.green,
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        height: size.height * 0.07,
        width: size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            'Add To Cart',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget foodDes() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      height: size.height * 0.2,
      width: size.width,
      child: SingleChildScrollView(
        child: Text(
          '${foodItem.description}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget foodNameAndRatingUi(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 0.0),
      height: size.height * 0.08,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${foodItem.foodName}',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          rateBuilder(context, foodItem.rating.round() - 1),
        ],
      ),
    );
  }

  Widget rateBuilder(BuildContext context, int count) {
    if (count == 1) {
      return Row(
        children: [
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Colors.grey),
          Icon(Icons.star, size: 18, color: Colors.grey),
          Icon(Icons.star, size: 18, color: Colors.grey),
          Icon(Icons.star, size: 18, color: Colors.grey),
        ],
      );
    } else if (count == 2) {
      return Row(
        children: [
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Colors.grey),
          Icon(Icons.star, size: 18, color: Colors.grey),
          Icon(Icons.star, size: 18, color: Colors.grey),
        ],
      );
    } else if (count == 3) {
      return Row(
        children: [
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Colors.grey),
          Icon(Icons.star, size: 18, color: Colors.grey),
        ],
      );
    } else if (count == 4) {
      return Row(
        children: [
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Colors.grey),
        ],
      );
    } else if (count == 5) {
      return Row(
        children: [
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
          Icon(Icons.star, size: 18, color: Theme.of(context).primaryColor),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget numberOfPlate(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (numberOfPlateValue.value > 1) {
              numberOfPlateValue.value = numberOfPlateValue.value - 1;
              priceValue.value = foodItem.price * numberOfPlateValue.value;
            }
          },
          child: Container(
            height: size.height * 0.06,
            width: size.width * 0.08,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: Center(
              child: Icon(
                Icons.remove,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
          child: ValueListenableBuilder(
            valueListenable: numberOfPlateValue,
            builder: (_, value, child) {
              return Text(
                '$value',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              );
            },
          ),
        ),
        InkWell(
          onTap: () {
            if (numberOfPlateValue.value < 10) {
              numberOfPlateValue.value = numberOfPlateValue.value + 1;
              priceValue.value = foodItem.price * numberOfPlateValue.value;
            }
          },
          child: Container(
            height: size.height * 0.06,
            width: size.width * 0.08,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget price() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Price',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: priceValue,
          builder: (context, value, child) {
            return Text(
              '\$ ${moneyFormatter.format(value)}',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget divider() {
    return Container(
      height: size.height * 0.10,
      width: size.width * 0.004,
      color: Colors.grey[300],
    );
  }
}
