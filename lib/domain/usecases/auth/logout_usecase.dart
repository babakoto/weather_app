import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository authRepository;

  const LogOutUseCase({
    required this.authRepository,
  });

  Future<Fos<Failure, bool>> call() async {
    return authRepository.logOut();
  }
}
