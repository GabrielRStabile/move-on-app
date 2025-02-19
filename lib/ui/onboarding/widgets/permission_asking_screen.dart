// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/data/repositories/permission/permission_repository.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/ui/core/assets.gen.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';

@RoutePage()

/// {@template permission_asking_screen}
/// A screen that requests user permissions for health data access.
///
/// This screen explains to users why the app needs certain permissions
/// and provides a UI to request those permissions. It displays:
/// * A main title explaining the permission request
/// * A subtitle with additional context
/// * Permission rows showing specific permissions needed
/// * Action buttons to accept or decline
///
/// Usage:
/// ```dart
/// PermissionAskingRoute().push(context);
/// ```
/// {@endtemplate}
class PermissionAskingScreen extends StatefulWidget {
  /// {@macro permission_asking_screen}
  const PermissionAskingScreen({super.key});

  @override
  State<PermissionAskingScreen> createState() => _PermissionAskingScreenState();
}

class _PermissionAskingScreenState extends State<PermissionAskingScreen> {
  final IPermissionRepository _permissionRepository = di.get();
  late final bool _hasHealthPermission;
  late final bool _hasNotificationPermission;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final results = await Future.wait([
      _permissionRepository.hasHealthPermission(),
      _permissionRepository.hasNotificationPermission(),
    ]);

    setState(() {
      _hasHealthPermission = results[0].getOrNull() ?? false;
      _hasNotificationPermission = results[1].getOrNull() ?? false;
      isLoading = false;
    });
  }

  Future<void> _requestPermissions() async {
    setState(() {
      isLoading = true;
    });

    if (!_hasHealthPermission) {
      await _permissionRepository.requestHealthPermission();
    }

    if (!_hasNotificationPermission) {
      await _permissionRepository.requestNotificationPermission();
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: FTheme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            Text(
              'Precisamos da sua permissão',
              style: CommonTextStyle.of(context).h1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Personalize ainda mais suas experiência no nosso App',
              style: CommonTextStyle.of(context).subtitle,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            _PermissionRow(
              icon: Assets.images.appleHealthKit.image(),
              title: 'Todos os seus dados em um só lugar',
              subtitle:
                  'Sincronizamos seu progresso do treino com seu app Saúde, com ele você gerencia todas as suas atividades em um só lugar',
            ),
            const SizedBox(height: 40),
            _PermissionRow(
              icon: Assets.images.notification.image(),
              title: 'Fique sempre no controle da sua rotina',
              subtitle:
                  'Ative as notificações para receber lembretes de treinos e dicas motivadoras.',
            ),
            const Spacer(flex: 4),
            FButton(
              onPress: isLoading ? null : _requestPermissions,
              prefix: isLoading ? const FButtonSpinner() : null,
              style: FButtonStyle.secondary,
              label: const Text('Permitir'),
            ),
            TextButton(
              onPressed: isLoading ? null : Navigator.of(context).pop,
              style: TextButton.styleFrom(
                foregroundColor: FTheme.of(context).colorScheme.foreground,
                splashFactory: NoSplash.splashFactory,
                overlayColor: Colors.transparent,
              ),
              child: const Text('Me lembre mais tarde'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _PermissionRow extends StatelessWidget {
  const _PermissionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final Widget icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Center(child: icon),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: CommonTextStyle.of(context).subtitleSemiBold,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: CommonTextStyle.of(context).detail.copyWith(
                      height: 1.4,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
