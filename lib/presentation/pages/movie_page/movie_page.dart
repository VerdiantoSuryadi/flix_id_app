import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../misc/methods.dart';
import '../../providers/movie/now_playing_provider.dart';
import '../../providers/movie/upcoming_provider.dart';
import '../../providers/router/router_provider.dart';
import 'methods/movie_list.dart';
import 'methods/promotion_list.dart';
import 'methods/search_bar.dart';
import 'methods/user_info.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionImageFileNames = const [
    'popcorn.jpg',
    'buy1get1.jpg'
  ];

  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appLocalizations = AppLocalizations.of(context)!;
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInfo(ref, appLocalizations),
            verticalSpace(40),
            searchBar(context, appLocalizations.hintTextSearchMovie, () {
              FocusScope.of(context).requestFocus();
              ref.read(routerProvider).pushNamed('search');
            }),
            verticalSpace(30),
            ...movieList(
              title: appLocalizations.now_playing,
              movies: ref.watch(nowPlayingProvider),
              onTap: (movie) {
                ref.read(routerProvider).pushNamed('detail', extra: movie);
              },
            ),
            verticalSpace(30),
            ...promotionList(
                title: appLocalizations.promotions,
                promotionImageFileNames: promotionImageFileNames),
            verticalSpace(30),
            ...movieList(
              title: appLocalizations.upcoming,
              movies: ref.watch(upComingProvider),
              onTap: (movie) {},
            ),
            verticalSpace(100),
          ],
        )
      ],
    );
  }
}
