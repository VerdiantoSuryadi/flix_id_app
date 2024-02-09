import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Language extends StateNotifier<Locale> {
//   Language() : super(const Locale.fromSubtags(languageCode: 'en'));

//   void en() => state = const Locale.fromSubtags(languageCode: 'en');
//   void id() => state = const Locale.fromSubtags(languageCode: 'id');
// }

// final languageProvider = StateNotifierProvider<Language, Locale>((ref) {
//   return Language();
// });

enum Language {
  english(name: 'English', code: 'en'),
  indonesia(name: 'Indonesia', code: 'id');

  final String name;
  final String code;

  const Language({required this.name, required this.code});
}

final languageProvider = StateProvider<Language>(
  (ref) => Language.english,
);
