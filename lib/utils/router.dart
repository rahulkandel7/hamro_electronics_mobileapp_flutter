import 'package:flutter/material.dart';
import 'package:hamro_electronics/screens/cartScreen.dart';
import 'package:hamro_electronics/screens/categoryViewScreen.dart';
import 'package:hamro_electronics/screens/loginScreen.dart';
import 'package:hamro_electronics/screens/navbar.dart';
import 'package:hamro_electronics/screens/productView.dart';
import 'package:hamro_electronics/screens/registerScreen.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  Navbar.routeName: (context) => const Navbar(),
  CategoryViewScreen.routeName: (context) => const CategoryViewScreen(),
  ProductView.routeName: (context) => const ProductView(),
  CartScreen.routeName: (context) => const CartScreen(),
};
