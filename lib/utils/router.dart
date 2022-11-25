import 'package:flutter/material.dart';
import 'package:hamro_electronics/screens/cartScreen.dart';
import 'package:hamro_electronics/screens/categoryViewScreen.dart';
import 'package:hamro_electronics/screens/checkoutScreen.dart';
import 'package:hamro_electronics/screens/editProfileScreen.dart';
import 'package:hamro_electronics/screens/loginScreen.dart';
import 'package:hamro_electronics/screens/navbar.dart';
import 'package:hamro_electronics/screens/onboarding_screen.dart';
import 'package:hamro_electronics/screens/ordersScreen.dart';
import 'package:hamro_electronics/screens/productView.dart';
import 'package:hamro_electronics/screens/registerScreen.dart';
import 'package:hamro_electronics/screens/searchScreen.dart';
import 'package:hamro_electronics/screens/wishlistScreen.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  Navbar.routeName: (context) => const Navbar(),
  CategoryViewScreen.routeName: (context) => const CategoryViewScreen(),
  ProductView.routeName: (context) => const ProductView(),
  CartScreen.routeName: (context) => const CartScreen(),
  SearchScreen.routeName: (context) => const SearchScreen(),
  CheckoutScreen.routeName: (context) => const CheckoutScreen(),
  WishlistScreen.routeName: (context) => const WishlistScreen(),
  EditProfileScreen.routeName: (context) => const EditProfileScreen(),
  OrdersScreen.routeName: (context) => const OrdersScreen(),
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
};
