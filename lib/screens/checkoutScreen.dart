import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hamro_electronics/controllers/couponController.dart';
import 'package:hamro_electronics/controllers/orderController.dart';
import 'package:hamro_electronics/controllers/productController.dart';
import 'package:hamro_electronics/controllers/shippingController.dart';
import 'package:hamro_electronics/features/cart/presentation/controllers/cartController.dart';

import 'package:hamro_electronics/models/coupon.dart';
import 'package:hamro_electronics/models/product.dart';
import 'package:hamro_electronics/models/shipping.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  static const routeName = "/checkout";
  const CheckoutScreen({super.key});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final orderKey = GlobalKey<FormState>();
  final _couponKey = GlobalKey<FormState>();

  int deliveryCharge = 0;
  String phone = '';
  String fullname = '';
  int shippingId = 0;
  int couponId = 0;
  String shippingAddress = '';
  int couponAmount = 0;

  String coupon = '';

  getuserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString('user');

    var userDecoded = json.decode(userInfo!) as Map<String, dynamic>;

    setState(() {
      fullname = userDecoded["name"];
      phone = userDecoded["phone_number"] ?? '';
      shippingAddress = userDecoded["address"] ?? '';
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: Theme.of(context).textTheme.headline6!.fontSize,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ref.watch(cartControllerProvider).when(
            data: (data) {
              int total = 0;
              List<String> cartId = [];

              for (var cart in data) {
                Product product = ref
                    .read(productProvider.notifier)
                    .findProduct(cart.productId);
                if (product.discountedprice > 0) {
                  total = total + product.discountedprice * cart.quantity;
                } else {
                  total = total + product.price * cart.quantity;
                }
                cartId.add(cart.id.toString());
              }
              List<Shipping> shipping =
                  ref.watch(shippingProvider.notifier).state;
              List<Coupon> coupons = ref.watch(couponProvider.notifier).state;

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
                              'Shipping Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(),
                            ),
                          ),
                          const Divider(),
                          Form(
                            key: orderKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    initialValue: phone,
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
                                      phone = newValue!;
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
                                    initialValue: shippingAddress,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      prefixIcon: Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.indigo.shade400,
                                      ),
                                      labelText: 'Enter Your Address',
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (newValue) {
                                      shippingAddress = newValue!;
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
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      prefixIcon: Icon(
                                        Icons.person_pin_circle_outlined,
                                        color: Colors.indigo.shade400,
                                      ),
                                      labelText: 'Select Shipping Area',
                                    ),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Select Shipping Area';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: shipping.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e.name),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        deliveryCharge = value!.price;
                                        shippingId = value.id;
                                      });
                                    },
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: mediaQuery.height * 0.02),
                                      child: Text(
                                        'Coupon Code',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.indigo,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: mediaQuery.width * 0.622,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    mediaQuery.height * 0.01),
                                            child: Form(
                                              key: _couponKey,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  prefixIcon: Icon(
                                                    Icons.discount,
                                                    color:
                                                        Colors.indigo.shade400,
                                                  ),
                                                  labelText:
                                                      'Apply Coupon Code',
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    coupon = value;
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  for (var c in coupons) {
                                                    if (c.name.toLowerCase() ==
                                                        coupon.toLowerCase()) {
                                                      if (total <
                                                              c.maxDisAmount &&
                                                          total > c.minAmount) {
                                                        if (c.isAvailable ==
                                                            1) {
                                                          if (c.isAmoount ==
                                                              1) {
                                                            couponId = c.id;
                                                            couponAmount =
                                                                c.offerAmount;
                                                          }
                                                          if (c.isPercent ==
                                                              1) {
                                                            couponId = c.id;
                                                            couponAmount = (total *
                                                                    (c.offerPercent /
                                                                        100))
                                                                .toInt();
                                                          }
                                                        } else {
                                                          couponId = 0;
                                                          couponAmount = 0;
                                                          coupon = '';
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content:
                                                                  const Text(
                                                                'The Coupon Has Expired',
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      } else {
                                                        couponId = 0;
                                                        couponAmount = 0;
                                                        coupon = '';

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: const Text(
                                                              'Your Total amount doesnot match for this coupon code',
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      couponId = 0;
                                                      couponAmount = 0;
                                                      coupon = '';

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: const Text(
                                                            'This Coupon in Invalid',
                                                          ),
                                                          backgroundColor:
                                                              Colors.red,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                  FocusScope.of(context)
                                                      .nextFocus();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: mediaQuery.width * 0.02,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            disabledBackgroundColor:
                                                Colors.indigo.shade200,
                                            disabledForegroundColor:
                                                Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                          ),
                                          onPressed: coupon.isEmpty
                                              ? null
                                              : () {
                                                  _couponKey.currentState!
                                                      .save();
                                                  for (var c in coupons) {
                                                    if (c.name.toLowerCase() ==
                                                        coupon.toLowerCase()) {
                                                      if (total <
                                                              c.maxDisAmount &&
                                                          total > c.minAmount) {
                                                        if (c.isAvailable ==
                                                            1) {
                                                          if (c.isAmoount ==
                                                              1) {
                                                            couponId = c.id;
                                                            couponAmount =
                                                                c.offerAmount;
                                                          }
                                                          if (c.isPercent ==
                                                              1) {
                                                            couponId = c.id;
                                                            couponAmount = (total *
                                                                    (c.offerPercent /
                                                                        100))
                                                                .toInt();
                                                          }
                                                        } else {
                                                          couponId = 0;
                                                          couponAmount = 0;
                                                          coupon = '';
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content:
                                                                  const Text(
                                                                'The Coupon Has Expired',
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      } else {
                                                        couponId = 0;
                                                        couponAmount = 0;
                                                        coupon = '';

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: const Text(
                                                              'Your Total amount doesnot match for this coupon code',
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      couponId = 0;
                                                      couponAmount = 0;
                                                      coupon = '';

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: const Text(
                                                            'This Coupon in Invalid',
                                                          ),
                                                          backgroundColor:
                                                              Colors.red,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                          child: const Text('Apply Coupon'),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: mediaQuery.height * 0.02),
                            child: Text(
                              'Order Summary',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding:
                                EdgeInsets.only(top: mediaQuery.height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Items Total ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(),
                                ),
                                Text(
                                  'Rs $total ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(),
                                ),
                              ],
                            ),
                          ),
                          couponAmount > 0
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: mediaQuery.height * 0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Coupon Discount',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(),
                                      ),
                                      Text(
                                        '- Rs $couponAmount ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          Padding(
                            padding:
                                EdgeInsets.only(top: mediaQuery.height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sub Total ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(),
                                ),
                                Text(
                                  'Rs ${total - couponAmount} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: mediaQuery.height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery Charge',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(),
                                ),
                                Text(
                                  'Rs $deliveryCharge  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: mediaQuery.height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Grand Total ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(),
                                ),
                                Text(
                                  'Rs ${total + deliveryCharge - couponAmount} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          orderKey.currentState!.save();
                          if (!orderKey.currentState!.validate()) {
                            return;
                          }

                          ref
                              .read(orderProvider.notifier)
                              .placeOrder(
                                cartId,
                                shippingId,
                                couponId,
                                couponAmount,
                                deliveryCharge,
                                shippingAddress,
                                phone,
                                fullname,
                              )
                              .then((value) {
                            final extractedData = json.decode(value.body);
                            if (value.statusCode == 200) {
                              if (extractedData['status'] == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
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
                                for (var cart in data) {
                                  ref
                                      .read(cartControllerProvider.notifier)
                                      .updateOrder(cart.id)
                                      .then((value) {
                                    if (value) {
                                      ref.refresh(cartControllerProvider);
                                    }
                                  });
                                }
                                Navigator.of(context).pop();
                              }
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
                ),
              );
            },
            error: (e, s) => Text(e.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(
                strokeWidth: 0.7,
              ),
            ),
          ),
    );
  }
}
