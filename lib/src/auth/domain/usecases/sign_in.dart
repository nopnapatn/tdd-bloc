import 'package:equatable/equatable.dart';
import 'package:tdd_bloc/core/usecases/usecases.dart';
import 'package:tdd_bloc/core/utils/typedefs.dart';
import 'package:tdd_bloc/src/auth/domain/entities/user.dart';
import 'package:tdd_bloc/src/auth/domain/repositories/auth_repository.dart';

class SignIn extends UsecaseWithParams<LocalUser, SignInParams> {
  const SignIn(
    this._repository,
  );

  final AuthRepository _repository;

  @override
  ResultFuture<LocalUser> call(SignInParams params) => _repository.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  const SignInParams.empty()
      : email = '',
        password = '';

  @override
  List<String> get props => [email, password];
}
