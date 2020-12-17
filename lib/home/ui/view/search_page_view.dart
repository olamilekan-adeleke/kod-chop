import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_chop/home/bloc/search/search_food_bloc.dart';
import 'package:kod_chop/home/model/food_model.dart';
import 'package:kod_chop/home/ui/pages/seleted_food_page.dart';

import '../../../constant.dart';

class SearchPageSearchBar extends StatelessWidget {
  final Size size;

  const SearchPageSearchBar({Key key, this.size}) : super(key: key);

  void search(BuildContext context, String keyword) {
    print(keyword);

    BlocProvider.of<SearchFoodBloc>(context).add(SearchFoodByKeyword(keyword));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      height: size.height * 0.08,
      width: size.width,
      child: TextFormField(
        maxLines: 1,
        textInputAction: TextInputAction.search,
        autocorrect: true,
        onFieldSubmitted: (val) => search(context, val),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Search For Food....',
        ),
      ),
    );
  }
}

class SearchPageBody extends StatelessWidget {
  final Size size;

  const SearchPageBody({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.855,
      width: size.width,
      child: body(context),
    );
  }

  Widget body(BuildContext context) {
    return BlocConsumer<SearchFoodBloc, SearchFoodState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is InitialSearchFoodState) {
          return emptySearch();
        } else if (state is LoadingSearchFoodState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedSearchFoodState) {
          print(state.foodList);
          return resultList(context, state.foodList);
        } else if (state is ErrorSearchFoodState) {
          return errorResultSearch(state.message);
        }

        return Container();
      },
    );
  }

  Widget resultList(BuildContext context, List<FoodItemModel> foodList) {
    return ListView.builder(
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        FoodItemModel item = foodList[index];

        return orderItem(context, item);
      },
    );
  }

  Widget orderItem(BuildContext context, FoodItemModel item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SelectedFoodPage(
                foodItem: item,
              ),
            ),
          );
        },
        child: Card(
          elevation: 2.5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            height: size.height * 0.13,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                image(item.imageUrl),
                details(item),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget details(FoodItemModel item) {
    return Container(
      height: size.height * 0.10,
      width: size.width * 0.65,
      margin: EdgeInsets.only(left: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${item.foodName}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '\$ ${moneyFormatter.format(item.price)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
          ),
          Text(
            '${item.description}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey[700],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget image(String imageUrl) {
    return Container(
      height: size.height * 0.10,
      width: size.width * 0.18,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        progressIndicatorBuilder: (_, url, value) {
          return Center(
            child: CircularProgressIndicator(
              value: value.progress,
            ),
          );
        },
      ),
    );
  }

  Widget emptySearch() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image.asset(
            'asset/search.png',
            fit: BoxFit.fill,
            height: 150,
            width: 150,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Search For Your Favourite Food..',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 25,
            color: Colors.grey[700],
          ),
        )
      ],
    );
  }

  Widget emptyResultSearch() {
    return Container(
      alignment: Alignment.center,
      height: size.height * 0.50,
      width: size.width,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: Image.asset(
              'asset/empty.png',
              fit: BoxFit.fill,
              height: 150,
              width: 150,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Opps, No Data Found..',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 25,
              color: Colors.grey[700],
            ),
          )
        ],
      ),
    );
  }

  Widget errorResultSearch(String error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: Icon(
          Icons.error,
          color: Colors.grey[300],
          size: 40,
        )),
        SizedBox(height: 20.0),
        Text(
          '$error',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
            color: Colors.grey[700],
          ),
        )
      ],
    );
  }
}
