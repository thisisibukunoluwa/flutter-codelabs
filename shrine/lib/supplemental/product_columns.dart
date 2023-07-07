import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shrine/model/product.dart';
import 'package:shrine/supplemental/product_card.dart';

class TwoProductCardColumn extends StatelessWidget {
  const TwoProductCardColumn({super.key, required this.bottom, this.top});

  final Product bottom;
  final Product? top;

  @override
  Widget build(BuildContext context) {
    const spacerHeight = 44.0;

    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      double heightOfCards = (constraints.biggest.height - spacerHeight) / 2.0;
      double heightOfImages = heightOfCards - ProductCard.kTextBoxHeight;
      double imageAspectRatio = heightOfImages >= 0.0
      ? constraints.biggest.width / heightOfImages : 49.0 / 33.0;

      return ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Padding(
              padding: EdgeInsetsDirectional.only(start: 28.0),
              child: top != null
                  ? ProductCard(
                      imageAspectRatio: imageAspectRatio,
                      product: top!,
                    )
                  : SizedBox(
                      height: heightOfCards,
                    )),
          SizedBox(
            height: spacerHeight,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(end: 28.0),
            child: ProductCard(
              imageAspectRatio: imageAspectRatio,
              product: bottom,
            ),
          ),
        ],
      );
    });
  }
}

class OneProductCardColumn extends StatelessWidget {
  const OneProductCardColumn({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),
      reverse: true,
      children: <Widget>[
        ConstrainedBox(
          constraints:BoxConstraints(maxWidth: 550),
          child: ProductCard(product: product),
        ),
        const SizedBox(height: 40.0,)
      ]
    );
  }
}
