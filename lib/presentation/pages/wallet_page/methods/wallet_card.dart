import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'card_content.dart';
import 'card_pattern.dart';
import 'membership_banner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget walletCard(WidgetRef ref, AppLocalizations appLocalizations) =>
    Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          cardPattern(ref),
          membershipBanner(ref),
          cardContent(ref, appLocalizations),
        ],
      ),
    );
