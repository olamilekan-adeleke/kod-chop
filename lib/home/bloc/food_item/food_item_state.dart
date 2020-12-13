part of 'food_item_bloc.dart';

abstract class FoodItemState extends Equatable {
  const FoodItemState();
}

class InitialFoodItemState extends FoodItemState {
  @override
  List<Object> get props => [];
}

class LoadingFoodItemState extends FoodItemState {
  @override
  List<Object> get props => [];
}

class LoadedFoodItemState extends FoodItemState {
  final List<FoodItemModel> foodList;

  LoadedFoodItemState(this.foodList);

  @override
  List<Object> get props => [];
}

class ErrorFoodItemState extends FoodItemState {
  final String message;

  ErrorFoodItemState(this.message);
  @override
  List<Object> get props => [];
}
