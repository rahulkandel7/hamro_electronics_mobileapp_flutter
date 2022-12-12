import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../extra/optionScreen.dart';
import '../../features/auth/presentation/screens/loginScreen.dart';
import '../../features/cart/presentation/screens/cartScreen.dart';
import '../../features/category/presentation/screens/categoryScreen.dart';
import '../../features/home/presentation/screens/homePage.dart';
import '../../main.dart';

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
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          var initializationSettingsAndroid =
              const AndroidInitializationSettings('launcher_icon');
          var iosInitilize = const IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            defaultPresentAlert: true,
            defaultPresentBadge: true,
            defaultPresentSound: true,
          );
          var initializationSettings = InitializationSettings(
              android: initializationSettingsAndroid, iOS: iosInitilize);
          flutterLocalNotificationsPlugin.initialize(
            initializationSettings,
          );

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.transparent,
                playSound: true,
                setAsGroupSummary: true,
                enableVibration: true,
                importance: Importance.high,
                visibility: NotificationVisibility.public,
                channelShowBadge: true,
              ),
            ),
          );
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage((message) {
      throw message;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
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
