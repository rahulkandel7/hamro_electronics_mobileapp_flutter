import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/controllers/brandController.dart';
import 'package:hamro_electronics/controllers/categoryController.dart';
import 'package:hamro_electronics/controllers/productController.dart';
import 'package:hamro_electronics/models/product.dart';
import 'package:hamro_electronics/screens/categoryViewScreen.dart';

import 'package:hamro_electronics/screens/widgets/homeCategory.dart';
import 'package:hamro_electronics/screens/widgets/productItem.dart';

import '../models/category.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(brandProvider.notifier).fetchBrand();
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
                      CircleAvatar(
                        backgroundColor: Colors.indigo.shade300,
                        child: const Text(
                          'A',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                //* Search Box Code
                Center(
                  child: SizedBox(
                    width: mediaQuery.width * 0.8,
                    child: TextField(
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.all(0),
                        focusedBorder: Theme.of(context)
                            .inputDecorationTheme
                            .focusedBorder!
                            .copyWith(
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                        border: Theme.of(context)
                            .inputDecorationTheme
                            .focusedBorder!
                            .copyWith(
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                        enabledBorder: Theme.of(context)
                            .inputDecorationTheme
                            .focusedBorder!
                            .copyWith(
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey.shade500,
                        ),
                        labelText: 'Search Products...',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.02,
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
                      loading: () => const CircularProgressIndicator(),
                    ),

                Text(
                  'Promotions',
                  style: Theme.of(context).textTheme.headline5,
                ),

                Container(
                  width: double.infinity,
                  height: mediaQuery.height * 0.2,
                  margin: const EdgeInsets.all(
                    8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Colors.indigo,
                  ),
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
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
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
