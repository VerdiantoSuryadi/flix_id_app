import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/build_context_extension.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/back_navigation_bar.dart';
import '../../widgets/flix_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
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
                  title: appLocalizations.forgotPassword,
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(50),
                Center(
                  child: Image.asset(
                    'assets/flix_logo.png',
                    width: 150,
                  ),
                ),
                verticalSpace(100),
                FlixTextField(
                    labelText: appLocalizations.emailLabel,
                    controller: emailController),
                verticalSpace(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                ref
                                    .read(userDataProvider.notifier)
                                    .forgotPassword(email: emailController.text)
                                    .then((value) {
                                  if (value == true) {
                                    ref.read(routerProvider).pop();
                                    context.showSnackBar(
                                        'Success send reset password mail');
                                  } else {
                                    FocusScope.of(context).requestFocus();
                                  }
                                });
                              },
                              child: Text(appLocalizations.sendBtn)),
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
