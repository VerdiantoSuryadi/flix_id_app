import 'package:flutter/material.dart';

import '../misc/constant.dart';

class SelectableCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isEnable;
  const SelectableCard(
      {super.key,
      required this.text,
      this.onTap,
      this.isSelected = false,
      this.isEnable = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (isEnable) ? onTap : null,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: isSelected ? saffron.withOpacity(0.3) : null,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: isEnable ? saffron : grey)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: isEnable ? ghostWhite : grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
