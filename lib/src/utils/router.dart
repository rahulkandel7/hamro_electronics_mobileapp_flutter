import 'package:flutter/material.dart';

import '../features/auth/screen/loginScreen.dart';
import '../features/auth/screen/registerScreen.dart';
import '../features/cart/screen/cartScreen.dart';
import '../features/category/screen/categoryViewScreen.dart';
import '../features/checkout/screen/checkoutScreen.dart';
import '../features/edit_profile/screen/editProfileScreen.dart';
import '../features/onboarding/screen/onboarding_screen.dart';
import '../features/product/screen/productView.dart';
import '../features/view_order/screens/ordersScreen.dart';
import '../features/wishlist/screen/wishlistScreen.dart';
import '../navbar.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  Navbar.routeName: (context) => const Navbar(),
  CategoryViewScreen.routeName: (context) => const CategoryViewScreen(),
  ProductView.routeName: (context) => const ProductView(),
  CartScreen.routeName: (context) => const CartScreen(),
  // SearchScreen.routeName: (context) => const SearchScreen(),
  CheckoutScreen.routeName: (context) => const CheckoutScreen(),
  WishlistScreen.routeName: (context) => const WishlistScreen(),
  EditProfileScreen.routeName: (context) => const EditProfileScreen(),
  OrdersScreen.routeName: (context) => const OrdersScreen(),
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
};
