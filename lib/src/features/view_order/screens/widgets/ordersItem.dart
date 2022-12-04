import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/screen/productView.dart';

class OrdersItem extends ConsumerStatefulWidget {
  final int id;
  final String name;
  final String size;
  final String photopath;
  final String color;
  final int quantity;
  final String reason;

  const OrdersItem({
    required this.id,
    required this.photopath,
    required this.color,
    required this.name,
    required this.quantity,
    required this.size,
    required this.reason,
    super.key,
  });

  @override
  OrdersItemState createState() => OrdersItemState();
}

class OrdersItemState extends ConsumerState<OrdersItem> {
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        ProductView.routeName,
        arguments: widget.id,
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://www.api.hamroelectronics.com.np/public/${widget.photopath}',
                width: mediaQuery.width * 0.2,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.05,
                  vertical: mediaQuery.height * 0.01),
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
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: [
                        const Text(
                          'Quantity:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.quantity.toString()),
                      ],
                    ),
                  ),
                  widget.reason.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [
                              const Text(
                                'Reason:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.reason,
                                style: TextStyle(
                                  color: Colors.red.shade500,
                                ),
                              ),
                            ],
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
