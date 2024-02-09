import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie_detail.dart';
import '../../../misc/methods.dart';

List<Widget> movieOverview({
  required AsyncValue<MovieDetail?> asyncMovieDetail,
}) =>
    [
      const Text(
        'Overview',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(10),
      asyncMovieDetail.when(
          data: (movieDetail) {
            String overView = movieDetail?.overView ?? '';
            return Text(
              overView,
            );
          },
          error: (error, stackTrace) => const Text(
                'Failed to load movie\'s overview. Please try again later.',
              ),
          loading: () => const CircularProgressIndicator()),
    ];
