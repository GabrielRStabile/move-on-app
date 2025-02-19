import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:move_on_app/data/services/health/health_service.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/ui/core/move_on_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MediaKit.ensureInitialized();

  await di.registerAll();

  unawaited(di.get<IHealthService>().init());

  runApp(const MoveOnApp());
}
