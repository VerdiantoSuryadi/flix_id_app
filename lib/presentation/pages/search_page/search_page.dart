import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../misc/methods.dart';
import '../../providers/movie/now_playing_provider.dart';
import '../../providers/router/router_provider.dart';
import 'methods/search_movie_list.dart';
import 'methods/search_type_field.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late TextEditingController _textEditingController;
  late FocusNode _myFocusNode;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: ListView(
          children: [
            // searchBar(
            //     movies: ref.watch(nowPlayingProvider),
            //     ref: ref,
            //     appLocalizations: appLocalizations),

            searchTypeAhead(
                movies: ref.watch(nowPlayingProvider),
                ref: ref,
                appLocalizations: appLocalizations,
                myController: _textEditingController,
                myFocusNode: _myFocusNode),
            verticalSpace(24),
            searchMovieList(
                ref: ref,
                onTap: (movie) =>
                    ref.read(routerProvider).pushNamed('detail', extra: movie)),
            verticalSpace(20)
          ],
        ),
      ),
    );
  }
}
