import 'package:flutter/material.dart';

enum FoodTypeEnum { CookedFood, Snacks, Drinks, All }

class FoodItemModel {
  String foodName;
  int price;
  String description;
  double rating;
  FoodTypeEnum foodType;
  String imageUrl;
  List searchKeys;

  FoodItemModel({
    @required this.foodName,
    @required this.price,
    @required this.description,
    @required this.rating,
    @required this.foodType,
    @required this.imageUrl,
    this.searchKeys,
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

    List _searchList = [];

    this.foodName.split(' ').toList().forEach((element) {
      _searchList.add(element.toLowerCase());
    });

    return {
      'foodName': this.foodName,
      'price': this.price,
      'description': this.description,
      'rating': this.rating,
      'foodType': _foodType,
      'imageUrl': this.imageUrl,
      'searchKeys': _searchList,
    };
  }

  factory FoodItemModel.fromMap(Map<String, dynamic> map) {
    FoodTypeEnum _foodType;

    if (map['foodType'] == 'cookedFood') {
      _foodType = FoodTypeEnum.CookedFood;
    } else if (map['foodType'] == 'snacks') {
      _foodType = FoodTypeEnum.Snacks;
    }
    if (map['foodType'] == 'drinks') {
      _foodType = FoodTypeEnum.Drinks;
    }

    return new FoodItemModel(
      foodName: map['foodName'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
      rating: map['rating'] as double,
      foodType: _foodType,
      imageUrl: map['imageUrl'] as String,
      searchKeys: map['searchKeys'] as List,
    );
  }
}
