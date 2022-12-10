import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/cart/presentation/controllers/cartController.dart';

class CartItem extends ConsumerStatefulWidget {
  final int id;
  final String name;
  final String size;
  final String photopath;
  final String color;
  int quantity;
  final int price;
  final int discountedPrice;
  final int stock;

  CartItem({
    required this.id,
    required this.photopath,
    required this.color,
    required this.discountedPrice,
    required this.name,
    required this.price,
    required this.quantity,
    required this.size,
    required this.stock,
    super.key,
  });

  @override
  CartItemState createState() => CartItemState();
}

class CartItemState extends ConsumerState<CartItem> {
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.red.shade500,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: 10,
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        ref
            .read(cartControllerProvider.notifier)
            .deleteCart(widget.id)
            .then((value) {
          if (value) {
            ref.refresh(cartControllerProvider);
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Item Removed From Cart Successfully',
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
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade50,
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 3),
              blurRadius: 10,
              spreadRadius: 3,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://www.api.hamroelectronics.com.np/public/${widget.photopath}',
                width: mediaQuery.width * 0.2,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mediaQuery.width * 0.47,
                    child: Text(
                      widget.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: [
                        const Text(
                          'Size:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.size),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: [
                        const Text(
                          'Color:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.color),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: widget.discountedPrice > 0
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Rs ${widget.discountedPrice}',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Rs ${widget.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.red.shade500,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                            ],
                          )
                        : Text(
                            'Rs ${widget.price}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.quantity > 1) {
                        setState(() {
                          widget.quantity--;
                        });
                        ref
                            .read(cartControllerProvider.notifier)
                            .updateQuantity(widget.id, widget.quantity);
                      }
                    });
                  },
                  icon: Icon(
                    Icons.remove,
                    size: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  ),
                ),
                Text(
                  widget.quantity.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  onPressed: () {
                    if (widget.quantity < widget.stock) {
                      setState(() {
                        widget.quantity++;
                      });
                      ref
                          .read(cartControllerProvider.notifier)
                          .updateQuantity(widget.id, widget.quantity);
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    size: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
