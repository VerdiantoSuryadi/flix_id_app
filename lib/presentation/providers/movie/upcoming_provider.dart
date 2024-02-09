import '../../../domain/entities/result.dart';
import '../../../domain/usecases/get_movie_list/get_movie_list_params.dart';
import '../usecases/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_movie_list/get_movie_list.dart';

part 'upcoming_provider.g.dart';

@Riverpod(keepAlive: true)
class UpComing extends _$UpComing {
  @override
  FutureOr<List<Movie>> build() => [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();

    GetMovieList getMovieList = ref.read(getMovieListProvider);

    var result = await getMovieList(GetMovieListParams(
        categories: MovieListCategories.upComing, page: page));

    switch (result) {
      case Success(value: final movies):
        state = AsyncData(movies);
      case Failed(message: _):
        state = const AsyncData([]);
    }
  }
}
