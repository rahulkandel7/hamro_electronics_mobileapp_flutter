import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/wihslist/presentation/controllers/wishlistController.dart';
import 'package:hamro_electronics/features/product_view/presentation/screens/productView.dart';

import '../../../../core/utils/toast.dart';

class WishlistItem extends ConsumerWidget {
  final int id;
  final String name;
  final int ratingNumber;
  final double? rating;
  final String photopath;
  final int productId;

  const WishlistItem({
    required this.id,
    required this.name,
    required this.photopath,
    required this.rating,
    required this.ratingNumber,
    required this.productId,
    super.key,
  });

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
  Widget build(BuildContext context, WidgetRef ref) {
    var mediaQuery = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaQuery.width * 0.45,
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductView.routeName, arguments: productId),
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
                      child: Image.network(
                        'https://api.hamroelectronics.com.np/public/$photopath',
                        // height: mediaQuery.height * 0.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.width * 0.012,
                        vertical: mediaQuery.height * 0.01),
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      showStar(context, rating!.toInt()),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4,
                        ),
                        child: Text(
                          '($ratingNumber)',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    ref
                        .read(wishlistControllerProvider.notifier)
                        .removeFromWishlist(id)
                        .then((value) {
                      if (value[0] == "true") {
                        toast(
                            context: context,
                            label: value[1],
                            color: Colors.indigo);
                      } else {
                        toast(
                            context: context,
                            label: value[1],
                            color: Colors.red);
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
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
