import 'package:tdd_bloc/core/usecases/usecases.dart';
import 'package:tdd_bloc/core/utils/typedefs.dart';
import 'package:tdd_bloc/src/auth/domain/repositories/auth_repository.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword(
    this._repository,
  );

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.forgotPassword(params);
}
