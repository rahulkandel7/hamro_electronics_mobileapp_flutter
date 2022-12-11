import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_electronics/features/viewOrder/data/models/orderView.dart';
import 'package:hamro_electronics/features/viewOrder/data/repositories/order_view_repository.dart';

class OrderViewController extends StateNotifier<AsyncValue<List<OrderView>>> {
  OrderViewController(this._orderViewRepository) : super(const AsyncLoading()) {
    fetchOrders();
  }

  final OrderViewRepository _orderViewRepository;

  fetchOrders() async {
    final result = await _orderViewRepository.getOrders();
    result.fold(
        (error) => state =
            AsyncError(error.message, StackTrace.fromString(error.toString())),
        (success) => state = AsyncData(success));
  }
}

final orderViewControllerProvider =
    StateNotifierProvider<OrderViewController, AsyncValue<List<OrderView>>>(
        (ref) {
  return OrderViewController(ref.watch(orderViewRepositoryProvider));
});
