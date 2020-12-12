import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../auth/methods/auth_methods.dart';
import '../../../auth/shared/shared_design.dart';
import '../../../auth/shared/shared_widgets.dart';
import '../../../auth/ui/views/login_widgets.dart';
import '../../../helper.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;

  SignUpPage({@required this.toggleView});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  AuthMethods authService = AuthMethods();
  StreamController loadingStream = StreamController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Future<void> validateAndSave({@required BuildContext context}) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String fullName =
        firstNameController.text.trim() + ' ' + lastNameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      loadingStream.add(true);

      ///
      await signUpUser(
        context: context,
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: int.parse(phoneNumber),
      );
    } else {
      showSnackBar(
        context: context,
        message: 'Fill All Form',
        duration: Duration(seconds: 2),
      );
    }
  }

  Future<void> signUpUser({
    @required BuildContext context,
    @required String email,
    @required String password,
    @required String fullName,
    @required int phoneNumber,
  }) async {
    try {
      await authService.registerUserWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      showSnackBar(context: context, message: '$e');
      loadingStream.add(false);
    }
  }

  @override
  void dispose() {
    loadingStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            form(),
            SizedBox(height: 20),
            createAccountButton(),
            SizedBox(height: 20),
            logInButton(),
          ],
        ),
      ),
    );
  }

  Widget form() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            CustomTextField(
              padding: const EdgeInsets.only(left: 15, right: 15),
              title: 'First Name',
              showSuffix: false,
              controller: firstNameController,
              itemLengthCheck: 3,
            ),
            SizedBox(height: 10),
            CustomTextField(
              padding: const EdgeInsets.only(left: 15, right: 15),
              title: 'Last Name',
              showSuffix: false,
              controller: lastNameController,
              itemLengthCheck: 3,
            ),
            SizedBox(height: 10),
            CustomTextField(
              padding: const EdgeInsets.only(left: 15, right: 15),
              title: 'Phone Number',
              showSuffix: false,
              controller: phoneNumberController,
              itemLengthCheck: 3,
            ),
            SizedBox(height: 10),
            CustomTextField(
              padding: const EdgeInsets.only(left: 15, right: 15),
              title: 'Email',
              showSuffix: false,
              controller: emailController,
              itemLengthCheck: 3,
            ),
            SizedBox(height: 10),
            CustomTextField(
              padding: const EdgeInsets.only(left: 15, right: 15),
              title: 'Password',
              showSuffix: true,
              controller: passwordController,
              itemLengthCheck: 3,
            ),
            SizedBox(height: 16),
            Text(
              "By clicking on 'Create Account', you agree to Terms And "
              "Condition And Privacy Policy",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget createAccountButton() {
    return StreamBuilder(
      stream: loadingStream.stream,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          return customButton(
            context: context,
            function: () {
              validateAndSave(context: context);
            },
            title: 'Create Account',
          );
        }
      },
    );
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 40),
      padding: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Create your Account", style: headingTextStyle),
          Text("Let's get to know you better", style: subTextStyle)
        ],
      ),
    );
  }

  Widget logInButton() {
    return InkWell(
      onTap: () {
        widget.toggleView();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
            "Already have an account ? Sign in",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
