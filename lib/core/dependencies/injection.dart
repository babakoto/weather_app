import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/data/repositories/auth_repository_imp.dart';
import 'package:weather_app/data/repositories/weather_repository_imp.dart';
import 'package:weather_app/data/services/auth/auth_service.dart';
import 'package:weather_app/data/services/auth/auth_service_imp.dart';
import 'package:weather_app/data/services/auth/fake_auth.dart';
import 'package:weather_app/data/services/environment/environment_service.dart';
import 'package:weather_app/data/services/logger/logger_service.dart';
import 'package:weather_app/data/services/logger/logger_service_imp.dart';
import 'package:weather_app/data/services/network/network_service.dart';
import 'package:weather_app/data/services/network/network_service_imp.dart';
import 'package:weather_app/data/services/storage/storage_service.dart';
import 'package:weather_app/data/services/storage/storage_service_imp.dart';
import 'package:weather_app/data/services/weather/weather_service.dart';
import 'package:weather_app/data/services/weather/weather_service_imp.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/auth/current_user_ucecase.dart';
import 'package:weather_app/domain/usecases/auth/is_authenticated_usecase.dart';
import 'package:weather_app/domain/usecases/auth/logout_usecase.dart';
import 'package:weather_app/domain/usecases/auth/sign_in_usecase.dart';
import 'package:weather_app/domain/usecases/weather/get_weather_by_city.dart';
import 'package:weather_app/presentation/blocs/blocs/auth/auth/auth_bloc.dart';
import 'package:weather_app/presentation/blocs/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:weather_app/presentation/blocs/weather/weather_bloc.dart';

var getIt = GetIt.instance;
Future<void> initializer() async {
  await EnvironmentService.config();

  /// LOGGER SERVICE
  getIt.registerLazySingleton<LoggerService>(
    () => LoggerServiceImp(
      logger: Logger(
        printer: PrettyPrinter(
            lineLength: 100,
            colors: true, // Colorful log messages
            printEmojis: true, // Print an emoji for each log message
            printTime: false // Should each log print contain a timestamp
            ),
      ),
    ),
  );

  /// STORAGES SERVICE
  getIt.registerLazySingleton<StorageService>(
    () => StorageServiceImp(
        storage: const FlutterSecureStorage(),
        loggerService: getIt<LoggerService>()),
  );

  Dio dio = Dio();

  /// Packages
  getIt.registerLazySingleton<Dio>(
    () => dio,
  );

  getIt.registerLazySingleton<InternetConnectionCheckerPlus>(
    () => InternetConnectionCheckerPlus(),
  );

  /// --------------------SERVICES -------------------
  getIt.registerLazySingleton<NetworkService>(
    () => NetworkServiceImp(
      internetConnectionChecker: getIt<InternetConnectionCheckerPlus>(),
    ),
  );
  getIt.registerLazySingleton<WeatherService>(
    () => WeatherServiceImp(
        networkService: getIt<NetworkService>(), dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthService>(
    () => AuthServiceImp(
      fakeAuth: FakeAuth(),
      networkService: getIt<NetworkService>(),
      storageService: getIt<StorageService>(),
      loggerService: getIt<LoggerService>(),
    ),
  );

  /// ------------------------------------------------------

  ///------------------  Repositories ----------------------
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      authService: getIt(),
    ),
  );

  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImp(weatherService: getIt<WeatherService>()),
  );

  ///-----------------------------------------------------------------

  ///------------------- USE CASES --------------------------------
  getIt.registerLazySingleton(
    () => SignInUseCase(
      authRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => IsAuthenticatedUseCase(
      authRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<LogOutUseCase>(
    () => LogOutUseCase(
      authRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<CurrentUserUseCase>(
    () => CurrentUserUseCase(
      authRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<GetWeatherByCity>(
    () => GetWeatherByCity(
      weatherRepository: getIt(),
    ),
  );

  ///----------------------------------------------------------------------

  ///--------------------------- Blocs  -----------------------------------
  getIt.registerFactory(
    () => SignInBloc(
      signInUseCase: getIt<SignInUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => WeatherBloc(getWeatherByCity: getIt<GetWeatherByCity>()),
  );

  getIt.registerFactory(
    () => AuthBloc(
        isAuthenticatedUseCase: getIt<IsAuthenticatedUseCase>(),
        logOutUseCase: getIt<LogOutUseCase>(),
        currentUserUseCase: getIt<CurrentUserUseCase>()),
  );

  ///----------------------------------------------------------------------
}
