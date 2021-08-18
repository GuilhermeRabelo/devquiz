import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  final double percentage;
  const ChartWidget({Key? key, required this.percentage}) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<double> _animation;
  late Animation<double> _curve;

  void _initAnimation() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween<double>(begin: 0.0, end: widget.percentage);

    _curve = CurvedAnimation(
      parent: this._controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _initAnimation();
    super.initState();
  }

  @override
  void didUpdateWidget(ChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.percentage != oldWidget.percentage) {
      double beginValue = oldWidget.percentage;

      // Update the value tween.
      _animation = Tween<double>(
        begin: beginValue,
        end: widget.percentage,
      );

      this._controller
        ..value = 0
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Stack(
          children: [
            Center(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.chartPrimary.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(45),
                ),
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  backgroundColor: AppColors.chartSecondary,
                  value: _animation.evaluate(_curve),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
                ),
              ),
            ),
            Center(
              child: Text("${(_animation.evaluate(_curve) * 100).toInt()}%",
                  style: AppTextStyles.heading),
            )
          ],
        ),
      ),
    );
  }
}
