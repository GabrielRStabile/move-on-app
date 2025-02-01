import 'dart:async';

import 'package:flutter/material.dart';
import 'package:move_on_app/data/services/health/health_service.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/ui/core/move_on_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.registerAll();

  unawaited(di.get<IHealthService>().init());

  runApp(const MoveOnApp());
}
