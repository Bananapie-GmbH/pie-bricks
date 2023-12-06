import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({
    Key? key,
    this.child,
    this.splashScreen,
  }) : super(key: key);

  final Widget? child;
  final Widget? splashScreen;

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  final visibility = ValueNotifier<bool>(true);
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )
    ..forward()
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        visibility.value = false;
      }
    });

  late final Animation<double> _animation =
      Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child!,
        ValueListenableBuilder(
          valueListenable: visibility,
          builder: (context, bool value, child) {
            return Visibility(
              visible: value,
              child: FadeTransition(
                opacity: _animation,
                child: widget.splashScreen,
              ),
            );
          },
        ),
      ],
    );
  }
}
