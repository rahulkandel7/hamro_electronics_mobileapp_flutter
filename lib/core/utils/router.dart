import 'package:flutter/material.dart';
import 'package:hamro_electronics/features/cart/presentation/screens/cartScreen.dart';
import 'package:hamro_electronics/features/category/presentation/screens/categoryViewScreen.dart';
import 'package:hamro_electronics/features/checkout/presentation/screens/checkoutScreen.dart';
import 'package:hamro_electronics/features/editProfile/presentation/screens/editProfileScreen.dart';
import 'package:hamro_electronics/features/auth/presentation/screens/loginScreen.dart';
import 'package:hamro_electronics/core/screens/navbar.dart';
import 'package:hamro_electronics/core/screens/onboarding_screen.dart';
import 'package:hamro_electronics/features/viewOrder/presentation/screen/ordersScreen.dart';
import 'package:hamro_electronics/features/product_view/presentation/screens/productView.dart';
import 'package:hamro_electronics/features/auth/presentation/screens/registerScreen.dart';
import 'package:hamro_electronics/features/wihslist/presentation/screens/wishlistScreen.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  Navbar.routeName: (context) => const Navbar(),
  CategoryViewScreen.routeName: (context) => const CategoryViewScreen(),
  ProductView.routeName: (context) => const ProductView(),
  CartScreen.routeName: (context) => const CartScreen(),
  CheckoutScreen.routeName: (context) => const CheckoutScreen(),
  WishlistScreen.routeName: (context) => const WishlistScreen(),
  EditProfileScreen.routeName: (context) => const EditProfileScreen(),
  OrdersScreen.routeName: (context) => const OrdersScreen(),
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
};
