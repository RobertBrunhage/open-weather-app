import 'package:flutter/material.dart';

class RotatingSun extends StatefulWidget {
  const RotatingSun({
    Key key,
  }) : super(key: key);

  @override
  _RotatingSunState createState() => _RotatingSunState();
}

class _RotatingSunState extends State<RotatingSun> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 10),
    );

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationController,
      child: Icon(
        Icons.wb_sunny,
        size: 112,
        color: Colors.yellow,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
