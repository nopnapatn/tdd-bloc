import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc/src/auth/domain/usecases/forget_password.dart';
import 'package:tdd_bloc/src/auth/domain/usecases/sign_in.dart';
import 'package:tdd_bloc/src/auth/domain/usecases/sign_up.dart';
import 'package:tdd_bloc/src/auth/domain/usecases/update_user.dart';
import 'package:tdd_bloc/src/auth/presentation/bloc/auth_bloc.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late AuthBloc authBloc;

  const tSignUpParams = SignUpParams.empty();
  const tUpdateUserParams = UpdateUserParams.empty();
  const tSignInParams = SignInParams.empty();

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    authBloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );
  });

  setUpAll(() {
    registerFallbackValue(tUpdateUserParams);
    registerFallbackValue(tSignUpParams);
    registerFallbackValue(tSignInParams);
  });

  tearDown(() => authBloc.close());

  test('initialState should be [AuthInitial]', () async {
    expect(authBloc.state, const AuthInitial());
  });

  // group('SignInEvent', () {
  //   const tUser = LocalUserModel.empty();
  //   blocTest<AuthBloc, AuthState>(
  //       'should emit [AuthLoading, SignedIn when] [SignInEvent] is added',
  //       build: () {
  //         when(
  //           () => signUp(any()),
  //         ).thenAnswer((_) async => const Right(tUser));
  //         return authBloc;
  //       },
  //       act: (bloc) => bloc.add(SignInEvent(
  //             email: tSignInParams.email,
  //             password: tSignInParams.password,
  //           )),
  //       expect: () => [
  //             const AuthLoading(),
  //             const SignedIn(tUser),
  //           ],
  //       verify: (_) {
  //         verify(
  //           () => signIn(tSignInParams),
  //         ).called(1);
  //         verifyNoMoreInteractions(signIn);
  //       });
  // });
}
