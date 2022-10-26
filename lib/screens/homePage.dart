import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hamro_electronics/controllers/userController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      context.go('/login');
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Center(
          child: Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () {
                  ref.read(userProvider.notifier).logout().then((value) {
                    if (value.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'logout',
                          ),
                        ),
                      );
                      GoRouter.of(context).go('/login');
                    }
                  });
                },
                child: Text('Logout'),
              );
            },
          ),
        ));
  }
}
