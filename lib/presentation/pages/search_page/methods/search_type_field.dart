import 'dart:developer';

import '../../../../domain/entities/movie.dart';
import '../../../providers/search/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../misc/constant.dart';

Widget searchTypeAhead(
    {required AsyncValue<List<Movie>> movies,
    required WidgetRef ref,
    required AppLocalizations appLocalizations,
    required TextEditingController myController,
    required FocusNode myFocusNode}) {
  var movie = movies.when(
    data: (data) {
      var result = data;
      return result;
    },
    error: (error, stackTrace) => [],
    loading: () => [],
  );
  return TypeAheadField<String>(
    builder: (context, controller, focusNode) {
      return TextField(
          style: const TextStyle(decorationThickness: 0, height: 2),
          controller: controller,
          focusNode: focusNode,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onTapOutside: (_) {},
          onChanged: (value) {
            controller.text = value;
            ref
                .read(showIconProvider.notifier)
                .update((state) => controller.text.isNotEmpty ? true : false);

            log(controller.text);
          },
          onEditingComplete: () {
            focusNode.unfocus();
            var searchText = ref
                .watch(searchProvider.notifier)
                .update((state) => controller.text);
            ref
                .read(searchControllerProvider.notifier)
                .onSearch(searchText, movie);
          },
          onTap: () => ref
              .read(searchControllerProvider.notifier)
              .onSearch(controller.text, []),
          decoration: InputDecoration(
            suffixIcon: (ref.watch(showIconProvider) == true)
                ? IconButton(
                    onPressed: () {
                      controller.text = "";
                      ref.read(searchProvider.notifier).update((state) => "");
                      ref
                          .read(showIconProvider.notifier)
                          .update((state) => false);
                      ref
                          .read(searchControllerProvider.notifier)
                          .onSearch(controller.text, []);
                      focusNode.requestFocus();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ))
                : const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
            hintText: appLocalizations.hintTextSearchMovie,
          ));
    },
    itemBuilder: (context, suggestion) {
      // List<InlineSpan> temp = [];
      // String suggestionInLowerCase = suggestion.toLowerCase();
      // List<String> splittedSuggestion =
      //     suggestionInLowerCase.split(myController.text.toLowerCase());
      // log(splittedSuggestion.toString());
      // for (var i = 0; i < splittedSuggestion.length - 1; i++) {
      //   if (splittedSuggestion.contains(myController.text.toLowerCase())) ;
      //   {
      //     temp.add(TextSpan(
      //         text: splittedSuggestion[i],
      //         style: const TextStyle(color: Colors.white)));
      //     temp.add(TextSpan(
      //         text: myController.text.toLowerCase(),
      //         style: const TextStyle(color: Colors.red)));
      //     temp.add(TextSpan(
      //         text: splittedSuggestion.last,
      //         style: const TextStyle(color: Colors.white)));
      //     return ListTile(
      //       title: Text.rich(TextSpan(children: temp)),
      //     );
      //   }
      // }
      return ListTile(
        title: Text(suggestion),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      );
    },
    onSelected: (value) {
      myController.text = value;
      ref.watch(searchProvider.notifier).update((state) => value);
      ref.read(searchControllerProvider.notifier).onSearch(value, movie);
      myFocusNode.unfocus();
    },
    suggestionsCallback: (pattern) {
      var result = movie
          .where((element) => element.title
              .toLowerCase()
              .startsWith(pattern.toLowerCase().substring(0)))
          .map((e) => e.title)
          .toList();
      var res = List<String>.from(result);
      // log(pattern);
      // log((res.map((e) => e.toLowerCase()).contains(pattern.toLowerCase()))
      //     .toString());
      if (pattern.isNotEmpty) {
        return res;
      } else {
        return [];
      }
    },
    decorationBuilder: (context, child) {
      return Material(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        color: navBar,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: child,
      );
    },
    hideOnEmpty: true,
    debounceDuration: Duration.zero,
    controller: myController,
    focusNode: myFocusNode,
  );
}
