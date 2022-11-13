import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/controllers/brandController.dart';

import '/controllers/productController.dart';
import '/models/brand.dart';

import '/models/product.dart';

class ProductView extends ConsumerStatefulWidget {
  static const routeName = '/productView';
  const ProductView({super.key});

  @override
  ProductViewState createState() => ProductViewState();
}

class ProductViewState extends ConsumerState<ProductView> {
  String productPhotopath = "";

  showSmallPhoto(String photopath, Size mediaQuery) {
    bool isActive = productPhotopath == photopath ? true : false;
    return InkWell(
      onTap: () => setState(() {
        productPhotopath = photopath;
      }),
      child: Container(
        padding: const EdgeInsets.all(3.0),
        margin: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.01),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? Colors.indigo.shade300 : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://api.hamroelectronics.com.np/public/$photopath',
            width: mediaQuery.width * 0.1,
          ),
        ),
      ),
    );
  }

  showStar(BuildContext context, double rating) {
    if (rating.toInt() == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
        ],
      );
    }
    if (rating.toInt() == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.star,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize,
            color: Colors.yellow.shade700,
          ),
        ],
      );
    }
    if (rating.toInt() == 2) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
          ],
        ),
      );
    }
    if (rating.toInt() == 3) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
          ],
        ),
      );
    }
    if (rating.toInt() == 4) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
          ],
        ),
      );
    }
    if (rating.toInt() == 5) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color: Colors.yellow.shade700,
            ),
          ],
        ),
      );
    }
  }

  productInfo(Size mediaQuery, String title, String value) {
    return Padding(
      padding: EdgeInsets.only(top: mediaQuery.height * 0.01),
      child: Row(
        children: [
          // SizedBox(
          //   width: mediaQuery.width * 0.16,
          //   child: Text(
          //     '$title :',
          //     style: Theme.of(context)
          //         .textTheme
          //         .headline6!
          //         .copyWith(fontWeight: FontWeight.w300),
          //   ),
          // ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  String size = " ";
  String color = " ";

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    int id = ModalRoute.of(context)!.settings.arguments as int;
    Product product = ref.watch(productProvider.notifier).findProduct(id);
    Brand brand = ref.watch(brandProvider.notifier).getBrand(product.brandId);
    int off = ((product.price - product.discountedprice) / product.price * 100)
        .toInt();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.indigo,
            size: Theme.of(context).textTheme.headline6!.fontSize,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* For Showing Product Details
            SizedBox(
              height: mediaQuery.height * 0.82,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * Image Zoom Section
                    InteractiveViewer(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: productPhotopath == ""
                            ? Image.network(
                                'https://api.hamroelectronics.com.np/public/${product.photopath1}',
                                height: mediaQuery.height * 0.4,
                                width: double.infinity,
                              )
                            : Image.network(
                                'https://api.hamroelectronics.com.np/public/$productPhotopath',
                                height: mediaQuery.height * 0.4,
                                width: double.infinity,
                              ),
                      ),
                    ),
                    // * Image Changing Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: mediaQuery.height * 0.02,
                      ),
                      child: Row(
                        children: [
                          showSmallPhoto(product.photopath1, mediaQuery),
                          product.photopath2.isNotEmpty
                              ? showSmallPhoto(product.photopath2, mediaQuery)
                              : const SizedBox(),
                          product.photopath3.isNotEmpty
                              ? showSmallPhoto(product.photopath3, mediaQuery)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    // * Product Information Showing Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: mediaQuery.width * 0.67,
                          child: Text(
                            product.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Row(
                          children: [
                            showStar(context, product.rating ?? 0),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text('(${product.ratingNumber})'),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: mediaQuery.height * 0.02),
                      child: Row(
                        children: [
                          product.discountedprice > 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Rs ${product.discountedprice}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: Text(
                                        'Rs ${product.price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              color: Colors.red.shade500,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 17,
                                            ),
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Rs ${product.price}',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                          off < 100
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 9.0),
                                  child: Container(
                                    width: mediaQuery.width * 0.13,
                                    height: mediaQuery.height * 0.036,
                                    padding: EdgeInsets.only(
                                      left: mediaQuery.width * 0.02,
                                      right: mediaQuery.width * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.indigo.shade500,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '- $off %',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),

                    productInfo(mediaQuery, 'Brand', brand.brandName),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: product.size.split(',').map((s) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mediaQuery.width * 0.01,
                          ),
                          child: Wrap(
                            children: [
                              ChoiceChip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    7,
                                  ),
                                ),
                                backgroundColor: Colors.indigo.shade200,
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                selected: s.contains(size),
                                onSelected: (value) {
                                  setState(() {
                                    size = s;
                                  });
                                },
                                tooltip: s,
                                selectedShadowColor: Colors.indigo.shade300,
                                selectedColor: Colors.indigo,
                                label: Text(s),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: product.color.split(',').map((c) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mediaQuery.width * 0.01,
                          ),
                          child: Wrap(
                            children: [
                              ChoiceChip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    7,
                                  ),
                                ),
                                backgroundColor: Colors.indigo.shade200,
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                selected: c.contains(color),
                                onSelected: (value) {
                                  setState(() {
                                    color = c;
                                  });
                                },
                                tooltip: c,
                                selectedShadowColor: Colors.indigo.shade300,
                                selectedColor: Colors.indigo,
                                label: Text(c),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    // Html(data: product.description),
                  ],
                ),
              ),
            ),
            //* For add To Cart Section section
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: mediaQuery.height * 0.01),
              height: mediaQuery.height * 0.06,
              decoration: BoxDecoration(
                // color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  1000,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                    color: Colors.grey.shade300,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: mediaQuery.height * 0.04,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          1000,
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.remove,
                              size: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .fontSize,
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          IconButton(
                            onPressed: () {
                              if (quantity < product.stock) {
                                setState(() {
                                  quantity++;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.add,
                              size: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .fontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            1000,
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Add To Cart',
                        style: TextStyle(
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
