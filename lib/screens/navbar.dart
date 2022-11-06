import 'package:flutter/material.dart';

import '../screens/homePage.dart';
import '../screens/loginScreen.dart';
import '../screens/registerScreen.dart';

class Navbar extends StatefulWidget {
  static const routeName = "/home";
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  final _widgets = const [
    HomePage(),
    LoginScreen(),
    RegisterScreen(),
    HomePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets[_selectedIndex],
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
                Icons.favorite_border_outlined,
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
