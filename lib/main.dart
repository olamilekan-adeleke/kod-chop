import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './auth/helper/wrapper.dart';
import 'auth/methods/auth_methods.dart';
import 'auth/model/login_model.dart';
import 'local_db/init_hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveInitMethods().startUserDataHiveDb();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LoginUserModel>.value(
      value: AuthMethods().userStream,
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: Color.fromRGBO(252, 252, 252, 1.0),
          accentColor: Color.fromRGBO(144, 138, 224, 1.0),
          primaryColor: Color.fromRGBO(250, 201, 0, 1.0),
        ),
        home: Wrapper(),
      ),
    );
  }
}
