import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:mocktail/mocktail.dart';
import 'package:move_on_app/data/services/health/health_service_impl.dart';

import '../../../mocks/mocks.dart';

void main() {
  late HealthMock healthMock;
  late HealthService healthService;

  setUp(() {
    healthMock = HealthMock();
    healthService = HealthService(health: healthMock);
  });

  group('HealthService', () {
    test('init should call Health configure', () async {
      when(() => healthMock.configure()).thenAnswer((_) async {});

      await healthService.init();

      verify(() => healthMock.configure()).called(1);
    });

    group('requestAuthorization', () {
      final dataTypes = [HealthDataType.STEPS];

      test('should return Success(true) when authorization is granted',
          () async {
        when(
          () => healthMock.requestAuthorization(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenAnswer((_) async => true);

        final result = await healthService.requestAuthorization(dataTypes);

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), true);
      });

      test('should return Failure when an error occurs', () async {
        when(
          () => healthMock.requestAuthorization(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenThrow(Exception());

        final result = await healthService.requestAuthorization(dataTypes);

        expect(result.isError(), true);
        expect(
          result.exceptionOrNull()?.toString(),
          contains('Falha ao solicitar permissão de saúde'),
        );
      });
    });

    group('hasAuthorization', () {
      final dataTypes = [HealthDataType.STEPS];

      test('should return Success(true) when has authorization', () async {
        when(
          () => healthMock.hasPermissions(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenAnswer((_) async => true);

        final result = await healthService.hasAuthorization(dataTypes);

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), true);
      });

      test('should return Success(true) when hasPermissions returns null',
          () async {
        when(
          () => healthMock.hasPermissions(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenAnswer((_) async => null);

        final result = await healthService.hasAuthorization(dataTypes);

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), true);
      });

      test('should return Failure when an error occurs', () async {
        when(
          () => healthMock.hasPermissions(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenThrow(Exception());

        final result = await healthService.hasAuthorization(dataTypes);

        expect(result.isError(), true);
        expect(
          result.exceptionOrNull()?.toString(),
          contains('Falha verificar permissão de saúde'),
        );
      });
    });
  });
}
