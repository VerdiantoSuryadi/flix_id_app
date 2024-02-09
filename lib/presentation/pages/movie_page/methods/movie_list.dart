import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/entities/movie.dart';
import '../../../widgets/network_image_card.dart';

List<Widget> movieList({
  required String title,
  void Function(Movie movie)? onTap,
  required AsyncValue<List<Movie>> movies,
}) {
  return [
    Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 15),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    Container(
      width: double.infinity,
      height: 228,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: movies.when(
        data: (data) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: data
                  .map((movie) => Padding(
                        padding:
                            EdgeInsets.only(right: movie == data.last ? 0 : 10),
                        child: NetworkImageCard(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                          fit: BoxFit.cover,
                          onTap: () => onTap?.call(movie),
                        ),
                      ))
                  .toList()),
        ),
        error: (error, stackTrace) => const SizedBox(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    )
  ];
}
