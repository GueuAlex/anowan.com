import 'package:flutter/material.dart';

class CustomeAnimatedSlide extends StatefulWidget {
  final Widget child;

  const CustomeAnimatedSlide({required this.child});

  @override
  _CustomeAnimatedSlideState createState() => _CustomeAnimatedSlideState();
}

class _CustomeAnimatedSlideState extends State<CustomeAnimatedSlide> {
  double _slideValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeInOut,
      ),
      builder: (context, child) {
        _slideValue = 1.0 - ModalRoute.of(context)!.animation!.value;
        return Transform.translate(
          offset: Offset(0.0, _slideValue * MediaQuery.of(context).size.height),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
