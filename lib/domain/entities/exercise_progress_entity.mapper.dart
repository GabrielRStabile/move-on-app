// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'exercise_progress_entity.dart';

class ExerciseStatusMapper extends EnumMapper<ExerciseStatus> {
  ExerciseStatusMapper._();

  static ExerciseStatusMapper? _instance;
  static ExerciseStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExerciseStatusMapper._());
    }
    return _instance!;
  }

  static ExerciseStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ExerciseStatus decode(dynamic value) {
    switch (value) {
      case 'notStarted':
        return ExerciseStatus.notStarted;
      case 'inProgress':
        return ExerciseStatus.inProgress;
      case 'completed':
        return ExerciseStatus.completed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ExerciseStatus self) {
    switch (self) {
      case ExerciseStatus.notStarted:
        return 'notStarted';
      case ExerciseStatus.inProgress:
        return 'inProgress';
      case ExerciseStatus.completed:
        return 'completed';
    }
  }
}

extension ExerciseStatusMapperExtension on ExerciseStatus {
  String toValue() {
    ExerciseStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ExerciseStatus>(this) as String;
  }
}

class ExerciseProgressEntityMapper
    extends ClassMapperBase<ExerciseProgressEntity> {
  ExerciseProgressEntityMapper._();

  static ExerciseProgressEntityMapper? _instance;
  static ExerciseProgressEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExerciseProgressEntityMapper._());
      ExerciseStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExerciseProgressEntity';

  static ExerciseStatus _$status(ExerciseProgressEntity v) => v.status;
  static const Field<ExerciseProgressEntity, ExerciseStatus> _f$status =
      Field('status', _$status);
  static double _$completedPercentage(ExerciseProgressEntity v) =>
      v.completedPercentage;
  static const Field<ExerciseProgressEntity, double> _f$completedPercentage =
      Field('completedPercentage', _$completedPercentage);
  static DateTime _$lastUpdated(ExerciseProgressEntity v) => v.lastUpdated;
  static const Field<ExerciseProgressEntity, DateTime> _f$lastUpdated =
      Field('lastUpdated', _$lastUpdated);

  @override
  final MappableFields<ExerciseProgressEntity> fields = const {
    #status: _f$status,
    #completedPercentage: _f$completedPercentage,
    #lastUpdated: _f$lastUpdated,
  };

  static ExerciseProgressEntity _instantiate(DecodingData data) {
    return ExerciseProgressEntity(
        status: data.dec(_f$status),
        completedPercentage: data.dec(_f$completedPercentage),
        lastUpdated: data.dec(_f$lastUpdated));
  }

  @override
  final Function instantiate = _instantiate;

  static ExerciseProgressEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExerciseProgressEntity>(map);
  }

  static ExerciseProgressEntity fromJson(String json) {
    return ensureInitialized().decodeJson<ExerciseProgressEntity>(json);
  }
}

mixin ExerciseProgressEntityMappable {
  String toJson() {
    return ExerciseProgressEntityMapper.ensureInitialized()
        .encodeJson<ExerciseProgressEntity>(this as ExerciseProgressEntity);
  }

  Map<String, dynamic> toMap() {
    return ExerciseProgressEntityMapper.ensureInitialized()
        .encodeMap<ExerciseProgressEntity>(this as ExerciseProgressEntity);
  }

  ExerciseProgressEntityCopyWith<ExerciseProgressEntity, ExerciseProgressEntity,
          ExerciseProgressEntity>
      get copyWith => _ExerciseProgressEntityCopyWithImpl(
          this as ExerciseProgressEntity, $identity, $identity);
  @override
  String toString() {
    return ExerciseProgressEntityMapper.ensureInitialized()
        .stringifyValue(this as ExerciseProgressEntity);
  }

  @override
  bool operator ==(Object other) {
    return ExerciseProgressEntityMapper.ensureInitialized()
        .equalsValue(this as ExerciseProgressEntity, other);
  }

  @override
  int get hashCode {
    return ExerciseProgressEntityMapper.ensureInitialized()
        .hashValue(this as ExerciseProgressEntity);
  }
}

extension ExerciseProgressEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExerciseProgressEntity, $Out> {
  ExerciseProgressEntityCopyWith<$R, ExerciseProgressEntity, $Out>
      get $asExerciseProgressEntity =>
          $base.as((v, t, t2) => _ExerciseProgressEntityCopyWithImpl(v, t, t2));
}

abstract class ExerciseProgressEntityCopyWith<
    $R,
    $In extends ExerciseProgressEntity,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {ExerciseStatus? status,
      double? completedPercentage,
      DateTime? lastUpdated});
  ExerciseProgressEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ExerciseProgressEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExerciseProgressEntity, $Out>
    implements
        ExerciseProgressEntityCopyWith<$R, ExerciseProgressEntity, $Out> {
  _ExerciseProgressEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExerciseProgressEntity> $mapper =
      ExerciseProgressEntityMapper.ensureInitialized();
  @override
  $R call(
          {ExerciseStatus? status,
          double? completedPercentage,
          DateTime? lastUpdated}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (completedPercentage != null)
          #completedPercentage: completedPercentage,
        if (lastUpdated != null) #lastUpdated: lastUpdated
      }));
  @override
  ExerciseProgressEntity $make(CopyWithData data) => ExerciseProgressEntity(
      status: data.get(#status, or: $value.status),
      completedPercentage:
          data.get(#completedPercentage, or: $value.completedPercentage),
      lastUpdated: data.get(#lastUpdated, or: $value.lastUpdated));

  @override
  ExerciseProgressEntityCopyWith<$R2, ExerciseProgressEntity, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ExerciseProgressEntityCopyWithImpl($value, $cast, t);
}
