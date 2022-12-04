import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../checkout/screen/checkoutScreen.dart';
import '../../product/controller/productController.dart';
import '../../product/model/product.dart';
import '../controller/cartController.dart';
import '../model/cart.dart';
import 'widgets/cartItem.dart';

class CartScreen extends ConsumerWidget {
  static const routeName = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'My Cart',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.indigo,
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.04),
        child: ref.watch(fetchCart).when(
              data: (datas) {
                List<Cart> data = datas
                    .where(
                      (element) => element.ordered == 0,
                    )
                    .toList();
                return data.isEmpty
                    ? Center(
                        child: Image.asset('assets/images/CartEmpty.png'),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: mediaQuery.height * 0.71,
                            child: ListView.builder(
                              itemBuilder: (ctx, i) {
                                Product product = ref
                                    .read(productProvider.notifier)
                                    .findProduct(data[i].productId);
                                return CartItem(
                                  id: data[i].id,
                                  photopath: product.photopath1,
                                  color: data[i].color,
                                  discountedPrice: product.discountedprice,
                                  name: product.name,
                                  price: data[i].price,
                                  quantity: data[i].quantity,
                                  size: data[i].size,
                                  stock: product.stock,
                                );
                              },
                              itemCount: data.length,
                            ),
                          ),
                          //* For Place Order section

                          data.isNotEmpty
                              ? Container(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            1000,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(16)),
                                    onPressed: () {
                                      ref.refresh(cartProvider);
                                      Navigator.of(context)
                                          .pushNamed(CheckoutScreen.routeName);
                                    },
                                    child: const Text(
                                      'Procced To Checkout',
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      );
              },
              error: (e, s) {
                return Text(s.toString());
              },
              loading: () => const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 0.7,
              )),
            ),
      ),
    );
  }
}
