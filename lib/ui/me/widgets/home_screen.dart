import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

/// {@template register_screen}
// TODO(GabrielRStabile): - Document this screen.
/// {@endtemplate}
@RoutePage()
class HomeScreen extends StatelessWidget {
  /// {@macro register_screen}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);

    return SuperScaffold(
      appBar: SuperAppBar(
        height: 30,
        backgroundColor: fTheme.colorScheme.background,
        largeTitle: SuperLargeTitle(
          largeTitle: 'Bom dia 🔥',
          padding: const EdgeInsets.symmetric(horizontal: 20),
          textStyle: FTheme.of(context).typography.xl3.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        searchBar: SuperSearchBar(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          placeholderText: 'Buscar treinos',
          cancelButtonText: 'Cancelar',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.network(
              'https://picsum.photos/200/300',
              width: 200,
              height: 300,
            ),
            Image.network(
              'https://picsum.photos/200/300',
              width: 200,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
