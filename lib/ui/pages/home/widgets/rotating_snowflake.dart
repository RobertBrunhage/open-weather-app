import 'package:flutter/material.dart';

class RotatingSnowflake extends StatefulWidget {
  const RotatingSnowflake({
    Key key,
  }) : super(key: key);

  @override
  _RotatingSnowflakeState createState() => _RotatingSnowflakeState();
}

class _RotatingSnowflakeState extends State<RotatingSnowflake> with SingleTickerProviderStateMixin {
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
        Icons.ac_unit,
        size: 112,
        color: Colors.lightBlue,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
