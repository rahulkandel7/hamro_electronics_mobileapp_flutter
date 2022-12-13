import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/notification/presentation/controllers/notificationController.dart';

class NotificationScreen extends ConsumerWidget {
  static const routeName = '/notifications';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: ref.watch(notificationControllerProvider).when(
            data: (data) {
              return ListView.builder(
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(4, 4),
                            color: Theme.of(context).shadowColor,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaQuery.width * 0.02,
                                vertical: mediaQuery.height * 0.01),
                            child: SizedBox(
                              width: mediaQuery.width * 0.9,
                              child: Text(
                                data[i].title,
                                maxLines: 3,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: mediaQuery.width * 0.02,
                                bottom: mediaQuery.height * 0.01),
                            child: SizedBox(
                              width: mediaQuery.width * 0.9,
                              child: Text(
                                data[i].description,
                                maxLines: 4,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: mediaQuery.width * 0.02,
                                bottom: mediaQuery.height * 0.01),
                            child: SizedBox(
                              width: mediaQuery.width * 0.9,
                              child: Text(
                                data[i].date,
                                textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () {
              return SizedBox(
                height: mediaQuery.height * 9,
                child: ListView.builder(
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: mediaQuery.width * 0.3,
                            height: mediaQuery.height * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: mediaQuery.width * 0.6,
                                height: mediaQuery.height * 0.03,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10, top: 5),
                                width: mediaQuery.width * 0.4,
                                height: mediaQuery.height * 0.03,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: 8,
                ),
              );
            },
          ),
    );
  }
}
