import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/edit-profile";
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final editKey = GlobalKey<FormState>();

  File _image = File('');
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _buildImage(Size mediaQuery) {
    if (_image == null) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Text('Select Image'),
      );
    } else {
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
  }

  String fullname = "";
  String address = "";
  String email = "";
  String phonenumber = "";
  String gender = "";
  String photopath = "";

  getuserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString('user');

    var userDecoded = json.decode(userInfo!) as Map<String, dynamic>;

    setState(() {
      fullname = userDecoded["name"];
      phonenumber = userDecoded["phone_number"] ?? '';
      address = userDecoded["address"] ?? '';
      email = userDecoded['email'];
      gender = userDecoded['gender'];
      photopath = userDecoded['profile_photo'];
    });
  }

  @override
  void initState() {
    super.initState();
    getuserInfo();
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
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.indigo,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.indigo,
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.03),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: mediaQuery.height * 0.02),
                      child: Text(
                        'Edit Details',
                        style:
                            Theme.of(context).textTheme.headline6!.copyWith(),
                      ),
                    ),
                    const Divider(),
                    Form(
                      // key: editKey,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image.network(
                                                'https://api.hamroelectronics.com.np/public/$photopath'),
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
                              initialValue: fullname,
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
                              initialValue: email,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.indigo.shade400,
                                ),
                                labelText: 'Enter Your Email Address ',
                              ),
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
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: mediaQuery.height * 0.01),
                            child: TextFormField(
                              initialValue: phonenumber,
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
                              initialValue: address,
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
                    InkWell(
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
                            vertical: mediaQuery.height * 0.018,
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width * 0.1),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Confirm Order',
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
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
