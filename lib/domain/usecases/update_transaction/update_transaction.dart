import '../../../data/repositories/transaction_repository.dart';
import '../../entities/transaction.dart';
import 'update_transaction_params.dart';
import '../usecase.dart';

import '../../entities/result.dart';

class UpdateTransaction
    implements UseCase<Result<List<Transaction>>, UpdateTransactionParams> {
  final TransactionRepository _transactionRepository;

  UpdateTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;
  @override
  Future<Result<List<Transaction>>> call(UpdateTransactionParams params) async {
    var transactionResult =
        await _transactionRepository.updateTransaction(uid: params.uid);

    return switch (transactionResult) {
      Success(value: final transactionList) => Result.success(transactionList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
