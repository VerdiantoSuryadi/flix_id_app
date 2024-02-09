import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';

@freezed
class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    required int id,
    required String title,
    required String overView,
    required int runTime,
    required double voteAverage,
    String? posterPath,
    String? backdropPath,
    required List<String> genres,
  }) = _MovieDetail;
  factory MovieDetail.fromJSON(Map<String, dynamic> json) => MovieDetail(
      id: json['id'],
      title: json['title'],
      overView: json['overview'],
      runTime: json['runtime'],
      voteAverage: json['vote_average'].toDouble(),
      genres: List<String>.from(json['genres'].map((e) => e['name'])),
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path']);
}
