import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import '../../../providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../misc/constant.dart';

Widget profilePicture(
    BuildContext context, WidgetRef ref, XFile? xFile, VoidCallback? onTap) {
  var photoUrl = ref.watch(userDataProvider).valueOrNull?.photoUrl;
  return Stack(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.3,
        child: photoUrl != null && xFile == null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  fit: BoxFit.cover,
                  imageUrl: photoUrl,
                ),
              )
            : photoUrl == null && xFile != null
                ? CircleAvatar(
                    backgroundImage: FileImage(File(xFile.path)),
                  )
                : photoUrl != null && xFile != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(File(xFile.path)),
                      )
                    : const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/pp-placeholder.png'),
                      ),
      ),
      Positioned(
          bottom: 0,
          right: 0,
          child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                  foregroundColor: backgroundColor,
                  backgroundColor: ghostWhite,
                  padding: const EdgeInsets.all(12),
                  shape: const CircleBorder(
                      side: BorderSide(color: grey, width: 1))),
              child: const Icon(
                Icons.add_photo_alternate_rounded,
                size: 30,
              )))
    ],
  );
}
