import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeCategory extends StatelessWidget {
  final String name;
  final String photopath;

  const HomeCategory({required this.name, required this.photopath, super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: mediaQuery.height * 0.07,
          margin: EdgeInsets.all(
            mediaQuery.width * 0.02,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              100,
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'https://www.api.hamroelectronics.com.np/public/${photopath}',
              placeholder: (context, url) =>
                  Image.asset('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
