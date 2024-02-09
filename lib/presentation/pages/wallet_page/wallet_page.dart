import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/build_context_extension.dart';
import '../../misc/constant.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../widgets/back_navigation_bar.dart';
import 'methods/recent_transaction.dart';
import 'methods/wallet_card.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.showADialog(ref);
        },
        label: Text(appLocalizations.clearRecents),
        icon: const Icon(Icons.delete),
        backgroundColor: ghostWhite,
        foregroundColor: backgroundColor,
        splashColor: grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                BackNavigationBar(
                  title: appLocalizations.myWallet,
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                walletCard(ref, appLocalizations),
                verticalSpace(24),
                ...recentTransactions(ref, appLocalizations),
              ],
            ),
          )
        ],
      ),
    );
  }
}
