import 'package:result_dart/result_dart.dart';

/// Repository interface for managing different types of permissions
abstract interface class IPermissionRepository {
  /// Requests health-related permissions (Health Connect and
  /// Activity Recognition)
  Future<Result<bool>> requestHealthPermission();

  /// Checks if health-related permissions are granted
  Future<Result<bool>> hasHealthPermission();

  /// Requests permission to send notifications
  Future<Result<bool>> requestNotificationPermission();

  /// Checks if notification permission is granted
  Future<Result<bool>> hasNotificationPermission();
}
