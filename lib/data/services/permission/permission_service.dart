import 'package:permission_handler/permission_handler.dart';
import 'package:result_dart/result_dart.dart';

/// Interface for handling device permissions
abstract interface class IPermissionService {
  /// Requests a specific permission from the user
  ///
  /// [permission] - The permission to request
  /// Returns the status of the permission after the request
  Future<Result<PermissionStatus>> requestPermission(Permission permission);

  /// Checks the current status of a specific permission
  ///
  /// [permission] - The permission to check
  /// Returns the current status of the permission
  Future<Result<PermissionStatus>> checkPermission(Permission permission);
}
