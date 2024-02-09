import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../extensions/build_context_extension.dart';
import '../../misc/constant.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/flix_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

  XFile? xFile;
  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        ref
            .read(routerProvider)
            .goNamed('main', extra: xFile != null ? File(xFile!.path) : null);
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    var appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              verticalSpace(50),
              Center(
                child: Image.asset(
                  'assets/flix_logo.png',
                  width: 150,
                ),
              ),
              verticalSpace(50),
              GestureDetector(
                onTap: () async {
                  xFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      xFile != null ? FileImage(File(xFile!.path)) : null,
                  child: xFile != null
                      ? null
                      : const Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: ghostWhite,
                        ),
                ),
              ),
              verticalSpace(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    FlixTextField(
                        labelText: appLocalizations.nameLabel,
                        controller: nameController),
                    verticalSpace(24),
                    FlixTextField(
                        labelText: appLocalizations.emailLabel,
                        controller: emailController),
                    verticalSpace(24),
                    FlixTextField(
                      labelText: appLocalizations.passwordLabel,
                      controller: passwordController,
                      obsecureText: true,
                    ),
                    verticalSpace(24),
                    FlixTextField(
                      labelText: appLocalizations.retypeNewPassword,
                      controller: retypePasswordController,
                      obsecureText: true,
                    ),
                    verticalSpace(24),
                    switch (ref.watch(userDataProvider)) {
                      AsyncData(:final value) => value == null
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (passwordController.text ==
                                        retypePasswordController.text) {
                                      ref
                                          .read(userDataProvider.notifier)
                                          .register(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text);
                                    } else {
                                      context.showSnackBar(
                                          'Please retype your password with the same value');
                                    }
                                  },
                                  child: Text(appLocalizations.registerBtn)),
                            )
                          : const CircularProgressIndicator(),
                      _ => const CircularProgressIndicator()
                    },
                    verticalSpace(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${appLocalizations.alreadyHaveAccount}? '),
                        TextButton(
                            onPressed: () {
                              ref.read(routerProvider).goNamed('login');
                            },
                            child: Text(appLocalizations.loginHere))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
