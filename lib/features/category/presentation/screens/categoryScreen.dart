import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/category/presentation/controllers/categoryController.dart';

import 'categoryViewScreen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: Center(
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(categoryControllerProvider).when(
                      data: (data) {
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: size.height * 0.735,
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemBuilder: (ctx, i) {
                                return InkWell(
                                  onTap: () => Navigator.of(context).pushNamed(
                                    CategoryViewScreen.routeName,
                                    arguments: data[i].id,
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://api.hamroelectronics.com.np/public/${data[i].photopath}',
                                          width: size.width * 0.3,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/images/logo.png',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01,
                                        ),
                                        child: Text(
                                          data[i].categoryName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                            ),
                          ),
                        );
                      },
                      error: (e, s) => Text(e.toString()),
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 0.4,
                        ),
                      ),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}
