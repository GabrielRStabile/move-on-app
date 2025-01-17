// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'workout_entity.dart';

class ExerciseDifficultyMapper extends EnumMapper<ExerciseDifficulty> {
  ExerciseDifficultyMapper._();

  static ExerciseDifficultyMapper? _instance;
  static ExerciseDifficultyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExerciseDifficultyMapper._());
    }
    return _instance!;
  }

  static ExerciseDifficulty fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ExerciseDifficulty decode(dynamic value) {
    switch (value) {
      case 'easy':
        return ExerciseDifficulty.easy;
      case 'medium':
        return ExerciseDifficulty.medium;
      case 'hard':
        return ExerciseDifficulty.hard;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ExerciseDifficulty self) {
    switch (self) {
      case ExerciseDifficulty.easy:
        return 'easy';
      case ExerciseDifficulty.medium:
        return 'medium';
      case ExerciseDifficulty.hard:
        return 'hard';
    }
  }
}

extension ExerciseDifficultyMapperExtension on ExerciseDifficulty {
  String toValue() {
    ExerciseDifficultyMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ExerciseDifficulty>(this) as String;
  }
}

class WorkoutEntityMapper extends ClassMapperBase<WorkoutEntity> {
  WorkoutEntityMapper._();

  static WorkoutEntityMapper? _instance;
  static WorkoutEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorkoutEntityMapper._());
      ExerciseEntityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WorkoutEntity';

  static String _$id(WorkoutEntity v) => v.id;
  static const Field<WorkoutEntity, String> _f$id = Field('id', _$id);
  static String _$name(WorkoutEntity v) => v.name;
  static const Field<WorkoutEntity, String> _f$name = Field('name', _$name);
  static String _$description(WorkoutEntity v) => v.description;
  static const Field<WorkoutEntity, String> _f$description =
      Field('description', _$description);
  static String _$image(WorkoutEntity v) => v.image;
  static const Field<WorkoutEntity, String> _f$image = Field('image', _$image);
  static int _$rounds(WorkoutEntity v) => v.rounds;
  static const Field<WorkoutEntity, int> _f$rounds = Field('rounds', _$rounds);
  static List<ExerciseEntity> _$exercises(WorkoutEntity v) => v.exercises;
  static const Field<WorkoutEntity, List<ExerciseEntity>> _f$exercises =
      Field('exercises', _$exercises, opt: true, def: const []);

  @override
  final MappableFields<WorkoutEntity> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #image: _f$image,
    #rounds: _f$rounds,
    #exercises: _f$exercises,
  };

  static WorkoutEntity _instantiate(DecodingData data) {
    return WorkoutEntity(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        image: data.dec(_f$image),
        rounds: data.dec(_f$rounds),
        exercises: data.dec(_f$exercises));
  }

  @override
  final Function instantiate = _instantiate;

  static WorkoutEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorkoutEntity>(map);
  }

  static WorkoutEntity fromJson(String json) {
    return ensureInitialized().decodeJson<WorkoutEntity>(json);
  }
}

mixin WorkoutEntityMappable {
  String toJson() {
    return WorkoutEntityMapper.ensureInitialized()
        .encodeJson<WorkoutEntity>(this as WorkoutEntity);
  }

  Map<String, dynamic> toMap() {
    return WorkoutEntityMapper.ensureInitialized()
        .encodeMap<WorkoutEntity>(this as WorkoutEntity);
  }

  WorkoutEntityCopyWith<WorkoutEntity, WorkoutEntity, WorkoutEntity>
      get copyWith => _WorkoutEntityCopyWithImpl(
          this as WorkoutEntity, $identity, $identity);
  @override
  String toString() {
    return WorkoutEntityMapper.ensureInitialized()
        .stringifyValue(this as WorkoutEntity);
  }

  @override
  bool operator ==(Object other) {
    return WorkoutEntityMapper.ensureInitialized()
        .equalsValue(this as WorkoutEntity, other);
  }

  @override
  int get hashCode {
    return WorkoutEntityMapper.ensureInitialized()
        .hashValue(this as WorkoutEntity);
  }
}

extension WorkoutEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WorkoutEntity, $Out> {
  WorkoutEntityCopyWith<$R, WorkoutEntity, $Out> get $asWorkoutEntity =>
      $base.as((v, t, t2) => _WorkoutEntityCopyWithImpl(v, t, t2));
}

abstract class WorkoutEntityCopyWith<$R, $In extends WorkoutEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ExerciseEntity,
      ExerciseEntityCopyWith<$R, ExerciseEntity, ExerciseEntity>> get exercises;
  $R call(
      {String? id,
      String? name,
      String? description,
      String? image,
      int? rounds,
      List<ExerciseEntity>? exercises});
  WorkoutEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WorkoutEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WorkoutEntity, $Out>
    implements WorkoutEntityCopyWith<$R, WorkoutEntity, $Out> {
  _WorkoutEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WorkoutEntity> $mapper =
      WorkoutEntityMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ExerciseEntity,
          ExerciseEntityCopyWith<$R, ExerciseEntity, ExerciseEntity>>
      get exercises => ListCopyWith($value.exercises,
          (v, t) => v.copyWith.$chain(t), (v) => call(exercises: v));
  @override
  $R call(
          {String? id,
          String? name,
          String? description,
          String? image,
          int? rounds,
          List<ExerciseEntity>? exercises}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (image != null) #image: image,
        if (rounds != null) #rounds: rounds,
        if (exercises != null) #exercises: exercises
      }));
  @override
  WorkoutEntity $make(CopyWithData data) => WorkoutEntity(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      image: data.get(#image, or: $value.image),
      rounds: data.get(#rounds, or: $value.rounds),
      exercises: data.get(#exercises, or: $value.exercises));

  @override
  WorkoutEntityCopyWith<$R2, WorkoutEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WorkoutEntityCopyWithImpl($value, $cast, t);
}
