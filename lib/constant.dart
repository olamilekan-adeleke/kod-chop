import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final String publicKey = 'pk_test_783f909da670ff1ad0ec676ef617ead054d113e8';
final String secretKey = 'sk_test_33dfdc0d792c01298c04c42bbc2dcabba2bf8913';

TextStyle headingTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle subHeadTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);

final moneyFormatter = new NumberFormat("#,##0.00", "en_US");