import '../../../domain/usecases/update_transaction/update_transaction.dart';
import '../../../domain/usecases/update_transaction/update_transaction_params.dart';
import '../usecases/update_transaction_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/result.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_transaction/get_transaction.dart';
import '../../../domain/usecases/get_transaction/get_transaction_params.dart';
import '../usecases/get_transaction_provider.dart';
import '../user_data/user_data_provider.dart';

part 'transaction_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionData extends _$TransactionData {
  @override
  Future<List<Transaction>> build() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();

      GetTransaction getTransaction = ref.read(getTransactionProvider);

      var result = await getTransaction(GetTransactionParams(uid: user.uid));

      if (result case Success(value: final transaction)) {
        return transaction;
      }
    }
    return const [];
  }

  Future<void> refreshTransactionData() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();

      GetTransaction getTransaction = ref.read(getTransactionProvider);

      var result = await getTransaction(GetTransactionParams(uid: user.uid));

      switch (result) {
        case Success(value: final transaction):
          state = AsyncData(transaction);
        case Failed(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }

  Future<void> updateTransaction() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();

      UpdateTransaction updateTransaction = ref.read(updateTransactionProvider);

      var result =
          await updateTransaction(UpdateTransactionParams(uid: user.uid));

      switch (result) {
        case Success(value: final transaction):
          state = AsyncData(transaction);
        case Failed(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }
}
