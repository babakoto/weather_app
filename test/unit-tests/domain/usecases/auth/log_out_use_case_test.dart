import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';
import 'package:weather_app/domain/usecases/auth/logout_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LogOutUseCase logOutUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logOutUseCase = LogOutUseCase(authRepository: mockAuthRepository);
  });

  test('Should call logout in authRepository', () async {
    when(() => mockAuthRepository.logOut())
        .thenAnswer((_) async => const SuccessResponse(true));
    final result = await logOutUseCase();
    verify(() => mockAuthRepository.logOut()).called(1);
    expect(result, const SuccessResponse(true));
  });
}
