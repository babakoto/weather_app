import 'package:logger/logger.dart';
import 'package:weather_app/data/services/logger/logger_service.dart';

class LoggerServiceImp implements LoggerService {
  final Logger logger;

  const LoggerServiceImp({
    required this.logger,
  });

  @override
  void error(data) {
    logger.e(data);
  }

  @override
  void info(data) {
    // TODO: implement info
  }

  @override
  void warning(data) {
    // TODO: implement warning
  }

  @override
  void verbose(data) {
    // TODO: implement verbose
  }

  @override
  void debug(data) {
    logger.d(data);
  }
}
