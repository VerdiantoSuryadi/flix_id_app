import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions/int_extension.dart';
import '../../../misc/methods.dart';
import '../../../providers/router/router_provider.dart';
import '../../../providers/user_data/user_data_provider.dart';

Widget userInfo(WidgetRef ref, AppLocalizations appLocalizations) {
  var userData = ref.watch(userDataProvider);
  var photoUrl = userData.valueOrNull?.photoUrl;
  return Padding(
    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
    child: Row(
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: photoUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    imageUrl: photoUrl,
                    fit: BoxFit.cover,
                  ),
                )
              : const CircleAvatar(
                  backgroundImage: AssetImage('assets/pp-placeholder.png'),
                ),
        ),
        horizontalSpace(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${getGreeting(appLocalizations)}, ${userData.when(
                data: (user) => user?.name.split(' ').first ?? '',
                error: (error, stackTrace) => '',
                loading: () => 'Loading...',
              )}!',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              appLocalizations.orderText,
              style: const TextStyle(fontSize: 12),
            ),
            verticalSpace(5),
            GestureDetector(
              onTap: () {
                ref.read(routerProvider).pushNamed('wallet');
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: Image.asset('assets/wallet.png'),
                  ),
                  horizontalSpace(10),
                  Text(
                    userData.when(
                      data: (user) =>
                          (user?.balance ?? 0).toIDRCurrencyFormat(),
                      error: (error, stackTrace) => 'IDR 0',
                      loading: () => 'Loading...',
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}

String getGreeting(AppLocalizations appLocalizations) {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return appLocalizations.goodMorning;
  } else if (hour < 18) {
    return appLocalizations.goodAfternoon;
  } else {
    return appLocalizations.goodEvening;
  }
}
