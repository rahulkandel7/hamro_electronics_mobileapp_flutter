import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/userInfoProvider.dart';
import '../../auth/controller/userController.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  static const routeName = "/edit-profile";
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _editKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  FocusNode nameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode addressNode = FocusNode();

  FocusNode currentPasswordNode = FocusNode();
  FocusNode newPasswordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();

  File _image = File('');
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Widget _buildImage(Size mediaQuery) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        height: mediaQuery.height * 0.19,
        width: mediaQuery.width * 0.4,
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                10,
              ),
              child: Image.file(
                _image,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

//* For Info
  String fullname = '';
  String address = '';
  String email = '';
  String phonenumber = '';
  String gender = '';
  String photopath = "";

//* For Password
  String currentpassword = "";
  String newpassword = "";
  String confirmpassword = "";

  @override
  void dispose() {
    super.dispose();
    nameNode.dispose();
    emailNode.dispose();
    phoneNode.dispose();
    addressNode.dispose();
    currentPasswordNode.dispose();
    newPasswordNode.dispose();
    confirmPasswordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Theme.of(context).backgroundColor,
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ref.watch(userInfoProvider).when(
            data: (data) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.03),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: mediaQuery.height * 0.02),
                            child: Text(
                              'Edit Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(),
                            ),
                          ),
                          const Divider(),
                          Form(
                            key: _editKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                !_image.isAbsolute
                                    ? Center(
                                        child: InkWell(
                                          onTap: () => getImage(),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            height: mediaQuery.height * 0.19,
                                            width: mediaQuery.width * 0.4,
                                            decoration: const BoxDecoration(),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                  child: photopath.isEmpty
                                                      ? Image.asset(
                                                          'assets/images/dummy.png')
                                                      : Image.network(
                                                          'https://api.hamroelectronics.com.np/public/$photopath',
                                                          height: mediaQuery
                                                                  .height *
                                                              0.18,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : _buildImage(mediaQuery),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height * 0.01),
                                  child: TextFormField(
                                    focusNode: nameNode,
                                    initialValue: data['name'],
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: Colors.indigo.shade400,
                                      ),
                                      labelText: 'Enter Your Name ',
                                    ),
                                    onSaved: (newValue) {
                                      fullname = newValue!;
                                    },
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(emailNode);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Provide your Full Name ';
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
                                    focusNode: emailNode,
                                    initialValue: data['email'],
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: Colors.indigo.shade400,
                                      ),
                                      labelText: 'Enter Your Email Address ',
                                    ),
                                    readOnly: true,
                                    onSaved: (newValue) {
                                      email = newValue!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Provide your Email Address';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(phoneNode);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height * 0.01),
                                  child: TextFormField(
                                    focusNode: phoneNode,
                                    initialValue: data['phone_number'],
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      prefixIcon: Icon(
                                        Icons.phone_android_outlined,
                                        color: Colors.indigo.shade400,
                                      ),
                                      labelText: 'Enter Your Phone Number ',
                                    ),
                                    keyboardType: TextInputType.phone,
                                    onSaved: (newValue) {
                                      phonenumber = newValue!;
                                    },
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(addressNode);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Provide your Phone Number';
                                      } else if (value.length != 10) {
                                        return 'Please Provide a valid Phone Number';
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
                                    focusNode: addressNode,
                                    initialValue: data['address'],
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      prefixIcon: Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.indigo.shade400,
                                      ),
                                      labelText: 'Enter Your Address',
                                    ),
                                    onSaved: (newValue) {
                                      address = newValue!;
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
                              ],
                            ),
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return InkWell(
                                onTap: () {
                                  _editKey.currentState!.save();
                                  if (!_editKey.currentState!.validate()) {
                                    return;
                                  }
                                  ref
                                      .read(userProvider.notifier)
                                      .updateInfo(fullname, phonenumber,
                                          address, _image.path)
                                      .then((value) {
                                    final extractedData =
                                        json.decode(value.body);

                                    if (extractedData['status'] == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            extractedData['message'],
                                          ),
                                          backgroundColor: Colors.indigo,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            'Something Went Wrong',
                                          ),
                                          backgroundColor: Colors.indigo,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: mediaQuery.height * 0.02,
                                    top: mediaQuery.height * 0.02,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height * 0.01,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: mediaQuery.width * 0.1),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Update Info',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: mediaQuery.height * 0.01),
                            child: Text(
                              'Update Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(),
                            ),
                          ),
                          const Divider(),
                          Form(
                            key: _passwordKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height * 0.01),
                                  child: TextFormField(
                                    focusNode: currentPasswordNode,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                        color: Colors.indigo.shade400,
                                      ),
                                      labelText: 'Enter Your Current Password ',
                                    ),
                                    onSaved: (newValue) {
                                      currentpassword = newValue!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Provide your Current Password ';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(newPasswordNode);
                                    },
                                    obscureText: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height * 0.01),
                                  child: TextFormField(
                                    focusNode: newPasswordNode,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                        color: Colors.indigo.shade400,
                                      ),
                                      labelText: 'Enter Your New Password ',
                                    ),
                                    onChanged: (value) {
                                      newpassword = value;
                                    },
                                    onSaved: (newValue) {
                                      newpassword = newValue!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Provide your New Password';
                                      } else if (value.length < 8) {
                                        return 'Password Length Must Be Greater Than 8 ';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(confirmPasswordNode);
                                    },
                                    obscureText: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height * 0.01),
                                  child: TextFormField(
                                    focusNode: confirmPasswordNode,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      prefixIcon: Icon(
                                        Icons.password_outlined,
                                        color: Colors.indigo.shade400,
                                      ),
                                      labelText: 'Confirm Your New Password ',
                                    ),
                                    onSaved: (newValue) {
                                      confirmpassword = newValue!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Confirm your Password';
                                      } else if (value.length < 8) {
                                        return 'Password Length Must Be Greater Than 8 ';
                                      } else if (value != newpassword) {
                                        return 'Your Password Doesnot match';
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return InkWell(
                                onTap: () {
                                  _passwordKey.currentState!.save();
                                  if (!_passwordKey.currentState!.validate()) {
                                    return;
                                  }
                                  ref
                                      .read(userProvider.notifier)
                                      .changePassword(
                                          currentpassword, newpassword)
                                      .then((value) {
                                    final extractedData =
                                        json.decode(value.body);

                                    if (extractedData['status'] == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            extractedData['message'],
                                          ),
                                          backgroundColor: Colors.indigo,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    }
                                    if (extractedData['status'] == false) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            extractedData['message'],
                                          ),
                                          backgroundColor: Colors.indigo,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: mediaQuery.height * 0.02,
                                    top: mediaQuery.height * 0.02,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height * 0.01,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: mediaQuery.width * 0.1),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Update Password',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (e, s) => Text(e.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
