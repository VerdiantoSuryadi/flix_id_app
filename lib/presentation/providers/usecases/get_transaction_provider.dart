import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/get_transaction/get_transaction.dart';
import '../repositories/transaction_repository/transaction_repository_provider.dart';

part 'get_transaction_provider.g.dart';

@riverpod
GetTransaction getTransaction(GetTransactionRef ref) => GetTransaction(
    transactionRepository: ref.watch(transactionRepositoryProvider));
