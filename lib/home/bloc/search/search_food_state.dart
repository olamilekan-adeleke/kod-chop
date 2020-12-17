part of 'search_food_bloc.dart';

abstract class SearchFoodState extends Equatable {
  const SearchFoodState();
}

class InitialSearchFoodState extends SearchFoodState {
  @override
  List<Object> get props => [];
}

class LoadingSearchFoodState extends SearchFoodState {
  @override
  List<Object> get props => [];
}

class LoadedSearchFoodState extends SearchFoodState {
  final List<FoodItemModel> foodList;

  LoadedSearchFoodState(this.foodList);
  @override
  List<Object> get props => [foodList];
}

class ErrorSearchFoodState extends SearchFoodState {
  final String message;

  ErrorSearchFoodState(this.message);
  @override
  List<Object> get props => [message];
}

