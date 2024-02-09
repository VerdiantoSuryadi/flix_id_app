import '../../../data/repositories/movie_repository.dart';
import '../../entities/movie.dart';
import '../../entities/result.dart';
import '../usecase.dart';
import 'get_movie_list_params.dart';

class GetMovieList implements UseCase<Result<List<Movie>>, GetMovieListParams> {
  final MovieRepository _movieRepository;

  GetMovieList({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Movie>>> call(GetMovieListParams params) async {
    var movieResult = switch (params.categories) {
      MovieListCategories.nowPlaying =>
        await _movieRepository.getNowPlaying(page: params.page),
      MovieListCategories.upComing =>
        await _movieRepository.getUpComing(page: params.page),
    };

    return switch (movieResult) {
      Success(value: final movies) => Result.success(movies),
      Failed(:final message) => Result.failed(message)
    };
  }
}
