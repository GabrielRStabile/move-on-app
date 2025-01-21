// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/ui/core/assets.gen.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';

@RoutePage()
class PermissionAskingScreen extends StatelessWidget {
  const PermissionAskingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            onPress: () {},
            style: FButtonStyle.secondary,
            label: const Text('Permitir'),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: FTheme.of(context).colorScheme.foreground,
              splashFactory: NoSplash.splashFactory,
              overlayColor: Colors.transparent,
            ),
            child: const Text('Me lembre mais tarde'),
          ),
        ],
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
