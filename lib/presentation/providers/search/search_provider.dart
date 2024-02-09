import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = AutoDisposeStateProvider<String>((ref) => '');

final showIconProvider = AutoDisposeStateProvider<bool>((ref) => false);

final textColorProvider = AutoDisposeStateProvider<Color>((ref) => Colors.red);

final myFocusNodeProvider = AutoDisposeProvider<FocusNode>((ref) {
  FocusNode myFocusNode = FocusNode();
  return myFocusNode;
});

final searchControllerProvider =
    StateNotifierProvider.autoDispose<SearchController, List>(
        (ref) => SearchController());

class SearchController extends StateNotifier<List> {
  SearchController() : super([]);

  void onSearch(String query, List<dynamic> movie) {
    state = [];
    if (query.isNotEmpty) {
      final result = movie
          .where((element) => element.title
              .toLowerCase()
              .startsWith(query.toLowerCase().substring(0)))
          .toList();

      state.addAll(result);
    }
  }
}
