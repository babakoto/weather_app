import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/core/utils/usecase/usecase.dart';
import 'package:weather_app/domain/entities/user_entity.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';

class SignInUseCase implements UseCase<SignInDto, UserEntity> {
  final AuthRepository authRepository;
  const SignInUseCase({
    required this.authRepository,
  });

  @override
  Future<Fos<Failure, UserEntity>> call({required SignInDto input}) async {
    return authRepository.signIn(
      signInDto: input,
    );
  }
}
