import '../../misc/constant.dart';
import '../../providers/language/language_provider.dart';
import '../../providers/repositories/language_repository/language_repository_provider.dart';
import '../../providers/router/router_provider.dart';
import '../../widgets/back_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguagePage extends ConsumerWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 50),
            child: BackNavigationBar(
              title: AppLocalizations.of(context)!.changeLanguage,
              onTap: () => ref.read(routerProvider).pop(),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: grey, width: 1))),
            child: ListTile(
              title: const Text(
                "English",
                style: TextStyle(color: grey, fontWeight: FontWeight.bold),
              ),
              style: ListTileStyle.list,
              onTap: () {
                ref
                    .read(languageRepositoryProvider)
                    .setLanguage(Language.english);
                ref.read(routerProvider).pop();
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: grey, width: 1))),
            child: ListTile(
              title: const Text(
                "Bahasa Indonesia",
                style: TextStyle(color: grey, fontWeight: FontWeight.bold),
              ),
              style: ListTileStyle.list,
              onTap: () {
                ref
                    .read(languageRepositoryProvider)
                    .setLanguage(Language.indonesia);
                ref.read(routerProvider).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}

Future<void> setLanguage(Locale language, WidgetRef ref) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setString("language", language.toString());
}
