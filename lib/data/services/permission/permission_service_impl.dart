import 'package:move_on_app/data/services/permission/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:result_dart/result_dart.dart';

/// Implementation of [IPermissionService] that handles device permission requests
/// using the permission_handler package
class PermissionService implements IPermissionService {
  /// Requests a specific permission from the device
  ///
  /// Uses the permission_handler to request the specified [permission]
  /// Returns a [Result] containing the [PermissionStatus] or an error if the request fails
  @override
  Future<Result<PermissionStatus>> requestPermission(
    Permission permission,
  ) async {
    try {
      final status = await permission.request();
      return Success(status);
    } catch (e) {
      return Failure(Exception('Falha ao solicitar permissão'));
    }
  }

  /// Checks the current status of a specific permission
  ///
  /// Uses the permission_handler to check the status of the specified [permission]
  /// Returns a [Result] containing the current [PermissionStatus] or an error if the check fails
  @override
  Future<Result<PermissionStatus>> checkPermission(
    Permission permission,
  ) async {
    try {
      final status = await permission.status;
      return Success(status);
    } catch (e) {
      return Failure(Exception('Falha ao verificar permissão'));
    }
  }
}
