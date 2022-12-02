import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../navbar.dart';
import '../../edit_profile/model/user.dart';
import '../controller/userController.dart';
import 'loginScreen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  static const routeName = "/register";
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  //* Creating GlobalKey for Form
  final _registerKey = GlobalKey<FormState>();

  final User _user = User(
    address: '',
    email: '',
    gender: '',
    mobile: '',
    name: '',
    password: '',
    confirmPassword: '',
  );

  register() {
    _registerKey.currentState!.save();
    if (!_registerKey.currentState!.validate()) {
      return;
    }
    ref.read(userProvider.notifier).register(_user).then((res) {
      if (res.statusCode == 422) {
        var error = json.decode(res.body);
        Map<String, dynamic> errorDetails =
            error['details'] as Map<String, dynamic>;
        errorDetails.map((key, value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                value.toString().replaceAll('[', '').replaceAll(']', ''),
              ),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
          throw 'Invalid Data Send';
        });
      } else if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Registration Successful',
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
                        color: Colors.indigo.shade400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mediaQuery.height * 0.01),
                  child: Text(
                    'Hamro Electronics',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mediaQuery.height * 0.02),
                  child: Text(
                    'Register to Continue',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade400),
                  ),
                ),
                Form(
                  key: _registerKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.01),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.indigo.shade400,
                            ),
                            labelText: 'Enter Your Full Name',
                          ),
                          onSaved: (newValue) {
                            _user.name = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Provide your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.01),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.indigo.shade400,
                            ),
                            labelText: 'Enter Your Email Address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) {
                            _user.email = newValue!;
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
                            vertical: mediaQuery.height * 0.01),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.indigo.shade400,
                            ),
                            labelText: 'Enter Your Password ',
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (newValue) {
                            _user.password = newValue!;
                          },
                          onChanged: (value) {
                            _user.password = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter  Password';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.01),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.indigo.shade400,
                            ),
                            labelText: 'Confirm Your Password ',
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (newValue) {
                            _user.confirmPassword = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Confirm your Password';
                            } else if (value != _user.password) {
                              return 'Password does not match';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.01),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_city_outlined,
                              color: Colors.indigo.shade400,
                            ),
                            labelText: 'Enter Your Address',
                          ),
                          onSaved: (newValue) {
                            _user.address = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Provide your Address';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.01),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone_android_outlined,
                              color: Colors.indigo.shade400,
                            ),
                            labelText: 'Enter Your Phone Number',
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (newValue) {
                            _user.mobile = newValue!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Provide your Phone Number';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.01),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_pin_circle_outlined,
                              color: Colors.indigo.shade400,
                            ),
                            labelText: 'Select Your Gender',
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Select Your Gender';
                            } else {
                              return null;
                            }
                          },
                          items: ['Male', 'Female'].map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _user.gender = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: mediaQuery.height * 0.03),
                        child: ElevatedButton(
                          onPressed: () {
                            register();
                          },
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
                          child: const Text('Register'),
                        ),
                      ),
                      Divider(
                        color: Colors.indigo.shade400,
                        thickness: 0.3,
                        height: mediaQuery.height * 0.05,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(LoginScreen.routeName),
                        splashColor: Colors.indigo.shade100,
                        child: const Text(
                          'Already Have an Account ? Login',
                          style: TextStyle(
                            color: Colors.indigo,
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
