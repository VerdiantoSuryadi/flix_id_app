import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie.dart';
import '../../../misc/constant.dart';
import '../../../providers/search/search_provider.dart';

Widget searchBar(
    {required AsyncValue<List<Movie>> movies,
    required WidgetRef ref,
    required AppLocalizations appLocalizations}) {
  var searchText = ref.watch(searchProvider.notifier);
  var fcsNod = ref.watch(myFocusNodeProvider);
  String text = "";
  log(text);
  var movie = movies.when(
    data: (data) {
      var result = data;
      return result;
    },
    error: (error, stackTrace) => [],
    loading: () => [],
  );
  return LayoutBuilder(builder: (context, constraints) {
    return Autocomplete<String>(
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: constraints.maxWidth,
            child: Material(
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              color: navBar,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options
                    .map((e) => ListTile(
                          title: Text(
                            e,
                            style: const TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: e == options.last
                                  ? const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    )
                                  : BorderRadius.zero,
                              side: const BorderSide(color: saffron, width: 1)),
                          onTap: () => onSelected(e),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text.isEmpty || movie.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          return movie
              .where((element) => element.title
                  .toLowerCase()
                  .startsWith(textEditingValue.text.toLowerCase().substring(0)))
              .map((e) => e.title);
        }
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        fcsNod = focusNode;
        return TextField(
          autofocus: true,
          textInputAction: TextInputAction.search,
          controller: textEditingController,
          focusNode: fcsNod,
          onTapOutside: (_) {
            fcsNod.unfocus();
          },
          onChanged: (value) {
            textEditingController.text = value;
            text = value;
            ref.read(showIconProvider.notifier).update((state) =>
                textEditingController.text.isNotEmpty ? true : false);

            if (textEditingController.text.isEmpty) {
              ref
                  .read(searchControllerProvider.notifier)
                  .onSearch(textEditingController.text, []);

              searchText.update((state) => "");
            }
            log(textEditingController.text);
          },
          onEditingComplete: () {
            fcsNod.unfocus();
            searchText.update((state) => textEditingController.text);
            ref
                .read(searchControllerProvider.notifier)
                .onSearch(searchText.state, movie);
          },
          decoration: InputDecoration(
              hintText: appLocalizations.hintTextSearchMovie,
              suffixIcon: (ref.watch(showIconProvider) == true)
                  ? IconButton(
                      onPressed: () {
                        textEditingController.clear();
                        searchText.update((state) => '');
                        ref
                            .read(showIconProvider.notifier)
                            .update((state) => false);
                        ref
                            .read(searchControllerProvider.notifier)
                            .onSearch(searchText.state, movie);

                        fcsNod.requestFocus();
                      },
                      icon: const Icon(Icons.clear))
                  : const Icon(Icons.search)),
        );
      },
      onSelected: (option) {
        searchText.update((state) => option);
        ref.read(searchControllerProvider.notifier).onSearch(option, movie);

        fcsNod.unfocus();
      },
    );
  });
}
