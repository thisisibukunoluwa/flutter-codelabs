import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import "package:provider/provider.dart";
import 'package:testing_flutter_apps/models/favorites.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  static String routeName = 'favorites_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: Consumer<Favorites> (
        builder: (context, value, child) => ListView.builder(
          itemCount: value.items.length,
          padding: EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => FavoriteItemTile(itemNo: value.items[index])
        )
      ),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  const FavoriteItemTile({required this.itemNo, super.key});

  final int itemNo;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  Colors.primaries[itemNo % Colors.primaries.length],
            ),
            title: Text(
              "Item ${itemNo}",
              key: Key('favorites_text_$itemNo'),
            ),
            trailing: IconButton(
                onPressed: () {
                  Provider.of<Favorites>(context, listen: false).remove(itemNo);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Removed from favorites'),
                    duration: Duration(seconds: 1),
                  ));
                },
                icon: const Icon(Icons.close)
            )));
  }
}
