import 'package:move_on_app/data/services/client_http.dart';
import 'package:move_on_app/domain/entities/workout_entity.dart';
import 'package:result_dart/result_dart.dart';

/// HTTP client specifically for workout-related API calls
class WorkoutClientHttp {
  /// Creates a workout HTTP client with optional custom client
  WorkoutClientHttp({ClientHttp? client}) : _client = client ?? ClientHttp();

  late final ClientHttp _client;

  /// Fetches all workouts from the remote API
  AsyncResult<List<WorkoutEntity>> getAllWorkouts() async {
    final response = await _client.get<List<dynamic>>(
      'https://storage.googleapis.com/utfpr/pai-move-on-app/treinos/tasks.json',
    );

    return response.fold(
      (response) => Success(
        response.data
                ?.map<WorkoutEntity>(
                  (json) => WorkoutEntity.fromMap(json as Map<String, dynamic>),
                )
                .toList() ??
            [],
      ),
      Failure.new,
    );
  }
}
