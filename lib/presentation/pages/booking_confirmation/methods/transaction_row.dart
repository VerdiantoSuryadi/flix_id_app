import 'package:flutter/material.dart';

import '../../../misc/constant.dart';
import '../../../misc/methods.dart';

Widget transactionRow({
  required String title,
  required String value,
  required double width,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(color: grey),
            ),
          ),
          horizontalSpace(20),
          SizedBox(
            width: width - 110 - 20,
            child: Text(value),
          )
        ],
      ),
    );
