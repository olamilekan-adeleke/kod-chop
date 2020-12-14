import 'package:flutter/material.dart';
import 'package:kod_chop/home/model/food_model.dart';

class CartFoodItemModel {
  String foodName;
  int price;
  int numberOfPlate;
  String description;
  double rating;
  FoodTypeEnum foodType;
  String imageUrl;
  List searchKeys;
  List extras;

  CartFoodItemModel({
    @required this.foodName,
    @required this.price,
    @required this.numberOfPlate,
    @required this.description,
    @required this.rating,
    @required this.foodType,
    @required this.imageUrl,
    @required this.searchKeys,
    this.extras,
  });

  Map<String, dynamic> toMap() {
    String _foodType;

    if (this.foodType == FoodTypeEnum.CookedFood) {
      _foodType = 'cookedFood';
    } else if (this.foodType == FoodTypeEnum.Snacks) {
      _foodType = 'snacks';
    }
    if (this.foodType == FoodTypeEnum.Drinks) {
      _foodType = 'drinks';
    }

    return {
      'foodName': this.foodName,
      'price': this.price,
      'numberOfPlate': this.numberOfPlate,
      'description': this.description,
      'rating': this.rating,
      'foodType': _foodType,
      'imageUrl': this.imageUrl,
      'searchKeys': this.searchKeys,
      'extras': this.extras,
    };
  }

  factory CartFoodItemModel.fromMap(Map<String, dynamic> map) {
    FoodTypeEnum _foodType;

    if (map['foodType'] == 'cookedFood') {
      _foodType = FoodTypeEnum.CookedFood;
    } else if (map['foodType'] == 'snacks') {
      _foodType = FoodTypeEnum.Snacks;
    }
    if (map['foodType'] == 'drinks') {
      _foodType = FoodTypeEnum.Drinks;
    }

    return new CartFoodItemModel(
      foodName: map['foodName'] as String,
      price: map['price'] as int,
      numberOfPlate: map['numberOfPlate'] as int,
      description: map['description'] as String,
      rating: map['rating'] as double,
      foodType: _foodType,
      imageUrl: map['imageUrl'] as String,
      searchKeys: map['searchKeys'] as List,
      extras: map['extras'] as List,
    );
  }
}
