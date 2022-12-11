import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/auth/presentation/controllers/authController.dart';
import 'package:hamro_electronics/screens/editProfileScreen.dart';
import 'package:hamro_electronics/features/auth/presentation/screens/loginScreen.dart';
import 'package:hamro_electronics/features/viewOrder/presentation/screen/ordersScreen.dart';
import 'package:hamro_electronics/features/wihslist/presentation/screens/wishlistScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  String name = "";
  String photopath = "";

  bool isLogin = false;

  getuserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString('user');

    var userDecoded = json.decode(userInfo!) as Map<String, dynamic>;

    setState(() {
      name = userDecoded["name"];
      photopath = userDecoded["profile_photo"] ?? '';
    });

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
                    child: CachedNetworkImage(
                      imageUrl: photopath == ''
                          ? 'https://fakeimg.pl/350x350/?text=HamroElectronics'
                          : 'https://api.hamroelectronics.com.np/public/$photopath',
                      height: mediaQuery.height * 0.15,
                      placeholder: (context, url) =>
                          Image.asset('assets/images/logo.png'),
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
            isLogin
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            WishlistScreen.routeName,
                          );
                        },
                        child: options(
                            mediaQuery, Icons.favorite_outline, 'Wishlist'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            EditProfileScreen.routeName,
                          );
                        },
                        child: options(
                            mediaQuery, Icons.person_outline, 'Edit Profile'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            OrdersScreen.routeName,
                          );
                        },
                        child: options(
                            mediaQuery, Icons.receipt_long_outlined, 'Orders'),
                      ),
                    ],
                  )
                : const SizedBox(),
            options(mediaQuery, Icons.notifications_outlined, 'Notification'),
            options(mediaQuery, Icons.security_outlined, 'Privacy Policy'),
            options(mediaQuery, Icons.book_outlined, 'About Us'),
            isLogin
                ? Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(authControllerProvider);
                      ref.listen<AsyncValue>(
                        authControllerProvider,
                        (_, state) {
                          if (!state.isRefreshing && state.hasError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("error")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Logout Successful',
                                ),
                                backgroundColor: Colors.indigo,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                          }
                        },
                      );
                      return InkWell(
                        onTap: () {
                          ref.read(authControllerProvider.notifier).logout();
                        },
                        child: options(
                            mediaQuery, Icons.logout_outlined, 'Logout'),
                      );
                    },
                  )
                : InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        LoginScreen.routeName,
                      );
                    },
                    child: options(mediaQuery, Icons.person_outline, 'Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
