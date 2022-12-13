import 'package:flutter/material.dart';
import 'package:hamro_electronics/features/notification/presentation/screens/notificationScreen.dart';

import '../../features/category/presentation/screens/categoryViewScreen.dart';
import '../../features/checkout/presentation/screens/checkoutScreen.dart';
import '../../features/editProfile/presentation/screens/editProfileScreen.dart';
import '../../features/auth/presentation/screens/loginScreen.dart';
import '../../core/screens/navbar.dart';
import '../../core/screens/onboarding_screen.dart';
import '../../features/viewOrder/presentation/screen/ordersScreen.dart';
import '../../features/product_view/presentation/screens/productView.dart';
import '../../features/auth/presentation/screens/registerScreen.dart';
import '../../features/wihslist/presentation/screens/wishlistScreen.dart';
import '../../features/cart/presentation/screens/cartScreen.dart';

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
  NotificationScreen.routeName: (context) => const NotificationScreen(),
};
