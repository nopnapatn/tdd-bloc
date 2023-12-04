import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc/core/utils/typedefs.dart';
import 'package:tdd_bloc/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_bloc/src/auth/data/models/user_model.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;

  final User? _user;

  @override
  User? get user => _user;
}

class MockUser extends Mock implements User {
  String _uid = 'Test uid';

  @override
  String get uid => _uid;

  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

void main() {
  late FirebaseAuth authClient;
  late FirebaseFirestore cloudStoreClient;
  late FirebaseStorage dbClient;
  late AuthRemoteDataSource dataSource;
  late UserCredential userCredential;
  late MockUser mockUser;
  late DocumentReference<DataMap> documentReference;

  const tUser = LocalUserModel.empty();

  setUpAll(() async {
    authClient = MockFirebaseAuth();
    cloudStoreClient = FakeFirebaseFirestore();
    dbClient = MockFirebaseStorage();
    dataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
    mockUser = MockUser()..uid = documentReference.id;
    userCredential = MockUserCredential(mockUser);
    documentReference =
        await cloudStoreClient.collection('users').add(tUser.toMap());
  });

  when(
    () => authClient.currentUser,
  ).thenReturn(mockUser);

  const tEmail = 'Test Email';
  const tPassword = 'Test Password';
  const tFullName = 'Test Full Name';

  group('forgotPassword', () {
    test('should complete successfully when no [Exception] is thrown',
        () async {
      when(
        () => authClient.sendPasswordResetEmail(email: any(named: 'email')),
      ).thenAnswer((_) async => Future.value());

      final call = dataSource.forgotPassword(tEmail);

      expect(call, completes);
      verify(
        () => authClient.sendPasswordResetEmail(email: tEmail),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });
}
