import 'package:equatable/equatable.dart';
import 'package:tdd_bloc/core/enums/update_user.dart';
import 'package:tdd_bloc/core/usecases/usecases.dart';
import 'package:tdd_bloc/core/utils/typedefs.dart';
import 'package:tdd_bloc/src/auth/domain/repositories/auth_repository.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUser(
    this._repository,
  );

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repository.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  final UpdateUserAction action;
  final dynamic userData;

  const UpdateUserParams.empty()
      : this(action: UpdateUserAction.displayName, userData: '');

  @override
  List<dynamic> get props => [action, userData];
}
