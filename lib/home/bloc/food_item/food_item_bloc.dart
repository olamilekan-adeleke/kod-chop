import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kod_chop/home/model/food_model.dart';
import 'package:kod_chop/home/repo/food_repo.dart';

part 'food_item_event.dart';
part 'food_item_state.dart';

class FoodItemBloc extends Bloc<FoodItemEvent, FoodItemState> {
  FoodItemBloc() : super(InitialFoodItemState());

  @override
  Stream<FoodItemState> mapEventToState(
    FoodItemEvent event,
  ) async* {
    if (event is GetFoodItemEvent) {
      try {
        yield LoadingFoodItemState();
        List<FoodItemModel> _foodList =
            await FoodRepo().getFood(event._foodType);
        yield LoadedFoodItemState(_foodList);
      } catch (e) {
        yield ErrorFoodItemState(e.toString());
      }
    }
  }
}
