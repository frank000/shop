import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions {
  Favorite,
  All;
}

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Loja')),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Somente favoritos'),
                value: FilterOptions.Favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (value) {
              if (value == FilterOptions.Favorite) {
                provider.showFavoriteOnly();
              } else {
                provider.showAll();
              }
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (context, cart, child) {
              return Badge(
                value: cart.itensCount.toString(),
                child: child!,
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductGrid(),
      ),
    );
  }
}
