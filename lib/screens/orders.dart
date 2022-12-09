import 'package:flutter/material.dart';
import 'package:project_4/provided-models/orders.dart' show OrdersModel;
import 'package:project_4/widgets/app_drawer.dart';
import 'package:project_4/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrdersModel>(context);
    final orders = ordersModel.orders;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: ordersModel.isLoading ? 
        const Center(
          child: CircularProgressIndicator(),
        ) :
        ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) => OrderItem(orderItem: orders[index]),
        ),
    );
  }
}