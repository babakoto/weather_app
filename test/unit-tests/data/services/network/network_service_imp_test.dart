import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/data/services/network/network_service_imp.dart';

class MockInternetChecker extends Mock
    implements InternetConnectionCheckerPlus {}

void main() {
  late MockInternetChecker checker;
  late NetworkServiceImp networkService;
  setUp(() {
    checker = MockInternetChecker();
    networkService = NetworkServiceImp(
      internetConnectionChecker: checker,
    );
  });
  test('Should return true when online', () async {
    when(() => checker.hasConnection).thenAnswer((_) async => true);
    final result = await networkService.hasConnexion;
    expect(result, true);
  });

  test('Should return false when offline', () async {
    when(() => checker.hasConnection).thenAnswer((_) async => false);
    final result = await networkService.hasConnexion;
    expect(result, false);
  });
}
