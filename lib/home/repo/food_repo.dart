import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kod_chop/home/model/food_model.dart';

class FoodRepo {
  CollectionReference foodRef =
      FirebaseFirestore.instance.collection('foodItems');

  Future<List<FoodItemModel>> getFood(FoodTypeEnum foodType) async {
    List<FoodItemModel> foodList = [];

    try {
      Query query = foodRef.orderBy('foodName');

      if (foodType == FoodTypeEnum.All) {
        // pass
      } else if (foodType == FoodTypeEnum.CookedFood) {
        query = query.where('foodType', isEqualTo: 'cookedFood');
      } else if (foodType == FoodTypeEnum.Snacks) {
        query = query.where('foodType', isEqualTo: 'snacks');
      } else if (foodType == FoodTypeEnum.Drinks) {
        query = query.where('foodType', isEqualTo: 'drinks');
      }

      QuerySnapshot querySnapshot = await query.get();

      querySnapshot.docs.forEach((element) {
        FoodItemModel _foodItem = FoodItemModel.fromMap(element.data());
        foodList.add(_foodItem);
      });
    } catch (e) {
      throw Exception(e.toString());
    }

    return foodList;
  }
}
