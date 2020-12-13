part of 'food_item_bloc.dart';

abstract class FoodItemEvent extends Equatable {
  const FoodItemEvent();
}

class GetFoodItemEvent extends FoodItemEvent {
  final FoodTypeEnum _foodType;

  GetFoodItemEvent(this._foodType);

  @override
  List<Object> get props => [];
}
