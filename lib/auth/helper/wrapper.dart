import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/helper/toggle_helper.dart';
import '../../auth/model/login_model.dart';
import '../../home/ui/pages/home_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // this wrapper class is here to monitor the auth changes, it returns home
    // page if the user is already logged in and login page if not instance of
    // login is present(no user is already logged in) or the user logged out.
    // provider is being used to monitor the UserStream in the auth method class

    final user = Provider.of<LoginUserModel>(context);

    if (user == null) {
      return ToggleBetweenLoginAndSignUpPage();
    } else {
      return HomePage();
    }
  }
}
