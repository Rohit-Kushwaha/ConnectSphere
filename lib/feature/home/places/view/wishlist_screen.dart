import 'package:flutter/material.dart';
import 'package:career_sphere/data/local/hive/model/wishlist_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WishlistScreen extends StatelessWidget {
  final Box<WishlistModel> cartBox;

  const WishlistScreen({super.key, required this.cartBox});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: ValueListenableBuilder(
        valueListenable: cartBox.listenable(),
        builder: (context, Box<WishlistModel> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No items in the wishlist.'),
            );
          }

          // Retrieve all items from the box
          final items = box.values.toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                title: Text(item.title.toString()),
                subtitle: Text(item.id.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await box.deleteAt(index); // Delete the item
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
