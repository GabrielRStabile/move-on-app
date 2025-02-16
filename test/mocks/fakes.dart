import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionFake extends Fake implements Permission {}

void registerAllFallbackValues() {
  registerFallbackValue(PermissionFake());
}
