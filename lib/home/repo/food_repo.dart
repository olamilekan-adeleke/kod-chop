import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kod_chop/home/model/food_model.dart';
import 'package:kod_chop/local_db/hive_methods.dart';

class FoodRepo {
  CollectionReference _foodRef =
      FirebaseFirestore.instance.collection('foodItems');
  CollectionReference _orderRef =
      FirebaseFirestore.instance.collection('orders');

  Future<List<FoodItemModel>> getFood(FoodTypeEnum foodType) async {
    List<FoodItemModel> foodList = [];

    try {
      Query query = _foodRef.orderBy('foodName');

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

  Stream<QuerySnapshot> orderStream() async* {
    String userUid = await HiveMethods().getUserUid();
    yield* _orderRef
        .where('userId', isEqualTo: userUid)
        .orderBy('timestamp')
        .snapshots();
  }

  Future getFoodByKeyword(String keyword) async {
    List<FoodItemModel> _foodList = [];

    try {
      QuerySnapshot querySnapshot =
          await _foodRef.where('searchKeys', arrayContains: keyword).get();

      _foodList = querySnapshot.docs.map((e) {
        Map data = e.data();
        return FoodItemModel.fromMap(data.cast());
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.message);
    }

    return _foodList;
  }
}
