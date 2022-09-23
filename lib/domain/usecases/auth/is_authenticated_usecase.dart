import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';

class IsAuthenticatedUseCase {
  final AuthRepository _authRepository;

  Future<Fos<Failure, bool>> call() async {
    return _authRepository.isAuthenticated();
  }

  const IsAuthenticatedUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;
}
