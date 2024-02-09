import '../../../data/repositories/transaction_repository.dart';
import '../../entities/result.dart';
import '../../entities/transaction.dart';
import '../usecase.dart';
import 'get_transaction_params.dart';

class GetTransaction
    implements UseCase<Result<List<Transaction>>, GetTransactionParams> {
  final TransactionRepository _transactionRepository;

  GetTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<List<Transaction>>> call(GetTransactionParams params) async {
    var transactionListResult =
        await _transactionRepository.getUserTransaction(uid: params.uid);

    return switch (transactionListResult) {
      Success(value: final transactionList) => Result.success(transactionList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
