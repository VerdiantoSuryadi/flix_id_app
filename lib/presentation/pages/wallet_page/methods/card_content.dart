import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions/int_extension.dart';
import '../../../misc/constant.dart';
import '../../../misc/methods.dart';
import '../../../providers/user_data/user_data_provider.dart';

Widget cardContent(WidgetRef ref, AppLocalizations appLocalizations) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.currentBalance,
                style: TextStyle(
                    fontSize: 12, color: Colors.white.withOpacity(0.5)),
              ),
              Text(
                (ref.watch(userDataProvider).valueOrNull?.balance ?? 0)
                    .toIDRCurrencyFormat(),
                style: const TextStyle(
                    color: Color(0xFFEAA94E),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpace(10),
              Text(ref.watch(userDataProvider).valueOrNull?.name ?? '')
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => ref.watch(userDataProvider.notifier).topUp(100000),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: grey800,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFFEAA94E),
                  ),
                ),
              ),
              Text(
                appLocalizations.topUp,
                style: const TextStyle(color: grey, fontSize: 10),
              )
            ],
          )
        ],
      ),
    );
