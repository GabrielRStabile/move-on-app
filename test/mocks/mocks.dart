import 'package:health/health.dart';
import 'package:mocktail/mocktail.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository.dart';
import 'package:move_on_app/data/services/health/health_service.dart';
import 'package:move_on_app/data/services/permission/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthMock extends Mock implements Health {}

class PermissionMock extends Mock implements Permission {}

class HealthServiceMock extends Mock implements IHealthService {}

class PermissionServiceMock extends Mock implements IPermissionService {}

class PermissionRepositoryMock extends Mock implements IPermissionRepository {}
