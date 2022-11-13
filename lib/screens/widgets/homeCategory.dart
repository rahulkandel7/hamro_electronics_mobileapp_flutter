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
            child: Image.network(
              'https://www.api.hamroelectronics.com.np/public/${photopath}',
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
