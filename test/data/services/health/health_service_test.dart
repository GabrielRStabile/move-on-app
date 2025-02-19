import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:mocktail/mocktail.dart';
import 'package:move_on_app/data/services/health/health_service_impl.dart';

import '../../../mocks/mocks.dart';

void main() {
  late HealthMock healthMock;
  late HealthService healthService;
  final date = DateTime.now();

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

    group('getWaterCups', () {
      test('should return mililitters when successful', () async {
        final result = await healthService.getWaterConsumption(date);

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), 0);
      });

      test('should return Failure when an error occurs', () async {
        final result = await healthService.getWaterConsumption(date);

        expect(result.isError(), true);
        expect(
          result.exceptionOrNull()?.toString(),
          contains('Falha ao obter a quantidade de copos de água'),
        );
      });
    });

    group('getCalories', () {
      test('should return Success(0) when successful', () async {
        final result = await healthService.getCalories(date);

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), 0);
      });

      test('should return Failure when an error occurs', () async {
        final result = await healthService.getCalories(date);

        expect(result.isError(), true);
        expect(
          result.exceptionOrNull()?.toString(),
          contains('Falha ao obter a quantidade de calorias'),
        );
      });
    });

    group('saveWaterCups', () {
      test('should return Success(null) when successful', () async {
        final result = await healthService.saveWaterConsumption(date, 2);

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), null);
      });

      test('should return Failure when an error occurs', () async {
        final result = await healthService.saveWaterConsumption(date, 2);

        expect(result.isError(), true);
        expect(
          result.exceptionOrNull()?.toString(),
          contains('Falha ao salvar a quantidade de copos de água'),
        );
      });
    });

    group('saveCalories', () {
      test('should return Success(null) when successful', () async {
        final result = await healthService.saveCalories(date, 100);

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), null);
      });

      test('should return Failure when an error occurs', () async {
        final result = await healthService.saveCalories(date, 100);

        expect(result.isError(), true);
        expect(
          result.exceptionOrNull()?.toString(),
          contains('Falha ao salvar a quantidade de calorias'),
        );
      });
    });

    group('getSleepHours', () {
      test(
          'should return Success(Duration.zero) when no sleep data is available',
          () async {
        when(
          () => healthMock.getHealthDataFromTypes(
            types: [HealthDataType.SLEEP_IN_BED],
            startTime: any(named: 'startTime'),
            endTime: any(named: 'endTime'),
          ),
        ).thenAnswer((_) async => []);

        final result = await healthService.getSleepHours(date);

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), Duration.zero);
      });

      test('should return Success with correct duration when sleep data exists',
          () async {
        when(
          () => healthMock.getHealthDataFromTypes(
            types: [HealthDataType.SLEEP_IN_BED],
            startTime: any(named: 'startTime'),
            endTime: any(named: 'endTime'),
          ),
        ).thenAnswer(
          (_) async => [
            HealthDataPoint(
              uuid: 'test',
              value: NumericHealthValue(numericValue: 480),
              type: HealthDataType.SLEEP_IN_BED,
              sourceId: 'test',
              sourceName: 'test',
              unit: HealthDataUnit.MINUTE,
              dateFrom: date.subtract(const Duration(hours: 8)),
              dateTo: date.add(
                const Duration(hours: 8),
              ),
              sourcePlatform: HealthPlatformType.appleHealth,
              sourceDeviceId: 'test',
            ),
          ],
        );

        final result = await healthService.getSleepHours(date);

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), const Duration(hours: 8));
      });

      test('should return Failure when an error occurs', () async {
        when(
          () => healthMock.getHealthDataFromTypes(
            types: [HealthDataType.SLEEP_IN_BED],
            startTime: any(named: 'startTime'),
            endTime: any(named: 'endTime'),
          ),
        ).thenThrow(Exception());

        final result = await healthService.getSleepHours(date);

        expect(result.isError(), true);
        expect(
          result.exceptionOrNull()?.toString(),
          contains('Falha ao obter as horas de sono'),
        );
      });
    });
  });
}
