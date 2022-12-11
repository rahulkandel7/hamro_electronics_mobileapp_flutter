import 'package:flutter/material.dart';

class WishlistShimmer extends StatelessWidget {
  const WishlistShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: mediaQuery.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.01,
            ),
            Container(
              height: mediaQuery.height * 0.02,
              width: mediaQuery.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: mediaQuery.height * 0.02,
              width: mediaQuery.width * 0.36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
