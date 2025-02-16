import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/ui/onboarding/widgets/permission_asking_screen.dart';
import 'package:result_dart/result_dart.dart';

import '../../../app.dart';
import '../../../mocks/mocks.dart';

void main() {
  late PermissionRepositoryMock permissionRepositoryMock;

  setUp(() {
    permissionRepositoryMock = PermissionRepositoryMock();

    final autoInjector = AutoInjector()
      ..addInstance<IPermissionRepository>(permissionRepositoryMock)
      ..commit();

    internalDi = DIImpl()..autoInjector = autoInjector;

    when(() => permissionRepositoryMock.hasHealthPermission())
        .thenAnswer((_) async => const Success(false));
    when(() => permissionRepositoryMock.hasNotificationPermission())
        .thenAnswer((_) async => const Success(false));
    when(() => permissionRepositoryMock.requestHealthPermission())
        .thenAnswer((_) async => const Success(true));
    when(() => permissionRepositoryMock.requestNotificationPermission())
        .thenAnswer((_) async => const Success(true));
  });

  Future<void> pumpWidget(WidgetTester tester) async {
    await testApp(
      tester,
      const MaterialApp(
        home: Scaffold(
          body: PermissionAskingScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('PermissionAskingScreen', () {
    testWidgets('should show loading state initially', (tester) async {
      await pumpWidget(tester);

      expect(find.text('Precisamos da sua permissão'), findsOneWidget);
      expect(find.text('Permitir'), findsOneWidget);
      expect(find.text('Me lembre mais tarde'), findsOneWidget);
    });

    testWidgets('should request permissions when allow button is pressed',
        (tester) async {
      await pumpWidget(tester);

      await tester.tap(find.text('Permitir'));
      await tester.pumpAndSettle();

      verify(() => permissionRepositoryMock.requestHealthPermission())
          .called(1);
      verify(() => permissionRepositoryMock.requestNotificationPermission())
          .called(1);
    });

    testWidgets('should close screen when later button is pressed',
        (tester) async {
      await pumpWidget(tester);

      await tester.tap(find.text('Me lembre mais tarde'));
      await tester.pumpAndSettle();

      verifyNever(() => permissionRepositoryMock.requestHealthPermission());
      verifyNever(
        () => permissionRepositoryMock.requestNotificationPermission(),
      );
    });

    testWidgets(
        'should request only notification permission when health is already granted',
        (tester) async {
      when(() => permissionRepositoryMock.hasHealthPermission())
          .thenAnswer((_) async => const Success(true));

      await pumpWidget(tester);

      await tester.tap(find.text('Permitir'));
      await tester.pumpAndSettle();

      verifyNever(() => permissionRepositoryMock.requestHealthPermission());
      verify(() => permissionRepositoryMock.requestNotificationPermission())
          .called(1);
    });
  });
}
