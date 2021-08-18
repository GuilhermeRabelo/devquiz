import 'package:DevQuiz/core/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatefulWidget {
  final double value;
  final double init;
  const ProgressIndicatorWidget(
      {Key? key, required this.value, required this.init})
      : super(key: key);

  @override
  _ProgressIndicatorWidgetState createState() =>
      _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void _initAnimation() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween<double>(begin: widget.init / 100, end: widget.value)
        .animate(_controller);
    _controller.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => Stack(
        children: [
          LinearProgressIndicator(
            value: _animation.value,
            backgroundColor: AppColors.chartSecondary,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
          ),
        ],
      ),
    ));
  }
}
