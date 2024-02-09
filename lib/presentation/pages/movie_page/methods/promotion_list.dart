import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> promotionList(
        {required String title,
        required List<String> promotionImageFileNames}) =>
    [
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 15),
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      Container(
        width: double.infinity,
        height: 160,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: promotionImageFileNames
                  .map((e) => Container(
                        width: 240,
                        height: 160,
                        margin: EdgeInsets.only(
                            left:
                                (e == promotionImageFileNames.first) ? 0 : 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage('assets/$e'))),
                      ))
                  .toList(),
            )),
      )
    ];
