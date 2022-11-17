import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/controllers/bannerController.dart';
import 'package:hamro_electronics/controllers/wishlistController.dart';
import 'package:hamro_electronics/screens/widgets/shimmers/homeCategoryShimmer.dart';
import 'package:hamro_electronics/screens/widgets/shimmers/homeProductShimmer.dart';

import '../controllers/brandController.dart';
import '../controllers/categoryController.dart';
import '../controllers/couponController.dart';
import '../controllers/productController.dart';
import '../controllers/shippingController.dart';
import '../models/product.dart';
import '../screens/categoryViewScreen.dart';
import '../screens/productView.dart';
import '../screens/widgets/homeCategory.dart';
import '../screens/widgets/productItem.dart';

import '../models/category.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    ref.read(brandProvider.notifier).fetchBrand();
    ref.read(shippingProvider.notifier).fetchShipping();
    ref.read(couponProvider.notifier).fetchCoupon();
    ref.read(bannerProvider.notifier).fetchBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* Row with logo,notification and profile button
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: mediaQuery.height * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          print('Goes to Notification Page');
                        },
                        enableFeedback: true,
                        splashColor: Colors.indigo.shade100,
                        iconSize:
                            Theme.of(context).textTheme.headline5!.fontSize,
                        icon: Icon(
                          Icons.notifications_none_sharp,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        width: mediaQuery.width * 0.25,
                      ),
                      IconButton(
                        onPressed: () {
                          List<Product> _products =
                              ref.read(productProvider.notifier).state;
                          showSearch(
                            context: context,
                            delegate: CustomSearch(
                              products: _products,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                    ],
                  ),
                ),
                //* Search Box Code
                // Center(
                //   child: SizedBox(
                //     width: mediaQuery.width * 0.8,
                //     child: Column(
                //       children: [
                //         TextField(
                //           controller: searchController,
                //           decoration: InputDecoration(
                //             floatingLabelBehavior: FloatingLabelBehavior.never,
                //             contentPadding: const EdgeInsets.all(0),
                //             focusedBorder: Theme.of(context)
                //                 .inputDecorationTheme
                //                 .focusedBorder!
                //                 .copyWith(
                //                   borderSide: BorderSide(
                //                     color: Colors.grey.shade500,
                //                   ),
                //                 ),
                //             border: Theme.of(context)
                //                 .inputDecorationTheme
                //                 .focusedBorder!
                //                 .copyWith(
                //                   borderSide: BorderSide(
                //                     color: Colors.grey.shade500,
                //                   ),
                //                 ),
                //             enabledBorder: Theme.of(context)
                //                 .inputDecorationTheme
                //                 .focusedBorder!
                //                 .copyWith(
                //                   borderSide: BorderSide(
                //                     color: Colors.grey.shade500,
                //                   ),
                //                 ),
                //             prefixIcon: Icon(
                //               Icons.search_outlined,
                //               color: Colors.grey.shade500,
                //             ),
                //             labelText: 'Search Products...',
                //             labelStyle: TextStyle(
                //               color: Colors.grey.shade500,
                //             ),
                //           ),
                //           onEditingComplete: () {},
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // SizedBox(
                //   height: mediaQuery.height * 0.02,
                // ),

                Text(
                  'Promotions',
                  style: Theme.of(context).textTheme.headline5,
                ),

                Container(
                  width: double.infinity,
                  height: mediaQuery.height * 0.12,
                  margin: const EdgeInsets.all(
                    8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Colors.indigo,
                  ),
                  child: CarouselSlider(
                    items: ref.watch(bannerProvider.notifier).state.map((e) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        child: Image.network(
                          'https://api.hamroelectronics.com.np/public/${e.photopath}',
                          fit: BoxFit.fill,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      pauseAutoPlayOnTouch: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headline5,
                ),

                ref.watch(fetchCategory).when(
                  data: (data) {
                    data.sort(
                      (a, b) => a.priority.compareTo(b.priority),
                    );
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.height * 0.01),
                      child: SizedBox(
                        width: double.infinity,
                        height: mediaQuery.height * 0.12,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) => InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                CategoryViewScreen.routeName,
                                arguments: data[i].id),
                            child: HomeCategory(
                              name: data[i].categoryName,
                              photopath: data[i].photopath,
                            ),
                          ),
                          itemCount: data.length,
                        ),
                      ),
                    );
                  },
                  error: (e, s) {
                    return Text(e.toString());
                  },
                  loading: () {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: mediaQuery.height * 0.12,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) => const HomeCategoryShimmer(),
                          itemCount: 10,
                        ),
                      ),
                    );
                  },
                ),

                ref.watch(fetchProduct).when(
                      data: (data) {
                        List<Product> saleProducts = data
                            .where(
                              (element) => element.flashsale == 1,
                            )
                            .toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: mediaQuery.height * 0.01,
                                horizontal: mediaQuery.width * 0.02,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sales',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: mediaQuery.height * 0.36,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (ctx, i) => ProductItem(
                                  id: saleProducts[i].id,
                                  discountedPrice:
                                      saleProducts[i].discountedprice,
                                  name: saleProducts[i].name,
                                  photopath: saleProducts[i].photopath1,
                                  price: saleProducts[i].price,
                                  rating: saleProducts[i].rating ?? 0.0,
                                  ratingNumber: saleProducts[i].ratingNumber,
                                ),
                                itemCount: saleProducts.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            )
                          ],
                        );
                      },
                      error: (e, s) {
                        print(s.toString());
                        return Text(e.toString());
                      },
                      loading: () => const HomeProductShimmer(),
                    ),

                ref.watch(fetchProduct).when(
                      data: (data) {
                        List<Category> categories =
                            ref.watch(categoryProvider.notifier).state;

                        return Column(
                          children: categories.map(
                            (category) {
                              List<Product> categoryProduct = data
                                  .where((p) => p.categoryId == category.id)
                                  .toList();

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height * 0.01,
                                      horizontal: mediaQuery.width * 0.02,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          category.categoryName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                CategoryViewScreen.routeName,
                                                arguments: category.id);
                                          },
                                          child: const Text(
                                            'See More',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: mediaQuery.height * 0.36,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (ctx, i) => ProductItem(
                                        id: categoryProduct[i].id,
                                        discountedPrice:
                                            categoryProduct[i].discountedprice,
                                        name: categoryProduct[i].name,
                                        photopath:
                                            categoryProduct[i].photopath1,
                                        price: categoryProduct[i].price,
                                        rating:
                                            categoryProduct[i].rating ?? 0.0,
                                        ratingNumber:
                                            categoryProduct[i].ratingNumber,
                                      ),
                                      itemCount: categoryProduct.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  )
                                ],
                              );
                            },
                          ).toList(),
                        );
                      },
                      error: (e, s) {
                        print(s.toString());
                        return Text(e.toString());
                      },
                      loading: () => const HomeProductShimmer(),
                    ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  final List<Product> products;

  CustomSearch({required this.products});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchQuery = [];
    for (var product in products) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return GridView.builder(
      itemBuilder: (ctx, i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductItem(
            id: matchQuery[i].id,
            discountedPrice: matchQuery[i].discountedprice,
            name: matchQuery[i].name,
            photopath: matchQuery[i].photopath1,
            price: matchQuery[i].price,
            rating: matchQuery[i].rating ?? 0.0,
            ratingNumber: matchQuery[i].ratingNumber,
          ),
        );
      },
      itemCount: matchQuery.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.59,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];
    for (var product in products) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return ListTile(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductView.routeName, arguments: matchQuery[i].id);
          },
          title: Text(matchQuery[i].name),
        );
      },
      itemCount: matchQuery.length,
    );
  }
}
