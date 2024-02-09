import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/build_context_extension.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/flix_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool showPassword = false;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (next.value != null) {
          ref.read(routerProvider).goNamed('main');
        }
      } else if (next is AsyncError) {
        FocusScope.of(context).requestFocus();
        context.showSnackBar(next.error.toString());
      }
    });

    var appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(100),
          Center(
            child: Image.asset(
              'assets/flix_logo.png',
              width: 150,
            ),
          ),
          verticalSpace(100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                FlixTextField(
                    labelText: appLocalizations.emailLabel,
                    controller: emailController),
                verticalSpace(24),
                StatefulBuilder(builder: (context, setState) {
                  return FlixTextField(
                    labelText: appLocalizations.passwordLabel,
                    controller: passwordController,
                    obsecureText: (showPassword) ? false : true,
                    icon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon((showPassword)
                            ? Icons.visibility
                            : Icons.visibility_off)),
                  );
                }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        ref.read(routerProvider).pushNamed('forgot_password');
                      },
                      child: Text(
                        "${appLocalizations.forgotPassword}?",
                      )),
                ),
                verticalSpace(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                ref.watch(userDataProvider.notifier).login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              },
                              child: Text(
                                appLocalizations.loginBtn,
                              )),
                        )
                      : const CircularProgressIndicator(),
                  _ => const CircularProgressIndicator()
                },
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${appLocalizations.dontHaveAccount}? "),
                    TextButton(
                        onPressed: () {
                          ref.read(routerProvider).goNamed('register');
                        },
                        child: Text(
                          appLocalizations.registerHere,
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
