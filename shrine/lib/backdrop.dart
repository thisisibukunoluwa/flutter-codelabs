import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shrine/login.dart';
import 'package:shrine/model/product.dart';
import 'login.dart';

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

  double _kFlingVelocity = 2.0;

  @override
  initState() {
    _controller = AnimationController(
        vsync: this, value: 1.0, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Backdrop oldWidget) {
    if (widget.currentCategory != oldWidget.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
    super.didUpdateWidget(oldWidget);
  }

  bool get _frontLayerVisible {
    AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const layerTitleHeight = 48.0;
    Size layerSize = constraints.biggest;

    double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, layerTop, 0.0, layerTop - layerSize.height),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
            rect: layerAnimation,
            child: _FrontLayer(
              child: widget.frontLayer,
              onTap: _toggleBackdropLayerVisibility,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      // leading: IconButton(
      //   icon: const Icon(Icons.menu),
      //   onPressed: _toggleBackdropLayerVisibility,
      // ),
      title: _BackdropTitle(
        listenable: _controller.view,
        backTitle: widget.backTitle,
        frontTitle: widget.frontTitle,
        onPress: _toggleBackdropLayerVisibility,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          },
          icon: Icon(
            Icons.login,
            semanticLabel: 'login',
          ),
        ),
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
    return Scaffold(appBar: appBar, body: LayoutBuilder(builder: _buildStack));
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({super.key, this.onTap, required this.child});

  final VoidCallback? onTap;
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
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Container(
                  height: 40.0,
                  alignment: AlignmentDirectional.centerStart,
                )),
            Expanded(child: child),
          ]),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final void Function() onPress;
  final Widget frontTitle;
  final Widget backTitle;

  _BackdropTitle({
    Key? key,
    required Animation<double> listenable,
    required this.onPress,
    required this.frontTitle,
    required this.backTitle,
  })  : _listenable = listenable,
        super(key: key, listenable: listenable);

  final Animation<double> _listenable;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = _listenable;

    return DefaultTextStyle(
        style: Theme.of(context).textTheme.titleLarge!,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Row(
          children: <Widget>[
            SizedBox(
                width: 72.0,
                child: IconButton(
                  padding: const EdgeInsets.only(right: 8.0),
                  onPressed: onPress,
                  icon: Stack(children: <Widget>[
                    Opacity(
                        opacity: animation.value,
                        child: const ImageIcon(
                            AssetImage('assets/slanted_menu.png'))),
                    FractionalTranslation(
                      translation: Tween<Offset>(
                              begin: Offset.zero, end: const Offset(1.0, 0.0))
                          .evaluate(animation),
                      child: const ImageIcon(AssetImage('assets/diamond.png')),
                    )
                  ]),
                )),
            Stack(
              children: <Widget>[
                Opacity(
                  opacity: CurvedAnimation(
                          parent: ReverseAnimation(animation),
                          curve: const Interval(0.5, 1.0))
                      .value,
                  child: FractionalTranslation(
                    translation: Tween<Offset>(
                            begin: Offset.zero, end: const Offset(0.5, 0.0))
                        .evaluate(animation),
                    child: backTitle,
                  ),
                ),
                Opacity(
                  opacity: CurvedAnimation(
                          parent: animation, curve: Interval(0.5, 1.0))
                      .value,
                  child: FractionalTranslation(
                    translation: Tween<Offset>(
                            begin: Offset(-0.25, 0.0), end: Offset.zero)
                        .evaluate(animation),
                    child: frontTitle,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
