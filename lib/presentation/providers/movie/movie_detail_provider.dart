import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/usecases/get_movie_detail/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_detail/get_movie_detail_params.dart';
import '../usecases/get_movie_detail_provider.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail?> movieDetail(MovieDetailRef ref,
    {required Movie movie}) async {
  GetMovieDetail getMovieDetail = ref.read(getMovieDetailProvider);

  var movieDetailResult =
      await getMovieDetail(GetMovieDetailParams(movie: movie));

  return switch (movieDetailResult) {
    Success(value: final movieDetail) => movieDetail,
    Failed(message: _) => null
  };
}
