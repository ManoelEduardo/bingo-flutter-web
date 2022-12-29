import 'dart:math';

import 'package:flutter/material.dart';

class BallDrawn extends StatefulWidget {
  final String letter;
  final int number;
  final ValueNotifier<double> numberAnimation;
  const BallDrawn({
    Key? key,
    required this.letter,
    required this.number,
    required this.numberAnimation,
  }) : super(key: key);

  @override
  State<BallDrawn> createState() => _BallDrawnState();
}

class _BallDrawnState extends State<BallDrawn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * widget.numberAnimation.value * pi,
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.deepPurple, // border color
              shape: BoxShape.circle,
            ),
            child: ValueListenableBuilder<double>(
              valueListenable: widget.numberAnimation,
              builder: (context, value, _) {
                return value > 0 || widget.number == 0
                    ? const Center(
                        child: Icon(
                        Icons.star_border_outlined,
                        size: 80,
                        color: Colors.white,
                      ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.letter,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 45),
                          ),
                          Text(
                            '${widget.number}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 45),
                          )
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
