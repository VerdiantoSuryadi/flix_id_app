import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../extensions/build_context_extension.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import 'methods/profile_item.dart';
import 'methods/user_info.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userDataProvider).valueOrNull;
    XFile? xFile;
    var appLocalizations = AppLocalizations.of(context)!;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              verticalSpace(20),
              ...userInfo(context, ref, () async {
                context.showBottomModal((imageSource) async {
                  ref.read(routerProvider).pop();
                  if (imageSource != null) {
                    xFile = await ImagePicker().pickImage(source: imageSource);
                    if (xFile != null && user != null) {
                      ref.read(userDataProvider.notifier).uploadProfilePicture(
                          user: user, imageFile: File(xFile!.path));
                    }
                  }
                }, ref);
              }),
              verticalSpace(20),
              const Divider(),
              verticalSpace(20),
              profileItem(
                appLocalizations.updateProfile,
                onTap: () =>
                    ref.read(routerProvider).pushNamed('update_profile'),
              ),
              verticalSpace(20),
              profileItem(
                appLocalizations.myWallet,
                onTap: () => ref.read(routerProvider).pushNamed('wallet'),
              ),
              verticalSpace(20),
              profileItem(
                appLocalizations.changePassword,
                onTap: () =>
                    ref.read(routerProvider).pushNamed('change_password'),
              ),
              verticalSpace(20),
              profileItem(
                appLocalizations.changeLanguage,
                onTap: () =>
                    ref.read(routerProvider).pushNamed('change_language'),
              ),
              verticalSpace(20),
              const Divider(),
              verticalSpace(20),
              profileItem(appLocalizations.contactUs),
              verticalSpace(20),
              profileItem(appLocalizations.privacyPolicy),
              verticalSpace(20),
              profileItem(appLocalizations.termsAndCondition),
              verticalSpace(60),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      ref.watch(userDataProvider.notifier).logout();
                    },
                    child: Text(appLocalizations.logout)),
              ),
              verticalSpace(20),
              Text(
                '${appLocalizations.version} 0.0.1',
                style: const TextStyle(fontSize: 12),
              ),
              verticalSpace(100)
            ],
          ),
        )
      ],
    );
  }
}

// void showBottomModal(BuildContext context,
//     void Function(ImageSource? imageSource) onTap, WidgetRef ref) {
//   showModalBottomSheet(
//     backgroundColor: ghostWhite,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(10), topRight: Radius.circular(10))),
//     context: context,
//     builder: (context) {
//       return Container(
//         width: double.infinity,
//         height: 210,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           children: [
//             Container(
//               width: 70,
//               height: 10,
//               decoration: BoxDecoration(
//                   color: backgroundColor,
//                   borderRadius: BorderRadius.circular(20)),
//             ),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.only(top: 15, bottom: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Profile Picture',
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: backgroundColor),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       ref.read(routerProvider).pop();
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           backgroundColor: ghostWhite,
//                           title: const Text(
//                             'Delete profile picture',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: backgroundColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           content: const Text(
//                             'Are you sure want to delete?',
//                             textAlign: TextAlign.center,
//                             style:
//                                 TextStyle(fontSize: 16, color: backgroundColor),
//                           ),
//                           actionsAlignment: MainAxisAlignment.spaceEvenly,
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   ref.read(routerProvider).pop();
//                                 },
//                                 child: const Text(
//                                   'No',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       color: backgroundColor,
//                                       fontWeight: FontWeight.w600),
//                                 )),
//                             TextButton(
//                                 onPressed: () async {
//                                   var user =
//                                       ref.watch(userDataProvider).valueOrNull;
//                                   if (user != null && user.photoUrl != null) {
//                                     ref
//                                         .read(userDataProvider.notifier)
//                                         .deleteProfilePicture(user: user)
//                                         .then((_) {
//                                       ref.read(routerProvider).pop();
//                                       context.showSnackBar(
//                                           'Success delete profile picture');
//                                     });
//                                   } else {
//                                     ref.read(routerProvider).pop();
//                                     context.showSnackBar(
//                                         'You don\'t have profile picture. So you use a default profile picture');
//                                   }
//                                 },
//                                 child: const Text(
//                                   'Delete',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.w600),
//                                 ))
//                           ],
//                         ),
//                       );
//                     },
//                     splashFactory: InkRipple.splashFactory,
//                     highlightColor: backgroundColor.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(10),
//                     child: const Padding(
//                       padding: EdgeInsets.all(5),
//                       child: Icon(
//                         Icons.delete,
//                         size: 30,
//                         color: Colors.red,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Column(
//                     children: [
//                       SizedBox(
//                         width: 70,
//                         height: 70,
//                         child: ElevatedButton(
//                             onPressed: () => onTap(ImageSource.camera),
//                             style: ElevatedButton.styleFrom(
//                                 shape: const CircleBorder(
//                                     side: BorderSide(
//                                         color: backgroundColor, width: 2)),
//                                 padding: EdgeInsets.zero,
//                                 backgroundColor: ghostWhite,
//                                 foregroundColor: backgroundColor),
//                             child: const Icon(
//                               Icons.photo_camera,
//                               size: 35,
//                             )),
//                       ),
//                       verticalSpace(5),
//                       const Text(
//                         'Camera',
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: backgroundColor,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   horizontalSpace(10),
//                   Column(
//                     children: [
//                       SizedBox(
//                         width: 70,
//                         height: 70,
//                         child: ElevatedButton(
//                             onPressed: () => onTap(ImageSource.gallery),
//                             style: ElevatedButton.styleFrom(
//                                 shape: const CircleBorder(
//                                     side: BorderSide(
//                                         color: backgroundColor, width: 2)),
//                                 padding: EdgeInsets.zero,
//                                 backgroundColor: ghostWhite,
//                                 foregroundColor: backgroundColor),
//                             child: const Icon(
//                               Icons.photo,
//                               size: 35,
//                             )),
//                       ),
//                       verticalSpace(5),
//                       const Text(
//                         'Gallery',
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: backgroundColor,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       );
//     },
//   );
// }
