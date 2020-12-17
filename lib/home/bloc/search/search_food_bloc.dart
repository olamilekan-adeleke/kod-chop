import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kod_chop/home/model/food_model.dart';
import 'package:kod_chop/home/repo/food_repo.dart';

part 'search_food_event.dart';
part 'search_food_state.dart';

class SearchFoodBloc extends Bloc<SearchFoodEvent, SearchFoodState> {
  SearchFoodBloc() : super(InitialSearchFoodState());

  @override
  Stream<SearchFoodState> mapEventToState(
    SearchFoodEvent event,
  ) async* {
    if (event is SearchFoodByKeyword) {
      try {
        yield LoadingSearchFoodState();
        List<FoodItemModel> foodList =
            await FoodRepo().getFoodByKeyword(event.keyword);
        yield LoadedSearchFoodState(foodList);
      } catch (e) {
        yield ErrorSearchFoodState(e.toString());
      }
    }
  }
}
