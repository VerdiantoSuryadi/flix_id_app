import '../../language/language_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageRepository {
  final Ref ref;
  LanguageRepository({required this.ref});

  static const String languageCodeKey = 'language_code';

  Future<void> setLanguage(Language language) async {
    final pref = await ref.read(sharedPreferencesProvider.future);
    await pref.setString(languageCodeKey, language.code);
    ref.read(languageProvider.notifier).update((_) => language);
  }

  Future<Language> getLanguage() async {
    final pref = await ref.read(sharedPreferencesProvider.future);
    final code = pref.getString(languageCodeKey);
    for (var value in Language.values) {
      if (value.code == code) {
        return value;
      }
    }
    return Language.english;
  }
}

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) => SharedPreferences.getInstance());

final languageRepositoryProvider =
    Provider<LanguageRepository>((ref) => LanguageRepository(ref: ref));
