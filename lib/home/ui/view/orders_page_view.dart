import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kod_chop/home/model/address_model.dart';
import 'package:kod_chop/home/model/food_cart_model.dart';
import 'package:kod_chop/home/model/orders_model.dart';
import 'package:kod_chop/home/repo/food_repo.dart';

import '../../../constant.dart';

class OrderPageBody extends StatelessWidget {
  final Size size;

  const OrderPageBody({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 80,
      width: size.width,
      color: Theme.of(context).backgroundColor,
//      color: Colors.red,
      child: body(),
    );
  }

  Widget body() {
    return StreamBuilder<QuerySnapshot>(
      stream: FoodRepo().orderStream(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (snap.hasError) {
          return Center(child: Text('Error'));
        }

        List<OrdersModel> orders = [];

        snap.data.docs.forEach((element) {
          Map data = element.data();
          OrdersModel order = OrdersModel.fromMap(data.cast());
          orders.add(order);
        });

        return orderList(orders);
      },
    );
  }

  Widget orderList(List<OrdersModel> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Text('Opps, No Ordres Found!'),
      );
    }

    return Container(
      width: size.width,
      height: size.height * 0.50,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (context, index) {
          OrdersModel ordersModel = orders[index];
          List<CartFoodItemModel> items = ordersModel.orders.map((e) {
            Map data = e;
            return CartFoodItemModel.fromMap(data.cast());
          }).toList();

          return Card(
            elevation: 3.0,
            child: Column(
              children: [
                ordersItemList(items),
                itemInfo(context, ordersModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget itemInfo(BuildContext context, OrdersModel order) {
    AddressModel address = AddressModel.fromMap(order.address);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          customText('Order Id', order.id),
          customText('Time', order.timestamp.toDate().toString().split('.')[0]),
          customText('Total Number Of Items', order.numberOfItem.toString()),
          customText(
            'Amount Paid',
            '# ${moneyFormatter.format(order.amountPaid)}',
          ),
          customText(
            'Address',
            '${address.streetName}, ${address.address}. ${address.state}',
          ),
          customStatusText(context, order.status),
        ],
      ),
    );
  }

  Widget ordersItemList(List<CartFoodItemModel> items) {
    return Container(
      height: size.height * 0.30,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          CartFoodItemModel foodItem = items[index];
          return orderItem(context, foodItem);
        },
      ),
    );
  }

  Widget orderItem(BuildContext context, CartFoodItemModel item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        elevation: 1.5,
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
    );
  }

  Widget details(CartFoodItemModel item) {
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.45,
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
            'Number of item: ${item.numberOfPlate}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey[700],
            ),
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

  Widget customText(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: ',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(
            '$value',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey[700],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget customStatusText(BuildContext context, int value) {
    Color color;
    String _text;

    if (value == 0) {
      color = Theme.of(context).accentColor;
      _text = 'Order In Progress...';
    } else if (value == 1) {
      color = Theme.of(context).primaryColor;
      _text = 'Delivery In Progress....';
    } else if (value == 2) {
      color = Colors.green;
      _text = 'Order Deliverd.';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status: ',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(
            '$_text',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: color,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
