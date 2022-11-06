import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/controllers/categoryController.dart';
import 'package:hamro_electronics/models/category.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Row with logo,notification and profile button
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: mediaQuery.height * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.indigo.shade300,
                      child: const Text(
                        'A',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      width: mediaQuery.width * 0.25,
                    ),
                    IconButton(
                      onPressed: () {
                        print('Goes to Notification Page');
                      },
                      enableFeedback: true,
                      splashColor: Colors.indigo.shade100,
                      iconSize: Theme.of(context).textTheme.headline5!.fontSize,
                      icon: Icon(
                        Icons.notifications_none_sharp,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    )
                  ],
                ),
              ),
              //* Search Box Code
              Center(
                child: SizedBox(
                  width: mediaQuery.width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.all(0),
                      focusedBorder: Theme.of(context)
                          .inputDecorationTheme
                          .focusedBorder!
                          .copyWith(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            ),
                          ),
                      border: Theme.of(context)
                          .inputDecorationTheme
                          .focusedBorder!
                          .copyWith(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            ),
                          ),
                      enabledBorder: Theme.of(context)
                          .inputDecorationTheme
                          .focusedBorder!
                          .copyWith(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            ),
                          ),
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        color: Colors.grey.shade500,
                      ),
                      labelText: 'Search Products...',
                      labelStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.02,
              ),
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headline5,
              ),

              ref.watch(fetchCategory).when(
                    data: (data) {
                      data.sort(
                        (a, b) => a.priority.compareTo(b.priority),
                      );
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: mediaQuery.height * 0.01),
                        child: SizedBox(
                          width: double.infinity,
                          height: mediaQuery.height * 0.12,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
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
                                        'https://www.api.hamroelectronics.com.np/public/${data[i].photopath}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    data[i].categoryName,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )
                                ],
                              );
                            },
                            itemCount: data.length,
                          ),
                        ),
                      );
                    },
                    error: (e, s) {
                      print(s);
                      return Text(e.toString());
                    },
                    loading: () => CircularProgressIndicator(),
                  ),

              Text(
                'Promotions',
                style: Theme.of(context).textTheme.headline5,
              ),

              Container(
                width: double.infinity,
                height: mediaQuery.height * 0.2,
                margin: const EdgeInsets.all(
                  8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
