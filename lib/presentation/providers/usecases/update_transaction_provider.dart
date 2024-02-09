import '../../../domain/usecases/update_transaction/update_transaction.dart';
import '../repositories/transaction_repository/transaction_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_transaction_provider.g.dart';

@riverpod
UpdateTransaction updateTransaction(UpdateTransactionRef ref) =>
    UpdateTransaction(
        transactionRepository: ref.watch(transactionRepositoryProvider));
