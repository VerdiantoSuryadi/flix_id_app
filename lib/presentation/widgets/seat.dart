import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../misc/constant.dart';

enum SeatStatus { available, reserved, selected }

class Seat extends ConsumerWidget {
  final int? number;
  final SeatStatus status;
  final double size;
  final VoidCallback? onTap;
  const Seat(
      {super.key,
      this.number,
      this.status = SeatStatus.available,
      this.size = 30,
      this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: status == SeatStatus.available
                ? ghostWhite
                : status == SeatStatus.reserved
                    ? grey
                    : saffron,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            number?.toString() ?? '',
            style: const TextStyle(
                color: backgroundColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
