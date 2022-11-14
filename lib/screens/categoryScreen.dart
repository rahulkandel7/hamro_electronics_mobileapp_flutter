import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categoryViewScreen.dart';
import '/controllers/categoryController.dart';

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
                return ref.watch(fetchCategory).when(
                      data: (data) {
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: size.height * 0.74,
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
                                        child: Image.network(
                                          'https://api.hamroelectronics.com.np/public/${data[i].photopath}',
                                          width: size.width * 0.3,
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
                        child: CircularProgressIndicator(),
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
