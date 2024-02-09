import '../../../data/repositories/transaction_repository.dart';
import '../../entities/result.dart';
import '../usecase.dart';
import 'create_transaction_params.dart';

class CreateTransaction
    implements UseCase<Result<void>, CreateTransactionParams> {
  final TransactionRepository _transactionRepository;

  CreateTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(CreateTransactionParams params) async {
    int transactionTime = DateTime.now().millisecondsSinceEpoch;
    var transactionResult = await _transactionRepository.createTransaction(
        transaction: params.transaction.copyWith(
      transactionTime: transactionTime,
      id: (params.transaction.id == null)
          ? 'flx-$transactionTime-${params.transaction.uid}'
          : params.transaction.id,
    ));

    return switch (transactionResult) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed(message)
    };
  }
}
