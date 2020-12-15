import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kod_chop/constant.dart';
import 'package:kod_chop/home/model/food_cart_model.dart';
import 'package:kod_chop/home/ui/pages/check_out_page.dart';

class CartPageOrders extends StatelessWidget {
  final Size size;
  final Box cartBox;

  const CartPageOrders({Key key, this.size, this.cartBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.60,
      child: orderList(),
    );
  }

  Widget orderList() {
    return ValueListenableBuilder<Box>(
      valueListenable: cartBox.listenable(),
      builder: (_, Box value, child) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            Map currentData = value.values.toList()[index];
            CartFoodItemModel item =
                CartFoodItemModel.fromMap(currentData.cast<String, dynamic>());
            return orderItem(context, item, index);
          },
        );
      },
    );
  }

  Widget orderItem(BuildContext context, CartFoodItemModel item, int index) {
    return InkWell(
      onLongPress: () {
        cartBox.delete(index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                numberOfPlateAndAmount(context, item, index),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget numberOfPlateAndAmount(
    BuildContext context,
    CartFoodItemModel item,
    int index,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 5.0, right: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            numberOfPlate(context, item, index),
            numberOfPlatePrice(item),
          ],
        ),
      ),
    );
  }

  Widget details(CartFoodItemModel item) {
    return Container(
      height: size.height * 0.06,
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

  Widget numberOfPlatePrice(CartFoodItemModel item) {
    return Text(
      '\$ ${moneyFormatter.format(item.price * item.numberOfPlate)}',
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 16,
        color: Colors.grey[700],
      ),
    );
  }

  Widget numberOfPlate(
    BuildContext context,
    CartFoodItemModel item,
    int index,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            if (item.numberOfPlate > 1) {
              Map data = item.toMap();
              data.update('numberOfPlate', (value) => item.numberOfPlate - 1);
              cartBox.putAt(index, data);
            }
          },
          child: Container(
            height: size.height * 0.04,
            width: size.width * 0.06,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Text(
            '${item.numberOfPlate}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (item.numberOfPlate < 10) {
              Map data = item.toMap();
              data.update('numberOfPlate', (value) => item.numberOfPlate + 1);
              cartBox.putAt(index, data);
            }
          },
          child: Container(
            height: size.height * 0.04,
            width: size.width * 0.06,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CartTotalAmountUi extends StatelessWidget {
  final Size size;
  final Box cartBox;

  const CartTotalAmountUi({Key key, this.size, this.cartBox}) : super(key: key);

  int getTotal(Box data) {
    int _total = 0;

    List<CartFoodItemModel> cartList = data.values.map((e) {
      Map data = e;
      return CartFoodItemModel.fromMap(data.cast());
    }).toList();

    cartList.forEach((element) {
      int currentFee = element.price * element.numberOfPlate;
      _total += currentFee;
    });

    return _total;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ValueListenableBuilder(
          valueListenable: cartBox.listenable(),
          builder: (context, Box value, child) {
            return amountList(context, value);
          },
        ),
      ),
    );
  }

  Widget amountList(BuildContext context, Box value) {
    int amount = getTotal(value);
    int delivery = 150;
    return Column(
      children: [
        subtotal(amount),
        deliveryFee(delivery),
        customDivider(),
        totalFee(amount, delivery),
        Spacer(),
        button(context, amount + delivery),
      ],
    );
  }

  Widget button(BuildContext context, int amount) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => CheckOutPage(totalAmount: amount)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        height: size.height * 0.08,
        width: size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            'Check Out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget totalFee(int amount, int delivery) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '\$ ${moneyFormatter.format(amount + delivery)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget customDivider() {
    return Container(
      width: size.width,
      child: Text(
        '- ' * 100000,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: Colors.grey[700],
        ),
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
    );
  }

  Widget deliveryFee(int delivery) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Delivery: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            '\$ ${moneyFormatter.format(delivery)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget subtotal(int amount) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Subtotal: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            '\$ ${moneyFormatter.format(amount)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
