import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(right: 10),
        color: Theme.of(context).errorColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Remover Item',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryTextTheme.headline6?.color),
            ),
            Icon(
              Icons.delete,
              color: Theme.of(context).primaryTextTheme.headline6?.color,
            )
          ],
        ),
      ),
      child: Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: FittedBox(
                child: Text(' ${cartItem.price}'),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
          trailing: Text(' ${cartItem.quantity}x'),
        ),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: true).removeItem(cartItem.productId);
      },
      confirmDismiss: (direction) {
        return showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Tem certeza"),
            content: Text("Deseja de fato excluir o item?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Sim"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Não"),
              ),
            ],
          ),
        );
      },
    );
  }
}
