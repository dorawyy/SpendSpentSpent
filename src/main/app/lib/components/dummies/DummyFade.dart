import 'package:flutter/cupertino.dart';

class DummyFade extends StatefulWidget {
  Widget child;
  bool? running = true;

  DummyFade({required this.child, this.running});

  @override
  DummyFadeState createState() => DummyFadeState();
}

class DummyFadeState extends State<DummyFade> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this, value: 1, lowerBound: 0.4, upperBound: 1, reverseDuration: const Duration(microseconds: 2000));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (widget.running ?? true) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant DummyFade oldWidget) {
    if (oldWidget.running != widget.running) {
      if (widget.running ?? true) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop(canceled: false);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}
