import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveInitMethods {
  Future<void> startUserDataHiveDb() async {
    /// This method will be called at the start of the app, this will start
    /// a local Database this will host/store the user Data.

    Directory documentDir = await getApplicationSupportDirectory();
    Hive.init(documentDir.path);
    await Hive.openBox('userData');
    print('ope userDat');
  }

  Future<void> startCartDataHiveDb() async {
    /// This method will be called at the start of the app, this will start
    /// a local Database this will host/store the user Cart Data.

    Directory documentDir = await getApplicationSupportDirectory();
    Hive.init(documentDir.path);
    var x = await Hive.openBox('cartData');
    print('ope cart');
    print(x.values);
  }

  Future<void> startAddressDataHiveDb() async {
    /// This method will be called at the start of the app, this will start
    /// a local Database this will host/store the user address Data.

    Directory documentDir = await getApplicationSupportDirectory();
    Hive.init(documentDir.path);
    await Hive.openBox('addressData');
    print('ope address');
  }
}
