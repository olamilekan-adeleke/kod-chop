import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kod_chop/constant.dart';
import 'package:kod_chop/home/model/address_model.dart';

class CheckOutAddressUi extends StatelessWidget {
  final Size size;
  final Box addressBox;

  const CheckOutAddressUi({Key key, this.size, this.addressBox})
      : super(key: key);

  void addNewAddress(BuildContext context) {
    String title;
    String address;
    String streetName;
    String state;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Add Address'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onChanged: (val) {
                    title = val;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (val) {
                    streetName = val;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Street Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (val) {
                    address = val;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (val) {
                    state = val;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'state',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.grey[700],
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text('Save', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                if (state != null &&
                    title != null &&
                    streetName != null &&
                    address != null) {
                  AddressModel _address = AddressModel(
                    title: title.trim(),
                    streetName: streetName.trim(),
                    address: address.trim(),
                    state: state.trim(),
                    isSelected: false,
                  );

                  await addressBox.add(_address.toMap());
                  Navigator.pop(context);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Address Added'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void selectAddress(int index, bool value) {
    int _index = 0;
    int _listIndex = 0;
    List<AddressModel> list = [];

    addressBox.values.toList().forEach((element) {
      Map data = element;
      AddressModel add = AddressModel.fromMap(data.cast());
      add.isSelected = _index == index ? value : false;
      list.add(add);
      _index++;
    });

    list.forEach((element) {
      addressBox.putAt(_listIndex, element.toMap());
      _listIndex++;
    });
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.76,
      width: size.width,
      child: body(),
    );
  }

  Widget body() {
    return ValueListenableBuilder(
      valueListenable: addressBox.listenable(),
      builder: (context, Box value, child) {
        List<AddressModel> listOfAddress = value.values.map((e) {
          Map data = e;
          return AddressModel.fromMap(data.cast());
        }).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              addressList(listOfAddress),
              addAddress(context),
            ],
          ),
        );
      },
    );
  }

  Widget addressList(List<AddressModel> listOfAddress) {
    if (listOfAddress.isEmpty) {
      return noAddressFound();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listOfAddress.length,
      itemBuilder: (context, index) {
        AddressModel currentAddress = listOfAddress[index];
        return Card(
          child: Container(
            height: size.height * 0.10,
            width: size.width * 0.80,
            child: CheckboxListTile(
              isThreeLine: true,
              value: currentAddress.isSelected,
              title: Text(
                '${currentAddress.title.toUpperCase()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                '${currentAddress.streetName}, ${currentAddress.address}.'
                ' ${currentAddress.state} ',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onChanged: (val) {
                print(val);
                selectAddress(index, val);
              },
            ),
          ),
        );
      },
    );
  }

  Widget addAddress(BuildContext context) {
    return InkWell(
      onTap: () => addNewAddress(context),
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        height: size.height * 0.08,
        width: size.width * 0.80,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey[300]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add New Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(width: 10.0),
            Icon(Icons.add, color: Colors.grey[400], size: 30),
          ],
        ),
      ),
    );
  }

  Widget noAddressFound() {
    return Container(
      height: size.height * 0.30,
      width: size.width * 0.70,
      margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
      padding: EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          'Opps, No Address Found!',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class CheckOutPaymentUi extends StatelessWidget {
  final int amount;
  final Size size;

  const CheckOutPaymentUi({Key key, this.amount, this.size}) : super(key: key);

  void makePayment(BuildContext context) {
    Box addressBox = Hive.box('addressData');

    List<AddressModel> listOfAddress = [];

    listOfAddress = addressBox.values
        .map((e) {
          Map data = e;
          return AddressModel.fromMap(data.cast());
        })
        .toList()
        .where((element) => element.isSelected == true)
        .toList();

    if (listOfAddress.isNotEmpty) {
      AddressModel selectedAddress = listOfAddress[0];

      print(selectedAddress);

      //TODO: make payment
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Select Address')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.20,
      width: size.width,
      child: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      children: [
        totalPrice(),
        customDivider(),
        Spacer(),
        button(context),
      ],
    );
  }

  Widget button(BuildContext context) {
    return InkWell(
      onTap: () => makePayment(context),
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            'Payment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget totalPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            '\$ ${moneyFormatter.format(amount)}',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          )
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
}
