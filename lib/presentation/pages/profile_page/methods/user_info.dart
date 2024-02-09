import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../misc/methods.dart';
import '../../../providers/user_data/user_data_provider.dart';

List<Widget> userInfo(
    BuildContext context, WidgetRef ref, VoidCallback? onTap) {
  var photoUrl = ref.watch(userDataProvider).valueOrNull?.photoUrl;
  return [
    SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      child: photoUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                fit: BoxFit.cover,
                imageUrl: photoUrl,
              ),
            )
          : const CircleAvatar(
              backgroundImage: AssetImage('assets/pp-placeholder.png'),
            ),
    ),
    verticalSpace(10),
    Text(
      ref.watch(userDataProvider).valueOrNull?.name ?? '',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    Text(
      ref.watch(userDataProvider).valueOrNull?.email ?? '',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12),
    ),
  ];
}
