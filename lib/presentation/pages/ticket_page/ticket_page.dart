import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/transaction_data/transaction_data_provider.dart';
import '../../widgets/ticket.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(transactionDataProvider).when(
      data: (transactions) {
        if (transactions.any((element) =>
            element.title != 'Top Up' &&
            element.watchingTime! >= DateTime.now().millisecondsSinceEpoch)) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                child: Column(
                  children: (transactions
                          .where((element) =>
                              element.title != 'Top Up' &&
                              element.watchingTime! >=
                                  DateTime.now().millisecondsSinceEpoch)
                          .toList()
                        ..sort(
                          (a, b) => a.watchingTime!.compareTo(b.watchingTime!),
                        ))
                      .map((transaction) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Ticket(transaction: transaction),
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.transactionDataEmpty,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }
      },
      error: (error, stackTrace) {
        return ListView(
          children: const [],
        );
      },
      loading: () {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        );
      },
    );
  }
}
