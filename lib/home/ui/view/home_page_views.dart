import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kod_chop/auth/methods/auth_methods.dart';
import 'package:kod_chop/auth/model/user_model.dart';
import 'package:kod_chop/constant.dart';
import 'package:kod_chop/home/bloc/food_item/food_item_bloc.dart';
import 'package:kod_chop/home/model/food_model.dart';
import 'package:kod_chop/home/ui/pages/cart_page.dart';
import 'package:kod_chop/home/ui/pages/search_page.dart';
import 'package:kod_chop/home/ui/pages/seleted_food_page.dart';
import 'package:kod_chop/local_db/hive_methods.dart';

class HomePageHeader extends StatelessWidget {
  final Size size;
  final Box cartBox;

  const HomePageHeader({Key key, this.size, this.cartBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        ),
      ),
      padding: EdgeInsets.all(8.0),
      height: size.height * 0.09,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder<UserModel>(
            future: HiveMethods().getUserDataInModel(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return userDetails(snapshot.data);
            },
          ),
          HomeCartIcon(size: size, cartBox: cartBox),
        ],
      ),
    );
  }

  Widget userDetails(UserModel userData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        userImage('https://ksksksks'),
        userName(userData.fullName),
      ],
    );
  }

  Widget userName(String name) {
    return Container(
      height: size.height * 0.07,
      margin: EdgeInsets.only(left: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          Text(
            '$name',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget userImage(String url) {
    return InkWell(
      onTap: () async {
        await AuthMethods().signOut();
      },
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: Icon(Icons.person),
      ),
    );
  }
}

class HomePageSearchBar extends StatelessWidget {
  final Size size;

  const HomePageSearchBar({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchPage(),
          ),
        );
      },
      child: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          elevation: 2.5,
          color: Colors.grey[100],
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            height: size.height * 0.06,
            child: Row(
              children: [
                Icon(Icons.search, size: 22),
                SizedBox(width: 20.0),
                Text(
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageOptions extends StatelessWidget {
  final Size size;

  HomePageOptions({Key key, this.size}) : super(key: key);

  final StreamController<String> selectedStream =
      StreamController<String>.broadcast();

  void update(BuildContext context, String title) {
    selectedStream.add(title);

    if (title.contains('Cooked')) {
      BlocProvider.of<FoodItemBloc>(context)
          .add(GetFoodItemEvent(FoodTypeEnum.CookedFood));
    } else if (title.contains('Drinks')) {
      BlocProvider.of<FoodItemBloc>(context)
          .add(GetFoodItemEvent(FoodTypeEnum.Drinks));
    } else if (title.contains('Snacks')) {
      BlocProvider.of<FoodItemBloc>(context)
          .add(GetFoodItemEvent(FoodTypeEnum.Snacks));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: size.height * 0.05,
      width: size.width,
      child: itemOptions(context),
    );
  }

  Widget itemOptions(BuildContext context) {
    return Container(
      height: size.height * 0.06,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          item(context, 'Cooked Food'),
          item(context, 'Dessert'),
          item(context, 'Snacks'),
          item(context, 'Drinks'),
        ],
      ),
    );
  }

  Widget item(BuildContext context, String title) {
    return StreamBuilder<String>(
      stream: selectedStream.stream,
      builder: (context, snapshot) {
        bool isSelected = snapshot.data == title;

        return InkWell(
          onTap: () => update(context, title),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[200],
              elevation: 2.5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text(
                    '$title',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: isSelected ? Colors.white : Colors.grey[400],
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomePageFoodItemView extends StatelessWidget {
  final Size size;
  final Box cartBox;

  const HomePageFoodItemView({Key key, this.size, this.cartBox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: blocBody(context),
      ),
    );
  }

  Widget blocBody(BuildContext context) {
    return BlocConsumer<FoodItemBloc, FoodItemState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        if (state is LoadingFoodItemState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ErrorFoodItemState) {
          return Center(child: Text(state.message));
        } else if (state is LoadedFoodItemState) {
          return gridView(context, state.foodList);
        }

        return Container();
      },
    );
  }

  Widget gridView(BuildContext context, List<FoodItemModel> foodList) {
    return GridView.count(
      primary: true,
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      children: List.generate(
        foodList.length,
        (index) {
          return getStructuredGridCell(context, foodList[index]);
        },
      ),
    );
  }

  Card getStructuredGridCell(BuildContext context, FoodItemModel foodItem) {
    return Card(
      elevation: 1.5,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SelectedFoodPage(
              foodItem: foodItem,
              cartBox: cartBox,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2.0),
                  height: size.height * 0.17,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: foodItem.imageUrl,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (_, child, progress) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    foodItem.foodName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    '\$ ${moneyFormatter.format(foodItem.price)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeCartIcon extends StatelessWidget {
  final Size size;
  final Box cartBox;

  HomeCartIcon({Key key, this.size, this.cartBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CartPage(cartBox: cartBox)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        width: size.width * 0.10,
        height: size.height * 0.05,
        child: cartIcon(),
      ),
    );
  }

  Widget cartIcon() {
    return ValueListenableBuilder(
      valueListenable: cartBox.listenable(),
      builder: (context, Box value, child) {
        int count = value.length;
        return Stack(
          children: [
            Icon(
              Icons.shopping_cart,
              size: 38,
              color: Colors.black,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                width: size.width * 0.05,
                height: size.height * 0.03,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
