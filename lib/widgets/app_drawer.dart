import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_4/provided-models/auth.dart';
import 'package:project_4/screens/orders.dart';
import 'package:project_4/screens/user_products.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Shopping remastered!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Orders'),
            onTap: () => Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () => Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => authModel.logout(),
          )
        ],
      ),
    );
  }
}