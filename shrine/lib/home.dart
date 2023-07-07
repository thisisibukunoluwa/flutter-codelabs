import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/supplemental/asymmetric_view.dart';

import 'model/product_repository.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.category = Category.all});

  final Category category;
  
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    if (products.isEmpty) {
      return const <Card>[];
    }
    ThemeData theme = Theme.of(context);
    NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((Product product) {
      return Card(
        elevation: 0.0,
        clipBehavior: Clip.antiAlias,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18 / 11,
                child: Image.asset(
                  product.assetName,
                  package: product.assetPackage,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: theme.textTheme.labelLarge,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(formatter.format(product.price),
                        style: theme.textTheme.bodySmall)
                  ],
                ),
              ))
            ]),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AsymmetricView(products: ProductsRepository.loadProducts(category));
    // Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //         icon: const Icon(
    //           Icons.menu,
    //           semanticLabel: 'menu',
    //         ),
    //         onPressed: () {
    //           print('menu button');
    //         }),
    //     title: const Text('SHRINE'),
    //     actions: <Widget>[
    //       IconButton(
    //           onPressed: () {
    //             print('Search Button');
    //           },
    //           icon: const Icon(
    //             Icons.search,
    //             semanticLabel: 'search',
    //           )),
    //       IconButton(
    //           onPressed: () {
    //             print('Filter Button');
    //           },
    //           icon: const Icon(
    //             Icons.tune,
    //             semanticLabel: 'filter',
    //           ))
    //     ],
    //   ),
    // body: GridView.count(
    //   crossAxisCount: 2,
    //   padding: const EdgeInsets.all(16.0),
    //   childAspectRatio: 8.0 / 9.0,
    //   children: _buildGridCards(context),
    // ),
    // body: AsymmetricView(products: ProductsRepository.loadProducts(Category.all)),
    // resizeToAvoidBottomInset: false,
  }
}
