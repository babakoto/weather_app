import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';
import 'package:weather_app/domain/usecases/auth/is_authenticated_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late IsAuthenticatedUseCase isAuthenticatedUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    isAuthenticatedUseCase =
        IsAuthenticatedUseCase(authRepository: mockAuthRepository);
  });

  test('Should return Response from AuthRepository', () async {
    when(() => mockAuthRepository.isAuthenticated()).thenAnswer(
      (_) async => const SuccessResponse(
        true,
      ),
    );

    final result = await mockAuthRepository.isAuthenticated();

    expect(
        result,
        const SuccessResponse(
          true,
        ));
  });
}
