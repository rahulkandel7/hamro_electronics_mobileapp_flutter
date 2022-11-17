import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/controllers/categoryController.dart';
import '/controllers/productController.dart';
import '/controllers/subCategoryController.dart';
import '/models/category.dart';
import '/models/product.dart';
import '/models/subCategory.dart';
import '/screens/widgets/productItem.dart';

class CategoryViewScreen extends ConsumerStatefulWidget {
  static const routeName = '/categoryViewScreen';
  const CategoryViewScreen({super.key});

  @override
  CategoryViewScreenState createState() => CategoryViewScreenState();
}

class CategoryViewScreenState extends ConsumerState<CategoryViewScreen> {
  List<Product> subProducts = [];

  int _value = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int id = ModalRoute.of(context)!.settings.arguments as int;
    Category category = ref.watch(categoryProvider.notifier).findCategory(id);
    List<Product> products =
        ref.watch(productProvider.notifier).findByCategory(id);
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
        title: Text(
          category.categoryName,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.indigo,
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            children: [
              ref.watch(fetchSubCategory).when(
                    data: (data) {
                      data.sort(
                        (a, b) => a.priority.compareTo(b.priority),
                      );
                      List<SubCategory> subCategory = data
                          .where(
                            (element) => element.categoryId == category.id,
                          )
                          .toList();

                      return subCategory.isNotEmpty
                          ? SizedBox(
                              height: size.height * 0.05,
                              child: ListView.builder(
                                itemBuilder: (ctx, i) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.01,
                                    ),
                                    child: ChoiceChip(
                                      key: UniqueKey(),
                                      onSelected: (selected) {
                                        setState(() {
                                          _value = subCategory[i].id;
                                          subProducts = ref
                                              .read(productProvider.notifier)
                                              .findBySubCategory(
                                                  subCategory[i].id);
                                        });
                                      },
                                      selectedColor: Theme.of(context)
                                          .chipTheme
                                          .selectedColor,
                                      backgroundColor: Theme.of(context)
                                          .chipTheme
                                          .backgroundColor,
                                      elevation: 1,
                                      labelStyle: Theme.of(context)
                                          .chipTheme
                                          .labelStyle,
                                      label:
                                          Text(subCategory[i].subCategoryName),
                                      selected: _value == subCategory[i].id,
                                    ),
                                  );
                                },
                                itemCount: subCategory.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            )
                          : const SizedBox();
                    },
                    error: (e, s) => Text(e.toString()),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              _value != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _value = 0;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.close,
                            size:
                                Theme.of(context).textTheme.bodySmall!.fontSize,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              _value == 0
                  ? SizedBox(
                      height: size.height * 0.82,
                      child: GridView.builder(
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: size.height * 0.01),
                            child: ProductItem(
                              id: products[i].id,
                              discountedPrice: products[i].discountedprice,
                              name: products[i].name,
                              photopath: products[i].photopath1,
                              price: products[i].price,
                              rating: products[i].rating ?? 0.0,
                              ratingNumber: products[i].ratingNumber,
                            ),
                          );
                        },
                        itemCount: products.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                        ),
                      ),
                    )
                  : subProducts.isEmpty
                      ? Text(
                          'No Products Yet!',
                          style: Theme.of(context).textTheme.headline4,
                        )
                      : SizedBox(
                          height: _value != 0
                              ? size.height * 0.77
                              : size.height * 0.82,
                          child: GridView.builder(
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(bottom: size.height * 0.01),
                                child: ProductItem(
                                  id: subProducts[i].id,
                                  discountedPrice:
                                      subProducts[i].discountedprice,
                                  name: subProducts[i].name,
                                  photopath: subProducts[i].photopath1,
                                  price: subProducts[i].price,
                                  rating: subProducts[i].rating ?? 0.0,
                                  ratingNumber: subProducts[i].ratingNumber,
                                ),
                              );
                            },
                            itemCount: subProducts.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.58,
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
