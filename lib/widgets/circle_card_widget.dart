import 'dart:ui';

import 'package:flutter/material.dart';

import '../app/app_defaults.dart';
import 'custom_circular_progress_indicator.dart';

class CircleCardWidget extends StatelessWidget {
  final Widget? child;
  final bool showCard;

  const CircleCardWidget({
    super.key,
    required this.child,
    this.showCard = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        child!,
        Stack(
          children: [
            if (showCard) const Positioned.fill(child: IgnorePointer()),
            if (showCard)
              TweenAnimationBuilder<num>(
                tween: Tween(begin: 0.0, end: 0.2),
                duration: const Duration(milliseconds: 200),
                builder: (_, value, __) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      color: theme.shadowColor.withValues(
                        alpha: value as double,
                      ),
                    ),
                  );
                },
              ),
            AnimatedPositioned(
              left: 40,
              right: 40,
              top: showCard ? 80 : -420,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              child: RepaintBoundary(
                child: Card(
                  shape: const CircleBorder(),
                  elevation: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppDefaults.kStandartContentPadding,
                    ),
                    child: _CardContents(showCard),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CardContents extends StatefulWidget {
  final bool isDone;

  const _CardContents(this.isDone);

  @override
  _CardContentsState createState() => _CardContentsState();
}

class _CardContentsState extends State<_CardContents>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _CardContents oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isDone && widget.isDone) {
      _controller.forward(from: 0);
    } else if (oldWidget.isDone && !widget.isDone) {
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        curve: const Interval(0.2, 0.6, curve: Curves.elasticOut),
        parent: _controller,
      ),
      child: const CustomCircularProgressIndicator(),
    );
  }
}
