import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testing_flutter_apps/models/favorites.dart';
import 'package:testing_flutter_apps/screens/favorites.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Testing sample"), actions: <Widget>[
        TextButton.icon(
            onPressed: () {
              context.go('/${FavoritesPage.routeName}');
            },
            icon: const Icon(Icons.favorite_border),
            label: Text('Favorites'))
      ]),
      body: ListView.builder(
          itemCount: 100,
          cacheExtent: 100,
          padding: EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => ItemTile(itemNo: index,)),
    );
  }
}

class ItemTile extends StatelessWidget {

  final int itemNo;

  const ItemTile({super.key, required this.itemNo});


  @override
  Widget build(BuildContext context) {

    var favoritesList = Provider.of<Favorites>(context);

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            leading: CircleAvatar(
                backgroundColor:
                    Colors.primaries[itemNo % Colors.primaries.length]),
            title: Text(
              'Item $itemNo',
              key: Key('text_$itemNo'),
            ),
            trailing: IconButton(
              key: Key('icon_$itemNo'),
            icon: favoritesList.items.contains(itemNo) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
              onPressed: () {
                !favoritesList.items.contains(itemNo)
                   ? favoritesList.items.add(itemNo)
                    : favoritesList.items.remove(itemNo);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(favoritesList.items.contains(itemNo) ? 'Added to Favorites' : 'Removed from favorites'),
                    duration: Duration(seconds: 1),));
              },
            )));
  }
}
