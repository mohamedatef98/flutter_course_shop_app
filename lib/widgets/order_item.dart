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

class OrderItemState extends State<OrderItem> {
  static final dateFormatter = DateFormat('dd/MM/yyyy hh:mm');
  bool expanded = false;

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
                });
              },
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if(expanded) Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            constraints: const BoxConstraints(maxHeight: 180),
            height: widget.orderItem.products.length * 25,
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