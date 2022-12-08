import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/controllers/cartController.dart';
import 'package:hamro_electronics/controllers/commentController.dart';
import 'package:hamro_electronics/features/brand/presentation/controllers/brandController.dart';
import 'package:hamro_electronics/features/wihslist/presentation/controller/wishlistController.dart';
import 'package:hamro_electronics/models/comment.dart';
import 'package:hamro_electronics/features/wihslist/data/model/wishlist.dart';
import 'package:hamro_electronics/screens/cartScreen.dart';
import 'package:hamro_electronics/features/auth/presentation/screens/loginScreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/controllers/productController.dart';
import '../features/brand/data/models/brand.dart';

import '/models/product.dart';
import 'widgets/productItem.dart';

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
          child: CachedNetworkImage(
            imageUrl: 'https://api.hamroelectronics.com.np/public/$photopath',
            width: mediaQuery.width * 0.1,
            placeholder: (context, url) =>
                Image.asset('assets/images/logo.png'),
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
            size: Theme.of(context).textTheme.headline6!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.headline6!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.headline6!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.headline6!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.headline6!.fontSize,
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
            size: Theme.of(context).textTheme.headline6!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.headline6!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.headline6!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.headline6!.fontSize,
            color: Colors.yellow.shade700,
          ),
          Icon(
            Icons.star_border,
            size: Theme.of(context).textTheme.headline6!.fontSize,
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
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.headline6!.fontSize,
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
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.headline6!.fontSize,
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
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star_border,
              size: Theme.of(context).textTheme.headline6!.fontSize,
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
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
            Icon(
              Icons.star,
              size: Theme.of(context).textTheme.headline6!.fontSize,
              color: Colors.yellow.shade700,
            ),
          ],
        ),
      );
    }
  }

  String size = " ";
  String color = " ";

  int quantity = 1;

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
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    int id = ModalRoute.of(context)!.settings.arguments as int;
    Product product = ref.watch(productProvider.notifier).findProduct(id);
    Brand brand =
        ref.watch(brandControllerProvider.notifier).getBrand(product.brandId);
    int off = ((product.price - product.discountedprice) / product.price * 100)
        .toInt();

    List<Product> suggestedProducts =
        ref.watch(productProvider.notifier).findByCategory(product.categoryId);

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
          isLogin
              ? ref.watch(wishlistControllerProvider).when(
                  data: (data) {
                    List<Wishlist> wishlists = data
                        .where((element) => element.productId == id)
                        .toList();

                    bool isWishlist = wishlists.isEmpty ? false : true;
                    return IconButton(
                      onPressed: () {
                        ref
                            .read(wishlistControllerProvider.notifier)
                            .addToWishlist(product.id)
                            .then((value) {
                          if (value) {
                            ref.refresh(wishlistControllerProvider);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Something Went Wrong',
                                ),
                              ),
                            );
                          }
                        });
                      },
                      icon: Icon(
                        isWishlist ? Icons.favorite : Icons.favorite_border,
                        color: isWishlist ? Colors.red : Colors.indigo,
                      ),
                    );
                  },
                  error: (e, s) => Text(e.toString()),
                  loading: () => const SizedBox())
              : const SizedBox(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* For Showing Product Details
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.width * 0.04,
            ),
            child: SizedBox(
              height: mediaQuery.height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * Image Zoom Section
                    InteractiveViewer(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: productPhotopath == ""
                              ? CachedNetworkImage(
                                  imageUrl:
                                      'https://api.hamroelectronics.com.np/public/${product.photopath1}',
                                  height: mediaQuery.height * 0.48,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Image.asset('assets/images/logo.png'),
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      'https://api.hamroelectronics.com.np/public/$productPhotopath',
                                  height: mediaQuery.height * 0.48,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Image.asset('assets/images/logo.png'),
                                )),
                    ),
                    // * Image Changing Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: mediaQuery.height * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              showSmallPhoto(product.photopath1, mediaQuery),
                              product.photopath2.isNotEmpty
                                  ? showSmallPhoto(
                                      product.photopath2, mediaQuery)
                                  : const SizedBox(),
                              product.photopath3.isNotEmpty
                                  ? showSmallPhoto(
                                      product.photopath3, mediaQuery)
                                  : const SizedBox(),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                    ),
                    // * Product Information Showing Section
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      brand.brandName,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: mediaQuery.height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              product.discountedprice > 0
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Rs ${product.discountedprice}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3.0),
                                          child: Text(
                                            'Rs ${product.price}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                  color: Colors.red.shade500,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 17,
                                                ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'Rs ${product.price}',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                              off < 100
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 9.0),
                                      child: Container(
                                        width: mediaQuery.width * 0.16,
                                        height: mediaQuery.height * 0.036,
                                        padding: EdgeInsets.only(
                                          left: mediaQuery.width * 0.02,
                                          right: mediaQuery.width * 0.02,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.indigo,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Share.share(
                                    'https://react.hamroelectronics.com.np/product/view/${product.id}');
                              },
                              color: Colors.white,
                              icon: const Icon(
                                Icons.share,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Row(
                      children: [
                        Text(
                          'Size: ',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                    backgroundColor: Colors.indigo.shade300,
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
                                    selectedColor: Colors.indigo.shade800,
                                    label: Text(s),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Color: ',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                    backgroundColor: Colors.indigo.shade300,
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
                                    selectedColor: Colors.indigo.shade800,
                                    label: Text(c),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      title: Text(
                        'Description',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      children: [
                        Html(data: product.description),
                      ],
                    ),

                    ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      title: Text(
                        'Rating',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      children: [
                        // Html(data: product.description),
                        Text(product.description),
                      ],
                    ),

                    ExpansionTile(
                      tilePadding: const EdgeInsets.all(0),
                      title: Text(
                        'Review',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      children: [
                        ref.watch(fetchComment(id)).when(
                              data: (data) {
                                List<Comment> comments = data
                                    .where((comment) =>
                                        comment.productId == product.id)
                                    .toList();

                                return SizedBox(
                                  height: mediaQuery.height * 0.3,
                                  child: comments.isEmpty
                                      ? const Center(
                                          child: Text(
                                            'No Reviews Yet',
                                          ),
                                        )
                                      : ListView.builder(
                                          itemBuilder: (ctx, i) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.only(top: 6),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey.shade200,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.grey.shade300,
                                                  ),
                                                ],
                                              ),
                                              child: ListTile(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                title: Row(
                                                  children: [
                                                    Text(
                                                      comments[i].userName,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                            color: Colors
                                                                .grey.shade700,
                                                          ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  mediaQuery
                                                                          .width *
                                                                      0.01),
                                                      child: Text(
                                                        '-',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              color: Colors.grey
                                                                  .shade700,
                                                            ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${DateTime.parse(comments[i].date).day}/${DateTime.parse(comments[i].date).month}/${DateTime.parse(comments[i].date).year}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                            color: Colors
                                                                .grey.shade700,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0),
                                                  child: Text(
                                                    comments[i].comment,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: comments.length,
                                        ),
                                );
                              },
                              error: (e, s) => Text(e.toString()),
                              loading: () => const CircularProgressIndicator(),
                            )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.height * 0.02),
                      child: Text(
                        'Suggested Products',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding:
                              EdgeInsets.only(bottom: mediaQuery.height * 0.01),
                          child: ProductItem(
                            id: suggestedProducts[i].id,
                            discountedPrice:
                                suggestedProducts[i].discountedprice,
                            name: suggestedProducts[i].name,
                            photopath: suggestedProducts[i].photopath1,
                            price: suggestedProducts[i].price,
                            rating: suggestedProducts[i].rating ?? 0.0,
                            ratingNumber: suggestedProducts[i].ratingNumber,
                          ),
                        );
                      },
                      itemCount: suggestedProducts.length > 10
                          ? 10
                          : suggestedProducts.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          //* For add To Cart Section section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.width * 0.04,
            ),
            margin: EdgeInsets.only(
              top: mediaQuery.height * 0.01,
              bottom: mediaQuery.height * 0.004,
            ),
            height: mediaQuery.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(
                10,
              ),
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
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.grey.shade300,
                        ),
                      ],
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
                            size:
                                Theme.of(context).textTheme.headline6!.fontSize,
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
                            size:
                                Theme.of(context).textTheme.headline6!.fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                product.stock == 0
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                1000,
                              ),
                            ),
                          ),
                          onPressed: () {
                            isLogin
                                ? ref
                                    .read(cartProvider.notifier)
                                    .addToCart(
                                        product.id,
                                        color,
                                        size,
                                        product.discountedprice > 0
                                            ? product.discountedprice
                                            : product.price,
                                        quantity)
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
                                          action: SnackBarAction(
                                            label: 'Go To Cart',
                                            textColor: Colors.white,
                                            onPressed: () =>
                                                Navigator.of(context).pushNamed(
                                              CartScreen.routeName,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (extractedData['details'] != null) {
                                      final errors = extractedData['details']
                                          as Map<String, dynamic>;
                                      errors.forEach(
                                        (key, value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                value
                                                    .toString()
                                                    .replaceAll('[', '')
                                                    .replaceAll(']', ''),
                                              ),
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                              action: SnackBarAction(
                                                label: 'Close',
                                                textColor: Colors.white,
                                                onPressed: () {},
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  })
                                : Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontSize,
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.01,
                              ),
                              const Text(
                                'Add To Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
