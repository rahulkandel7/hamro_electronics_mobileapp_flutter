import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/controllers/userController.dart';
import 'package:hamro_electronics/screens/loginScreen.dart';
import 'package:hamro_electronics/screens/wishlistScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  String name = "";
  String photopath = "";

  getuserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString('user');

    var userDecoded = json.decode(userInfo!) as Map<String, dynamic>;

    setState(() {
      name = userDecoded["name"];
      photopath = userDecoded["profile_photo"] ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getuserInfo();
  }

  Widget options(Size mediaQuery, IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mediaQuery.width * 0.03,
        vertical: mediaQuery.height * 0.016,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.indigo,
              width: double.infinity,
              height: mediaQuery.height * 0.27,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10000),
                    child: Image.network(
                      'https://api.hamroelectronics.com.np/public/$photopath',
                      height: mediaQuery.height * 0.15,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: mediaQuery.height * 0.01),
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  WishlistScreen.routeName,
                );
              },
              child: options(mediaQuery, Icons.favorite_outline, 'Wishlist'),
            ),
            options(mediaQuery, Icons.person_outline, 'Edit Profile'),
            options(mediaQuery, Icons.notifications_outlined, 'Notification'),
            options(mediaQuery, Icons.receipt_long_outlined, 'Orders'),
            options(mediaQuery, Icons.security_outlined, 'Privacy Policy'),
            options(mediaQuery, Icons.book_outlined, 'About Us'),
            Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    ref.read(userProvider.notifier).logout().then((response) {
                      final extractedData = json.decode(response.body);
                      if (extractedData['success'] == true) {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      }
                    });
                  },
                  child: options(mediaQuery, Icons.logout_outlined, 'Logout'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
