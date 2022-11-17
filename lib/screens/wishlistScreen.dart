import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hamro_electronics/controllers/productController.dart';
import 'package:hamro_electronics/controllers/wishlistController.dart';
import 'package:hamro_electronics/models/product.dart';
import 'package:hamro_electronics/screens/widgets/shimmers/homeProductShimmer.dart';

import 'package:hamro_electronics/screens/widgets/wishlistItem.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  static const routeName = "/wishlist";
  const WishlistScreen({super.key});

  @override
  WishlistScreenState createState() => WishlistScreenState();
}

class WishlistScreenState extends ConsumerState<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          'My Wishlist',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.indigo,
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ref.watch(fetchWishlist).when(
            data: (data) {
              return SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: SizedBox(
                  height: size.height * 0.82,
                  child: GridView.builder(
                    itemBuilder: (ctx, i) {
                      Product product =
                          ref.read(productProvider.notifier).findProduct(
                                data[i].productId,
                              );
                      return Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.01),
                        child: WishlistItem(
                          id: data[i].id,
                          name: product.name,
                          photopath: product.photopath1,
                          rating: product.rating ?? 0.0,
                          ratingNumber: product.ratingNumber,
                        ),
                      );
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                    ),
                  ),
                ),
              ));
            },
            error: (e, s) => Text(e.toString()),
            loading: () => const SingleChildScrollView(
              child: HomeProductShimmer(),
            ),
          ),
    );
  }
}
