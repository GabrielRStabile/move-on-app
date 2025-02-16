import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/routing/router.gr.dart';
import 'package:move_on_app/ui/me/widgets/app_bottom_bar.dart';
import 'package:pull_down_button/pull_down_button.dart';

/// The main screen showing user-related content with bottom navigation.
@RoutePage()
class MeScreen extends StatefulWidget {
  /// Creates the me screen widget.
  const MeScreen({super.key});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  /// Key used to position the user profile menu
  final userProfileKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);

    return AutoTabsScaffold(
      extendBody: true,
      backgroundColor: fTheme.colorScheme.background,
      routes: const [
        HomeRoute(),
        ExploreRoute(),
        ProgressRoute(),
      ],
      resizeToAvoidBottomInset: false,
      bottomNavigationBuilder: (context, tabsRouter) => AppBottomBar(
        selectedColorOpacity: 1,
        currentIndex: tabsRouter.activeIndex,
        onTap: (index) {
          if (index == 3) {
            final renderBox =
                userProfileKey.currentContext!.findRenderObject()! as RenderBox;
            final position = renderBox.localToGlobal(Offset.zero);

            showPullDownMenu(
              context: context,
              items: [
                PullDownMenuHeader(
                  leading: const ColoredBox(color: Colors.red),
                  title: 'Gabriel Stabile',
                  subtitle: '3 dias treinando 🚀',
                  onTap: () {},
                ),
                const PullDownMenuDivider.large(),
                PullDownMenuItem(
                  isDestructive: true,
                  title: 'Sair',
                  onTap: () {},
                  icon: CupertinoIcons.power,
                ),
              ],
              position: Rect.fromLTWH(
                position.dx,
                position.dy - 20,
                renderBox.size.width,
                renderBox.size.height,
              ),
            );
            return;
          }

          tabsRouter.setActiveIndex(index);
        },
        backgroundColor: fTheme.colorScheme.foreground.withValues(alpha: 0.9),
        selectedItemColor: fTheme.colorScheme.primaryForeground,
        selectedItemBackgroundColor: fTheme.colorScheme.primary,
        unselectedItemColor: FThemes.zinc.light.colorScheme.primaryForeground,
        items: [
          AppBottomBarItem(
            icon: FIcon(FAssets.icons.house),
            title: const Text('Início'),
          ),
          AppBottomBarItem(
            icon: FIcon(FAssets.icons.rocket),
            title: const Text('Explorar'),
          ),
          AppBottomBarItem(
            icon: FIcon(FAssets.icons.gauge),
            title: const Text('Progresso'),
          ),
          AppBottomBarItem(
            icon: FIcon(
              key: userProfileKey,
              FAssets.icons.user,
            ),
            title: const Text('Eu'),
          ),
        ],
      ),
    );
  }
}
