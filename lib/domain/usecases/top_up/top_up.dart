import '../../../data/repositories/transaction_repository.dart';
import '../../entities/result.dart';
import '../../entities/transaction.dart';
import '../create_transaction/create_transaction.dart';
import '../create_transaction/create_transaction_params.dart';
import '../usecase.dart';
import 'top_up_params.dart';

class TopUp implements UseCase<Result<void>, TopUpParams> {
  final TransactionRepository _transactionRepository;

  TopUp({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(TopUpParams params) async {
    CreateTransaction createTransaction =
        CreateTransaction(transactionRepository: _transactionRepository);

    int transactionTime = DateTime.now().millisecondsSinceEpoch;

    var createTransactionResult = await createTransaction(
        CreateTransactionParams(
            transaction: Transaction(
                id: 'flxtp-$transactionTime-${params.userId}',
                uid: params.userId,
                title: 'Top Up',
                adminFee: 0,
                total: -params.amount,
                transactionTime: transactionTime)));

    return switch (createTransactionResult) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed('Failed to top up : $message')
    };
  }
}
