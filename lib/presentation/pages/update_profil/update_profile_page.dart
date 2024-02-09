import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../extensions/build_context_extension.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/back_navigation_bar.dart';
import '../../widgets/flix_text_field.dart';
import 'methods/profile_picture.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  ConsumerState<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: ref.read(userDataProvider).valueOrNull?.name);
    emailController = TextEditingController(
        text: ref.read(userDataProvider).valueOrNull?.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  XFile? xFile;
  @override
  Widget build(BuildContext context) {
    var user = ref.read(userDataProvider).valueOrNull;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
            child: Column(
              children: [
                BackNavigationBar(
                  title: AppLocalizations.of(context)!.updateProfile,
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(50),
                profilePicture(context, ref, xFile, () {
                  context.showBottomModal((imageSource) async {
                    ref.read(routerProvider).pop();
                    if (imageSource != null) {
                      xFile =
                          await ImagePicker().pickImage(source: imageSource);
                      setState(() {});
                    }
                  }, ref);
                }),
                verticalSpace(40),
                FlixTextField(
                  labelText: AppLocalizations.of(context)!.emailLabel,
                  controller: emailController,
                  readOnly: true,
                  suffixText: '[read-only]',
                ),
                verticalSpace(24),
                FlixTextField(
                    labelText: AppLocalizations.of(context)!.nameLabel,
                    controller: nameController),
                verticalSpace(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (user != null && nameController.text.isNotEmpty) {
                          if (xFile != null) {
                            ref
                                .read(userDataProvider.notifier)
                                .uploadProfilePicture(
                                    user: user.copyWith(
                                        name: nameController.text),
                                    imageFile: File(xFile!.path));
                          } else {
                            ref.read(userDataProvider.notifier).changeUserName(
                                user: user, name: nameController.text);
                          }
                          FocusScope.of(context).unfocus();
                          ref.read(routerProvider).pop();
                        } else {
                          FocusScope.of(context).requestFocus();
                          context.showSnackBar('Please type your name');
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.update)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
