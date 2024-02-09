import 'package:flutter/material.dart';

import '../../../misc/constant.dart';

Widget searchBar(BuildContext context, String hintText, VoidCallback? onTap) {
  return Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width - 24 - 24 - 90,
        height: 50,
        margin: const EdgeInsets.only(left: 24, right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: containerTextField,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          style: const TextStyle(color: grey400),
          decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              icon: const Icon(Icons.search)),
          onTap: onTap,
          readOnly: true,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
      ),
      SizedBox(
        width: 80,
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10)))),
          child: const Icon(Icons.search),
        ),
      )
    ],
  );
}
