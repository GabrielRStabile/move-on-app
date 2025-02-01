import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository_impl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:result_dart/result_dart.dart';

import '../../../mocks/fakes.dart';
import '../../../mocks/mocks.dart';

void main() {
  setUpAll(registerAllFallbackValues);

  late PermissionServiceMock permissionServiceMock;
  late HealthServiceMock healthServiceMock;
  late PermissionRepository repository;

  setUp(() {
    permissionServiceMock = PermissionServiceMock();
    healthServiceMock = HealthServiceMock();
    repository = PermissionRepository(
      permissionServiceMock,
      healthServiceMock,
    );
  });

  group('PermissionRepository', () {
    group('requestHealthPermission', () {
      test(
          'should return Success(true) when all permissions are granted on Android',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;

        when(
          () => permissionServiceMock.requestPermission(any()),
        ).thenAnswer((_) async => const Success(PermissionStatus.granted));

        when(
          () => healthServiceMock.requestAuthorization(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenAnswer((_) async => const Success(true));

        final result = await repository.requestHealthPermission();

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), true);
      });

      test(
          'should return Success(true) when health permission is granted on iOS',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        when(
          () => healthServiceMock.requestAuthorization(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenAnswer((_) async => const Success(true));

        final result = await repository.requestHealthPermission();

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), true);
      });

      test('should return Failure when any permission is denied', () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;

        when(
          () => permissionServiceMock.requestPermission(any()),
        ).thenAnswer((_) async => const Success(PermissionStatus.denied));

        when(
          () => healthServiceMock.requestAuthorization(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenAnswer((_) async => const Success(true));

        final result = await repository.requestHealthPermission();

        expect(result.isError(), true);
      });
    });

    group('hasHealthPermission', () {
      test(
          'should return Success(true) when all permissions are granted on Android',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;

        when(
          () => permissionServiceMock.checkPermission(any()),
        ).thenAnswer((_) async => const Success(PermissionStatus.granted));

        when(
          () => healthServiceMock.hasAuthorization(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenAnswer((_) async => const Success(true));

        final result = await repository.hasHealthPermission();

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), true);
      });

      test('should return Success(false) when any permission is denied',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;

        when(
          () => permissionServiceMock.checkPermission(any()),
        ).thenAnswer((_) async => const Success(PermissionStatus.denied));

        when(
          () => healthServiceMock.hasAuthorization(
            any(),
            permissions: any(named: 'permissions'),
          ),
        ).thenAnswer((_) async => const Success(true));

        final result = await repository.hasHealthPermission();

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), false);
      });
    });

    group('notification permissions', () {
      test('requestNotificationPermission should return permission status',
          () async {
        when(
          () => permissionServiceMock.requestPermission(any()),
        ).thenAnswer((_) async => const Success(PermissionStatus.granted));

        final result = await repository.requestNotificationPermission();

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), true);
      });

      test('hasNotificationPermission should return current permission status',
          () async {
        when(
          () => permissionServiceMock.checkPermission(any()),
        ).thenAnswer((_) async => const Success(PermissionStatus.granted));

        final result = await repository.hasNotificationPermission();

        expect(result.isSuccess(), true);
        expect(result.getOrNull(), true);
      });
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });
}
