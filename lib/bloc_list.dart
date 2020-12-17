import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_chop/home/bloc/food_item/food_item_bloc.dart';
import 'package:kod_chop/home/bloc/search/search_food_bloc.dart';
import 'package:kod_chop/home/model/food_model.dart';

List<BlocProvider> blocList(BuildContext context) {
  return <BlocProvider>[
    BlocProvider<FoodItemBloc>(
      create: (BuildContext context) =>
          FoodItemBloc()..add(GetFoodItemEvent(FoodTypeEnum.All)),
    ),
    BlocProvider<SearchFoodBloc>(
        create: (BuildContext context) => SearchFoodBloc()),
  ];
}
