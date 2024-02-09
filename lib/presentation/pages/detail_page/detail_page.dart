import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../misc/constant.dart';
import '../../misc/methods.dart';
import '../../providers/movie/movie_detail_provider.dart';
import '../../providers/router/router_provider.dart';
import '../../widgets/back_navigation_bar.dart';
import '../../widgets/network_image_card.dart';
import 'methods/background.dart';
import 'methods/cast_and_crew.dart';
import 'methods/movie_over_view.dart';
import 'methods/movie_short_info.dart';

class DetailPage extends ConsumerWidget {
  final Movie movie;
  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncMovieDetail = ref.watch(MovieDetailProvider(movie: movie));

    var backdropPath = asyncMovieDetail.value?.backdropPath;
    return Scaffold(
      body: Stack(
        children: [
          ...backGround(movie),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackNavigationBar(
                      title: movie.title,
                      onTap: () => ref.read(routerProvider).pop(),
                    ),
                    verticalSpace(24),
                    //backdrop image
                    NetworkImageCard(
                      width: MediaQuery.of(context).size.width - 48,
                      height: (MediaQuery.of(context).size.width - 48) * 0.6,
                      borderRadius: 15,
                      imageUrl: asyncMovieDetail.valueOrNull != null
                          ? 'https://image.tmdb.org/t/p/w500/${backdropPath ?? movie.posterPath}'
                          : null,
                      fit: BoxFit.cover,
                    ),

                    verticalSpace(24),
                    ...movieShortInfo(
                        asyncMovieDetail: asyncMovieDetail, context: context),
                    verticalSpace(20),
                    ...movieOverview(asyncMovieDetail: asyncMovieDetail),
                    verticalSpace(40),
                    ...castAndCrew(movie: movie, ref: ref),
                    verticalSpace(40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          MovieDetail? movieDetail =
                              asyncMovieDetail.valueOrNull;

                          if (movieDetail != null) {
                            ref
                                .read(routerProvider)
                                .pushNamed('time_booking', extra: movieDetail);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: backgroundColor,
                            backgroundColor: saffron,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text("Book this movie"),
                      ),
                    ),
                    verticalSpace(50)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
