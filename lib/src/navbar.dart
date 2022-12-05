import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/screen/loginScreen.dart';
import 'features/cart/screen/cartScreen.dart';
import 'features/category/screen/categoryScreen.dart';
import 'features/homepage/screen/homePage.dart';
import 'features/options/screen/optionScreen.dart';

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
    final List<Widget> _widgets = [
      const HomePage(),
      const CategoryScreen(),
      isLogin ? const CartScreen() : const LoginScreen(),
      const OptionScreen(),
    ];
    return Scaffold(
      body: _widgets[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.transparent,
          indicatorColor: Theme.of(context).indicatorColor,
          height: MediaQuery.of(context).size.height * 0.07,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              80,
            ),
          ),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Theme.of(context).textTheme.headline2!.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          iconTheme: MaterialStateProperty.all(
            IconThemeData(
              color: Theme.of(context).backgroundColor,
            ),
          ),
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
