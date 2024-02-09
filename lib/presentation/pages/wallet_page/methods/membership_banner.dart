import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget membershipBanner(WidgetRef ref) => Align(
      alignment: Alignment.centerRight,
      child: Transform.rotate(
        angle: pi / 2,
        origin: const Offset(17.5, 17.5),
        child: Container(
          width: 100,
          height: 30,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              gradient: LinearGradient(
                  colors: [Color(0xFF966120), Color(0xFFBD8939)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
          child: const Center(
            child: Text(
              'PRIORITY',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
