import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../productView.dart';

class ProductItem extends StatefulWidget {
  final int id;
  final String name;
  final int price;
  final int discountedPrice;
  final int ratingNumber;
  final double? rating;
  final String photopath;

  const ProductItem(
      {required this.id,
      required this.discountedPrice,
      required this.name,
      required this.photopath,
      required this.price,
      required this.rating,
      required this.ratingNumber,
      super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int percent = 0;

  getPercent() {
    double off = (widget.price - widget.discountedPrice) / widget.price * 100;
    setState(() {
      percent = off.toInt();
    });
  }

  showStar(BuildContext context, int rating) {
    if (rating == 0) {
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
    if (rating == 1) {
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
    if (rating == 2) {
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
    if (rating == 3) {
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
    if (rating == 4) {
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
    if (rating == 5) {
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

  @override
  void initState() {
    getPercent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaQuery.width * 0.46,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => Navigator.of(context)
            .pushNamed(ProductView.routeName, arguments: widget.id),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          color: Colors.grey.shade100,
          shadowColor: Colors.grey.shade100,
          margin: EdgeInsets.only(right: mediaQuery.width * 0.05),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://api.hamroelectronics.com.np/public/${widget.photopath}',
                        placeholder: (context, url) =>
                            Image.asset('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: mediaQuery.width * 0.012,
                      right: mediaQuery.width * 0.012,
                      top: mediaQuery.height * 0.01,
                      bottom: mediaQuery.height * 0.003,
                    ),
                    child: Text(
                      widget.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      showStar(context, widget.rating!.toInt()),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4,
                        ),
                        child: Text(
                          '(${widget.ratingNumber})',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                  widget.discountedPrice > 0
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mediaQuery.width * 0.03,
                            vertical: mediaQuery.height * 0.005,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rs ${widget.discountedPrice}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    'Rs ${widget.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.red.shade800,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width * 0.02,
                              vertical: mediaQuery.height * 0.01),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Rs ${widget.price}',
                              softWrap: true,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                ],
              ),
              Visibility(
                visible: percent == 100 ? false : true,
                child: Positioned(
                  top: -3,
                  right: 5,
                  child: Chip(
                    backgroundColor: Colors.indigo,
                    label: Text(
                      '$percent %off',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
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
