import 'package:flutter/material.dart';

class BouncyTap extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onTap;

  const BouncyTap({super.key, required this.child, this.onTap});

  @override
  State<BouncyTap> createState() => BouncyTapState();
}

class BouncyTapState extends State<BouncyTap>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  bool _isHandlingTap = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
    );
    _scale = Tween<double>(
      begin: 1,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (widget.onTap == null || _isHandlingTap) return;

    _isHandlingTap = true;
    try {
      await _controller.forward();
      await _controller.reverse();
      await widget.onTap!.call();
    } finally {
      _isHandlingTap = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTap,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
