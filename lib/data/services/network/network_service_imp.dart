import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_app/data/services/network/network_service.dart';

class NetworkServiceImp implements NetworkService {
  final InternetConnectionCheckerPlus internetConnectionChecker;

  const NetworkServiceImp({
    required this.internetConnectionChecker,
  });

  @override
  Future<bool> get hasConnexion => internetConnectionChecker.hasConnection;
}
