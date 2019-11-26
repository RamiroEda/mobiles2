import 'package:flutter/material.dart';
import 'package:mobiles2/pages/home_page.dart';
import 'package:mobiles2/pages/login_page.dart';
import 'package:mobiles2/pages/signup_page.dart';

final myRoutes = {
  '/': (BuildContext context) => LoginPage(),
  '/signup': (BuildContext context) => SignUpPage(),
  '/login': (BuildContext context) => LoginPage(),
  '/home': (BuildContext context) => HomePage(),
};
