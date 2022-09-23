import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';

abstract class UseCase<I, O> {
  Future<Fos<Failure, O>> call({required I input});
}
