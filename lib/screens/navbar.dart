import 'package:flutter/material.dart';
import 'package:hamro_electronics/features/cart/presentation/screens/cartScreen.dart';
import 'package:hamro_electronics/features/category/presentation/screens/categoryScreen.dart';
import 'package:hamro_electronics/features/auth/presentation/screens/loginScreen.dart';
import 'package:hamro_electronics/screens/optionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/presentation/screens/homePage.dart';

class Navbar extends StatefulWidget {
  static const routeName = "/home";
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool isLogin = false;

  checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      setState(() {
        isLogin = false;
      });
    } else {
      setState(() {
        isLogin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [
      const HomePage(),
      const CategoryScreen(),
      isLogin ? const CartScreen() : const LoginScreen(),
      const OptionScreen(),
    ];
    return Scaffold(
      body: widgets[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.indigo.shade100,
          height: MediaQuery.of(context).size.height * 0.07,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              80,
            ),
          ),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.indigo.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        child: NavigationBar(
          animationDuration: const Duration(seconds: 1),
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          destinations: [
            NavigationDestination(
              tooltip: 'Home',
              icon: const Icon(
                Icons.home_outlined,
              ),
              label: 'home',
              selectedIcon: Icon(
                Icons.home_outlined,
                color: Colors.indigo.shade900,
              ),
            ),
            NavigationDestination(
              tooltip: 'Category',
              icon: const Icon(
                Icons.category_outlined,
              ),
              label: 'Category',
              selectedIcon: Icon(
                Icons.category_outlined,
                color: Colors.indigo.shade900,
              ),
            ),
            NavigationDestination(
              tooltip: 'Cart',
              icon: const Icon(
                Icons.shopping_bag_outlined,
              ),
              label: 'Cart',
              selectedIcon: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.indigo.shade900,
              ),
            ),
            NavigationDestination(
              tooltip: 'Profile',
              icon: const Icon(
                Icons.person_outline,
              ),
              label: 'Profile',
              selectedIcon: Icon(
                Icons.person_outline,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}
