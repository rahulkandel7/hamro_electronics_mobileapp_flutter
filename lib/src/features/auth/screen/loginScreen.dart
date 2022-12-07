import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../navbar.dart';
import '../controller/userController.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  login() {
    _loginKey.currentState!.save();
    if (!_loginKey.currentState!.validate()) {
      return;
    }

    FirebaseMessaging.instance.getToken().then((token) {
      log(token.toString());
    });

    ref.read(userProvider.notifier).login(email, password).then((res) {
      if (res.statusCode == 422) {
        var error = json.decode(res.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error['message'].toString(),
            ),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Login Successful',
            ),
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pushReplacementNamed(Navbar.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: mediaQuery.height * 0.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mediaQuery.height * 0.02),
                  child: Text(
                    'Welcome to ,',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline4!.color,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mediaQuery.height * 0.01),
                  child: Text(
                    'Hamro Electronics',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline4!.color,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mediaQuery.height * 0.02),
                  child: Text(
                    'Login to Continue',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline4!.color,
                        ),
                  ),
                ),
                Form(
                  key: _loginKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.02),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color:
                                  Theme.of(context).textTheme.headline4!.color,
                            ),
                            labelText: 'Enter Your Email Address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) {
                            email = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Provide your Email Address';
                            } else if (!value.contains('@')) {
                              return 'Please Provide a valid Email Address';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.02),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color:
                                  Theme.of(context).textTheme.headline4!.color,
                            ),
                            labelText: 'Enter Your Password ',
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (newValue) {
                            password = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Forget Password ?',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: mediaQuery.height * 0.03),
                        child: ElevatedButton(
                          onPressed: () => login(),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: mediaQuery.height * 0.014,
                              horizontal: mediaQuery.width * 0.3,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            disabledBackgroundColor: Colors.indigo.shade200,
                            disabledForegroundColor: Colors.white,
                            textStyle:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                      Divider(
                        color: Colors.indigo.shade400,
                        thickness: 0.3,
                        height: mediaQuery.height * 0.05,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushReplacementNamed('/register'),
                        splashColor: Colors.indigo.shade100,
                        child: Text(
                          'Don\'t have an account ? Sign Up',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline4!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
