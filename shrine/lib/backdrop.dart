import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shrine/model/product.dart';

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop(
      {required this.currentCategory,
      required this.frontLayer,
      required this.backLayer,
      required this.frontTitle,
      required this.backTitle,
      super.key});

  @override
  State<Backdrop> createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  late AnimationController _controller;


  

  _buildStack() {
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        widget.backLayer,
        _FrontLayer(child: widget.frontLayer)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      leading: Icon(Icons.menu),
      title: Text("SHRINE"),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.tune,
            semanticLabel: 'filter',
          ),
        ),
      ],
    );
    return Scaffold(appBar: appBar, body: _buildStack());
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // GestureDetector(
            //   child:
            Expanded(child: child),
            // )
          ]),
    );
  }
}
