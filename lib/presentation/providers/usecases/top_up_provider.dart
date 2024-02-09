import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/top_up/top_up.dart';
import '../repositories/transaction_repository/transaction_repository_provider.dart';

part 'top_up_provider.g.dart';

@riverpod
TopUp topUp(TopUpRef ref) =>
    TopUp(transactionRepository: ref.watch(transactionRepositoryProvider));
