import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hamro_electronics/controllers/statusController.dart';
import 'package:hamro_electronics/models/status.dart';

import 'package:hamro_electronics/screens/widgets/ordersItem.dart';

class OrdersScreen extends ConsumerWidget {
  static const routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Orders',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Active Order',
              ),
              Tab(
                text: 'Completed Order',
              ),
              Tab(
                text: 'Cancelled Order',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ref.watch(fetchStatus).when(
                  data: (data) {
                    List<Status> orders = data
                        .where((element) =>
                            element.status == 'pending' ||
                            element.status == 'processing')
                        .toList();
                    return orders.isEmpty
                        ? Center(
                            child: Text(
                            'No Ordered items yet',
                            style: Theme.of(context).textTheme.subtitle1,
                          ))
                        : ListView.builder(
                            itemBuilder: (ctx, i) => OrdersItem(
                              id: orders[i].productId,
                              photopath: orders[i].productPhoto,
                              color: orders[i].color,
                              name: orders[i].productName,
                              quantity: orders[i].quantity,
                              size: orders[i].size,
                              reason: '',
                            ),
                            itemCount: orders.length,
                          );
                  },
                  error: (e, s) => Text(
                    e.toString(),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 0.8,
                    ),
                  ),
                ),
            ref.watch(fetchStatus).when(
                  data: (data) {
                    List<Status> orders = data
                        .where((element) => element.status == 'completed')
                        .toList();
                    return orders.isEmpty
                        ? Center(
                            child: Text(
                            'No Ordered items yet',
                            style: Theme.of(context).textTheme.subtitle1,
                          ))
                        : ListView.builder(
                            itemBuilder: (ctx, i) => OrdersItem(
                              id: orders[i].productId,
                              photopath: orders[i].productPhoto,
                              color: orders[i].color,
                              name: orders[i].productName,
                              quantity: orders[i].quantity,
                              size: orders[i].size,
                              reason: '',
                            ),
                            itemCount: orders.length,
                          );
                  },
                  error: (e, s) => Text(
                    e.toString(),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 0.8,
                    ),
                  ),
                ),
            ref.watch(fetchStatus).when(
                  data: (data) {
                    List<Status> orders = data
                        .where((element) => element.status == 'cancelled')
                        .toList();
                    return orders.isEmpty
                        ? Center(
                            child: Text(
                            'No Ordered items yet',
                            style: Theme.of(context).textTheme.subtitle1,
                          ))
                        : ListView.builder(
                            itemBuilder: (ctx, i) => OrdersItem(
                              id: orders[i].productId,
                              photopath: orders[i].productPhoto,
                              color: orders[i].color,
                              name: orders[i].productName,
                              quantity: orders[i].quantity,
                              size: orders[i].size,
                              reason: orders[i].reason,
                            ),
                            itemCount: orders.length,
                          );
                  },
                  error: (e, s) => Text(
                    e.toString(),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 0.8,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
