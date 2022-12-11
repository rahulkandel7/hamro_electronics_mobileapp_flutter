import 'package:flutter/material.dart';

class HomeProductShimmer extends StatelessWidget {
  const HomeProductShimmer({super.key});

  shimmer(Size mediaQuery) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: mediaQuery.width * 0.3,
              height: mediaQuery.height * 0.02,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.08,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
            Container(
              width: mediaQuery.width * 0.16,
              height: mediaQuery.height * 0.02,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.08,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: mediaQuery.height * 0.23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                      top: 10,
                    ),
                    height: mediaQuery.height * 0.13,
                    width: mediaQuery.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(
                        0.08,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                      top: 10,
                    ),
                    height: mediaQuery.height * 0.013,
                    width: mediaQuery.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(
                        0.08,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                      top: 10,
                    ),
                    height: mediaQuery.height * 0.013,
                    width: mediaQuery.width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(
                        0.08,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                ],
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        shimmer(mediaQuery),
        shimmer(mediaQuery),
        shimmer(mediaQuery),
        shimmer(mediaQuery),
      ],
    );
  }
}
