import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/build_context_extension.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/back_navigation_bar.dart';
import '../../widgets/flix_text_field.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  late TextEditingController newPassController;
  late TextEditingController retypeNewPassController;

  bool showPassword = false;
  bool showRetypePass = false;

  @override
  void initState() {
    super.initState();
    newPassController = TextEditingController();
    retypeNewPassController = TextEditingController();
  }

  @override
  void dispose() {
    newPassController.dispose();
    retypeNewPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
            child: Column(
              children: [
                BackNavigationBar(
                  title: AppLocalizations.of(context)!.changePassword,
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(40),
                StatefulBuilder(builder: (context, setState) {
                  return FlixTextField(
                    labelText: appLocalizations.newPassword,
                    controller: newPassController,
                    obsecureText: (showPassword) ? false : true,
                    icon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          (showPassword)
                              ? Icons.visibility
                              : Icons.visibility_off,
                        )),
                  );
                }),
                verticalSpace(24),
                StatefulBuilder(builder: (context, setState) {
                  return FlixTextField(
                    labelText: appLocalizations.retypeNewPassword,
                    controller: retypeNewPassController,
                    obsecureText: (showRetypePass) ? false : true,
                    icon: IconButton(
                        onPressed: () {
                          setState(() {
                            showRetypePass = !showRetypePass;
                          });
                        },
                        icon: Icon(
                          (showRetypePass)
                              ? Icons.visibility
                              : Icons.visibility_off,
                        )),
                  );
                }),
                verticalSpace(40),
                switch (ref.read(userDataProvider)) {
                  AsyncData(:final value) => value != null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (newPassController.text ==
                                    retypeNewPassController.text) {
                                  var user =
                                      ref.watch(userDataProvider).valueOrNull;
                                  if (user != null) {
                                    FocusScope.of(context).unfocus();
                                    ref
                                        .read(userDataProvider.notifier)
                                        .changePassword(
                                            email: user.email,
                                            password: newPassController.text)
                                        .then((value) {
                                      ref.read(routerProvider).pop();
                                      context.showSnackBar(
                                          "Your password succesfully changed");
                                    });
                                  }
                                } else {
                                  context.showSnackBar(
                                      'Please retype your password with the same value');
                                }
                              },
                              child: Text(appLocalizations.updatePassword)),
                        )
                      : const CircularProgressIndicator(),
                  _ => const CircularProgressIndicator(),
                }
              ],
            ),
          )
        ],
      ),
    );
  }
}
