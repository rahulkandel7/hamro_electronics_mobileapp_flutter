import 'package:flutter/material.dart';

class HomeCategoryShimmer extends StatelessWidget {
  const HomeCategoryShimmer({super.key});

  shimmer(Size mediaQuery) {
    return Padding(
      padding: EdgeInsets.all(mediaQuery.width * 0.01),
      child: Column(
        children: [
          Container(
            height: mediaQuery.height * 0.06,
            width: mediaQuery.width * 0.17,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.07),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            height: mediaQuery.height * 0.02,
            width: mediaQuery.width * 0.16,
            margin: const EdgeInsets.only(
              top: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              color: Colors.black.withOpacity(0.07),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        shimmer(mediaQuery),
      ],
    );
  }
}
