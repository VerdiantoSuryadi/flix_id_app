import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../misc/constant.dart';
import '../misc/methods.dart';
import '../providers/router/router_provider.dart';
import '../providers/transaction_data/transaction_data_provider.dart';
import '../providers/user_data/user_data_provider.dart';

extension BuildContextExtension on BuildContext {
  void showSnackBar(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));

  void showADialog(WidgetRef ref) => showDialog(
        context: this,
        builder: (context) => AlertDialog(
          backgroundColor: ghostWhite,
          title: const Text(
            "Clear Recents",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: backgroundColor),
          ),
          content: const Text(
            "Are you sure to clear recents?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: backgroundColor),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            TextButton(
                onPressed: () => ref.read(routerProvider).pop(),
                child: const Text(
                  'No',
                  style: TextStyle(fontSize: 16, color: backgroundColor),
                )),
            TextButton(
                onPressed: () async {
                  ref
                      .read(transactionDataProvider.notifier)
                      .updateTransaction()
                      .then((value) =>
                          showSnackBar("Success clear recent transactions"));

                  ref.read(routerProvider).pop();
                },
                child: const Text(
                  'Clear',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      );

  void showBottomModal(
          void Function(ImageSource? imageSource) onTap, WidgetRef ref) =>
      showModalBottomSheet(
        backgroundColor: ghostWhite,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: this,
        builder: (context) {
          return Container(
            width: double.infinity,
            height: 210,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 10,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 15, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profile Picture',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: backgroundColor),
                      ),
                      InkWell(
                        onTap: () {
                          ref.read(routerProvider).pop();
                          showDialog(
                            context: this,
                            builder: (context) => AlertDialog(
                              backgroundColor: ghostWhite,
                              title: const Text(
                                'Delete profile picture',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: backgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                'Are you sure want to delete?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: backgroundColor),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      ref.read(routerProvider).pop();
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: backgroundColor,
                                          fontWeight: FontWeight.w600),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      var user = ref
                                          .watch(userDataProvider)
                                          .valueOrNull;
                                      if (user != null &&
                                          user.photoUrl != null) {
                                        ref
                                            .read(userDataProvider.notifier)
                                            .deleteProfilePicture(user: user)
                                            .then((_) {
                                          ref.read(routerProvider).pop();
                                          context.showSnackBar(
                                              'Success delete profile picture');
                                        });
                                      } else {
                                        ref.read(routerProvider).pop();
                                        context.showSnackBar(
                                            'You don\'t have profile picture. So you use a default profile picture');
                                      }
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                          );
                        },
                        splashFactory: InkRipple.splashFactory,
                        highlightColor: backgroundColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: ElevatedButton(
                                onPressed: () => onTap(ImageSource.camera),
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(
                                        side: BorderSide(
                                            color: backgroundColor, width: 2)),
                                    padding: EdgeInsets.zero,
                                    backgroundColor: ghostWhite,
                                    foregroundColor: backgroundColor),
                                child: const Icon(
                                  Icons.photo_camera,
                                  size: 35,
                                )),
                          ),
                          verticalSpace(5),
                          const Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 16,
                                color: backgroundColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      horizontalSpace(10),
                      Column(
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: ElevatedButton(
                                onPressed: () => onTap(ImageSource.gallery),
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(
                                        side: BorderSide(
                                            color: backgroundColor, width: 2)),
                                    padding: EdgeInsets.zero,
                                    backgroundColor: ghostWhite,
                                    foregroundColor: backgroundColor),
                                child: const Icon(
                                  Icons.photo,
                                  size: 35,
                                )),
                          ),
                          verticalSpace(5),
                          const Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 16,
                                color: backgroundColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
}
