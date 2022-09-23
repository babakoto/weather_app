import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';
import 'package:weather_app/domain/usecases/auth/sign_in_usecase.dart';

import '../../../../constants/data_mocks.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSignInDto extends Mock implements SignInDto {}

void main() {
  late SignInUseCase signInUseCase;
  late MockAuthRepository mockAuthRepository;

  setUpAll(() {
    registerFallbackValue(MockSignInDto());
  });
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInUseCase = SignInUseCase(authRepository: mockAuthRepository);
  });

  test('Should return response from signIn in AuthRepository', () async {
    when(() => mockAuthRepository.signIn(signInDto: tSignInDto)).thenAnswer(
      (_) async => const SuccessResponse(
        tUserEntity,
      ),
    );

    final result = await signInUseCase(input: tSignInDto);

    expect(
        result,
        const SuccessResponse(
          tUserEntity,
        ));
  });
}
