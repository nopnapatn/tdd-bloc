import 'package:equatable/equatable.dart';
import 'package:tdd_bloc/core/usecases/usecases.dart';
import 'package:tdd_bloc/core/utils/typedefs.dart';
import 'package:tdd_bloc/src/auth/domain/repositories/auth_repository.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  const SignUp(
    this._repository,
  );

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(SignUpParams params) => _repository.signUp(
        fullName: params.fullName,
        email: params.email,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  const SignUpParams.empty()
      : this(
          fullName: '',
          email: '',
          password: '',
        );

  @override
  List<String> get props => [fullName, email, password];
}
