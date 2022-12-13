import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:project_4/provided-models/orders.dart' as order_item_model;
import 'package:project_4/provided-models/product.dart';

class OrderItem extends StatefulWidget {
  final order_item_model.OrderItem orderItem;
  const OrderItem({
    super.key,
    required this.orderItem
  });
  @override
  createState() => OrderItemState();
}

class OrderItemState extends State<OrderItem> with SingleTickerProviderStateMixin {
  static final dateFormatter = DateFormat('dd/MM/yyyy hh:mm');
  bool expanded = false;

  late AnimationController _controller;
  late Animation <double> _expandableContainerHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _expandableContainerHeight = Tween<double>(begin: 0, end: 50)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(dateFormatter.format(widget.orderItem.time)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                  if(expanded) {
                    _controller.forward();
                  }
                  else {
                    _controller.reverse();
                  }
                });
              },
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          AnimatedBuilder(
            animation: _expandableContainerHeight,
            builder: (context, child) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              constraints: const BoxConstraints(maxHeight: 180),
              height: _expandableContainerHeight.value,
              child: child
            ),
            child: ListView.builder(
              itemCount: widget.orderItem.products.length,
              itemBuilder: (context, index) {
                final product = widget.orderItem.products[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '${product.quantity}x \$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                      ),
                    )
                  ],
                );
              }
            ),
          )
        ],
      ),
    );
  }
}