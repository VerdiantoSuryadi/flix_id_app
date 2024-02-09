import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/movie_detail.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/usecases/create_transaction/create_transaction.dart';
import '../../../domain/usecases/create_transaction/create_transaction_params.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/int_extension.dart';
import '../../misc/constant.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/transaction_data/transaction_data_provider.dart';
import '../../providers/usecases/create_transaction_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/back_navigation_bar.dart';
import '../../widgets/network_image_card.dart';
import 'methods/transaction_row.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingConfirmationPage(this.transactionDetail, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;

    transaction = transaction.copyWith(
        total: transaction.ticketAmount! * transaction.ticketPrice! +
            transaction.adminFee);

    var mqWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BackNavigationBar(
                  title: 'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                //backdrop
                NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  borderRadius: 15,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500/${movieDetail.backdropPath ?? movieDetail.posterPath}',
                  fit: BoxFit.cover,
                ),
                verticalSpace(24),
                //title
                SizedBox(
                  width: mqWidth - 48,
                  child: Text(
                    transaction.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                verticalSpace(5),
                const Divider(
                  color: ghostWhite,
                ),
                verticalSpace(5),
                transactionRow(
                    title: 'Showing Date',
                    value: DateFormat('EEE, d MMMM y').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            transaction.watchingTime ?? 0)),
                    width: mqWidth - 48),
                transactionRow(
                    title: 'Time',
                    value: DateFormat('Hm')
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            transaction.watchingTime ?? 0))
                        .toString(),
                    width: mqWidth - 48),
                transactionRow(
                    title: 'Theater',
                    value: '${transaction.theaterName}',
                    width: mqWidth - 48),
                transactionRow(
                    title: 'Seat Number',
                    value: transaction.seats.join(', '),
                    width: mqWidth - 48),
                transactionRow(
                    title: '# of Ticket',
                    value: '${transaction.ticketAmount} ticket(s)',
                    width: mqWidth - 48),
                transactionRow(
                    title: 'Ticket Price',
                    value: (transaction.ticketPrice ?? 0).toIDRCurrencyFormat(),
                    width: mqWidth - 48),
                transactionRow(
                    title: 'Adm. Fee',
                    value: (transaction.adminFee).toIDRCurrencyFormat(),
                    width: mqWidth - 48),
                verticalSpace(5),
                const Divider(
                  color: ghostWhite,
                ),
                verticalSpace(5),
                transactionRow(
                    title: 'Total Price',
                    value: (transaction.total).toIDRCurrencyFormat(),
                    width: mqWidth - 48),
                verticalSpace(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      var transactionTime =
                          DateTime.now().millisecondsSinceEpoch;
                      transaction = transaction.copyWith(
                        transactionTime: transactionTime,
                        id: 'flx-${transactionTime}_${transaction.uid}',
                      );
                      CreateTransaction createTransaction =
                          ref.read(createTransactionProvider);
                      await createTransaction(
                              CreateTransactionParams(transaction: transaction))
                          .then((result) {
                        switch (result) {
                          case Success(value: _):
                            ref
                                .read(transactionDataProvider.notifier)
                                .refreshTransactionData();
                            ref
                                .read(userDataProvider.notifier)
                                .refreshUserData();
                            ref.read(routerProvider).goNamed('main');
                            context.showSnackBar('Thank\'s for your booking');
                          case Failed(:final message):
                            context.showSnackBar(message);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: backgroundColor,
                        backgroundColor: saffron,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Pay Now'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
