import 'package:dio/dio.dart';

import '../../domain/entities/actor.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/entities/result.dart';
import '../repositories/movie_repository.dart';

class TmdbMovieRepository implements MovieRepository {
  final Dio? _dio;
  final String _accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMTg2YWFhN2FhNzQzOWFlZTg5YmNhM2U5MjBjZTVhZCIsInN1YiI6IjY1OTI4OWNkNmFhOGUwNjIxY2ViNTdlNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.oeEk6Qg-YbpKhCDwAh_RXl5R8To16_jASlMosuCk-nA';

  late final Options _options = Options(headers: {
    'Authorization': 'Bearer $_accessToken',
    'accept': 'application/json'
  });

  TmdbMovieRepository({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Result<List<Actor>>> getActors({required int id}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$id/credits?language=en-US',
          options: _options);

      final result = List<Map<String, dynamic>>.from(response.data['cast']);

      return Result.success(result.map((e) => Actor.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$id?language=en-US',
          options: _options);
      return Result.success(MovieDetail.fromJSON(response.data));
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async =>
      _getMovies(_MovieCategory.nowPlaying.toString(), page: page);

  @override
  Future<Result<List<Movie>>> getUpComing({int page = 1}) async =>
      _getMovies(_MovieCategory.upComing.toString(), page: page);

  Future<Result<List<Movie>>> _getMovies(String category,
      {int page = 1}) async {
    try {
      final response = await _dio!.get(
          'https://api.themoviedb.org/3/movie/$category?language=en-US&page=$page',
          options: _options);
      final results = List<Map<String, dynamic>>.from(response.data['results']);

      return Result.success(results.map((e) => Movie.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upComing('upcoming');

  final String _instring;
  const _MovieCategory(String inString) : _instring = inString;

  @override
  String toString() => _instring;
}
