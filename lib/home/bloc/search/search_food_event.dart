part of 'search_food_bloc.dart';

abstract class SearchFoodEvent extends Equatable {
  const SearchFoodEvent();
}

class SearchFoodByKeyword extends SearchFoodEvent {
  final String keyword;

  SearchFoodByKeyword(this.keyword);
  @override
  List<Object> get props => [];
}
