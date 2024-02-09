import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../misc/methods.dart';
import '../../../providers/transaction_data/transaction_data_provider.dart';
import '../../../widgets/transaction_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Widget> recentTransactions(
        WidgetRef ref, AppLocalizations appLocalizations) =>
    [
      Text(
        appLocalizations.recentTransaction,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(24),
      ...ref.watch(transactionDataProvider).when(
            data: (transactions) => transactions.isEmpty
                ? []
                : (transactions
                        .where((element) => element.cleared == false)
                        .toList()
                      ..sort(
                        (a, b) =>
                            -a.transactionTime!.compareTo(b.transactionTime!),
                      ))
                    .map((transaction) =>
                        TransactionCard(transaction: transaction)),
            error: (error, stackTrace) => [],
            loading: () => [const CircularProgressIndicator()],
          )
    ];
