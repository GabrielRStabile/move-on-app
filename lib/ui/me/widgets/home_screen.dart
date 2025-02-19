import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/di/dependency_injection.dart';
import 'package:move_on_app/domain/entities/workout_entity.dart';
import 'package:move_on_app/ui/core/common_text_style.dart';
import 'package:move_on_app/ui/me/view_models/home_view_model.dart';
import 'package:move_on_app/ui/me/view_models/search_view_model.dart';
import 'package:move_on_app/ui/me/widgets/task_small.dart';
import 'package:move_on_app/ui/me/widgets/today_tasks_list.dart';
import 'package:move_on_app/ui/me/widgets/workout_carousel_content.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

/// {@template register_screen}
// TODO(GabrielRStabile): - Document this screen.
/// {@endtemplate}
@RoutePage()
class HomeScreen extends StatefulWidget {
  /// {@macro register_screen}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = di.get();
  final SearchViewModel _searchViewModel = di.get();

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);

    final hour = TimeOfDay.now().hour;

    final greeting = switch (hour) {
      < 12 => 'Bom dia',
      < 18 => 'Boa tarde',
      _ => 'Boa noite',
    };

    return SuperScaffold(
      appBar: SuperAppBar(
        height: 30,
        backgroundColor: fTheme.colorScheme.background,
        largeTitle: SuperLargeTitle(
          largeTitle: '$greeting 🔥',
          padding: const EdgeInsets.symmetric(horizontal: 20),
          textStyle: CommonTextStyle.of(context).h2,
        ),
        searchBar: SuperSearchBar(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          placeholderText: 'Buscar treinos',
          onChanged: _searchViewModel.search,
          cancelButtonText: 'Cancelar',
          cancelTextStyle: TextStyle(
            color: fTheme.colorScheme.foreground,
          ),
          searchResult: ListenableBuilder(
            listenable: _searchViewModel,
            builder: (_, __) {
              return ListView.separated(
                itemCount: _searchViewModel.searchResults.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, index) {
                  final exercise = _searchViewModel.searchResults[index];

                  return TaskSmall(exercise: exercise);
                },
              );
            },
          ),
        ),
      ),
      body: SoftEdgeBlur(
        edges: [
          EdgeBlur(
            type: EdgeType.bottomEdge,
            size: 100,
            sigma: 20,
            controlPoints: [
              ControlPoint(position: 0.8, type: ControlPointType.visible),
              ControlPoint(position: 1, type: ControlPointType.transparent),
            ],
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListenableBuilder(
              listenable: _viewModel,
              builder: (_, child) {
                if (_viewModel.hasError) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.exclamationmark_triangle_fill,
                          size: 60,
                          color: FTheme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Erro ao carregar as tarefas do dia',
                          style: CommonTextStyle.of(context).large,
                        ),
                        CupertinoButton(
                          onPressed: _viewModel.loadWorkouts,
                          child: Text(
                            'Clique aqui para tentar novamente',
                            style: CommonTextStyle.of(context).detail,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                      'Exercícios populares',
                      style: CommonTextStyle.of(context).large,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 230),
                      child: CarouselView(
                        itemSnapping: true,
                        enableSplash: false,
                        itemExtent: MediaQuery.sizeOf(context).width * 0.85,
                        children: _viewModel.popularWorkouts
                            .map(
                              (workout) =>
                                  WorkoutCarouselContent(workout: workout),
                            )
                            .toList(),
                      ),
                    ),
                    TodayTasksList(
                      workout:
                          _viewModel.todayWorkout ?? WorkoutEntityDummy.dummy(),
                      isLoading: _viewModel.isLoading,
                    ),
                    const SizedBox(height: 80),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
