import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/domain/entities/user_entity.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';

class CurrentUserUseCase {
  final AuthRepository authRepository;

  Future<Fos<Failure, UserEntity>> call() async {
    return authRepository.currentUser();
  }

  const CurrentUserUseCase({
    required this.authRepository,
  });
}
