import 'package:flutter/material.dart';

import '../../../../domain/entities/movie.dart';
import '../../../misc/constant.dart';

List<Widget> backGround(Movie movie) => [
      Image.network(
        'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          backgroundColor.withOpacity(1),
          backgroundColor.withOpacity(0.3),
        ], begin: const Alignment(0, 0.3), end: Alignment.topCenter)),
      )
    ];
