// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'exercise_entity.dart';

class ExerciseEntityMapper extends ClassMapperBase<ExerciseEntity> {
  ExerciseEntityMapper._();

  static ExerciseEntityMapper? _instance;
  static ExerciseEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExerciseEntityMapper._());
      MapperContainer.globals.useAll([DurationMapper()]);
      ExerciseDifficultyMapper.ensureInitialized();
      VideoEntityMapper.ensureInitialized();
      ExerciseProgressEntityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExerciseEntity';

  static String _$id(ExerciseEntity v) => v.id;
  static const Field<ExerciseEntity, String> _f$id = Field('id', _$id);
  static String _$name(ExerciseEntity v) => v.name;
  static const Field<ExerciseEntity, String> _f$name =
      Field('name', _$name, key: r'title');
  static String _$description(ExerciseEntity v) => v.description;
  static const Field<ExerciseEntity, String> _f$description =
      Field('description', _$description);
  static String _$image(ExerciseEntity v) => v.image;
  static const Field<ExerciseEntity, String> _f$image =
      Field('image', _$image, key: r'thumb_url');
  static ExerciseDifficulty _$difficulty(ExerciseEntity v) => v.difficulty;
  static const Field<ExerciseEntity, ExerciseDifficulty> _f$difficulty =
      Field('difficulty', _$difficulty, key: r'level');
  static int _$kcal(ExerciseEntity v) => v.kcal;
  static const Field<ExerciseEntity, int> _f$kcal =
      Field('kcal', _$kcal, key: r'calories');
  static Duration _$duration(ExerciseEntity v) => v.duration;
  static const Field<ExerciseEntity, Duration> _f$duration =
      Field('duration', _$duration);
  static List<String> _$categories(ExerciseEntity v) => v.categories;
  static const Field<ExerciseEntity, List<String>> _f$categories =
      Field('categories', _$categories, opt: true, def: const []);
  static String? _$imageHash(ExerciseEntity v) => v.imageHash;
  static const Field<ExerciseEntity, String> _f$imageHash =
      Field('imageHash', _$imageHash, key: r'blur_hash', opt: true);
  static VideoEntity? _$video(ExerciseEntity v) => v.video;
  static const Field<ExerciseEntity, VideoEntity> _f$video =
      Field('video', _$video, opt: true);
  static ExerciseProgressEntity? _$progress(ExerciseEntity v) => v.progress;
  static const Field<ExerciseEntity, ExerciseProgressEntity> _f$progress =
      Field('progress', _$progress, opt: true);

  @override
  final MappableFields<ExerciseEntity> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #image: _f$image,
    #difficulty: _f$difficulty,
    #kcal: _f$kcal,
    #duration: _f$duration,
    #categories: _f$categories,
    #imageHash: _f$imageHash,
    #video: _f$video,
    #progress: _f$progress,
  };

  static ExerciseEntity _instantiate(DecodingData data) {
    return ExerciseEntity(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        image: data.dec(_f$image),
        difficulty: data.dec(_f$difficulty),
        kcal: data.dec(_f$kcal),
        duration: data.dec(_f$duration),
        categories: data.dec(_f$categories),
        imageHash: data.dec(_f$imageHash),
        video: data.dec(_f$video),
        progress: data.dec(_f$progress));
  }

  @override
  final Function instantiate = _instantiate;

  static ExerciseEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExerciseEntity>(map);
  }

  static ExerciseEntity fromJson(String json) {
    return ensureInitialized().decodeJson<ExerciseEntity>(json);
  }
}

mixin ExerciseEntityMappable {
  String toJson() {
    return ExerciseEntityMapper.ensureInitialized()
        .encodeJson<ExerciseEntity>(this as ExerciseEntity);
  }

  Map<String, dynamic> toMap() {
    return ExerciseEntityMapper.ensureInitialized()
        .encodeMap<ExerciseEntity>(this as ExerciseEntity);
  }

  ExerciseEntityCopyWith<ExerciseEntity, ExerciseEntity, ExerciseEntity>
      get copyWith => _ExerciseEntityCopyWithImpl(
          this as ExerciseEntity, $identity, $identity);
  @override
  String toString() {
    return ExerciseEntityMapper.ensureInitialized()
        .stringifyValue(this as ExerciseEntity);
  }

  @override
  bool operator ==(Object other) {
    return ExerciseEntityMapper.ensureInitialized()
        .equalsValue(this as ExerciseEntity, other);
  }

  @override
  int get hashCode {
    return ExerciseEntityMapper.ensureInitialized()
        .hashValue(this as ExerciseEntity);
  }
}

extension ExerciseEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExerciseEntity, $Out> {
  ExerciseEntityCopyWith<$R, ExerciseEntity, $Out> get $asExerciseEntity =>
      $base.as((v, t, t2) => _ExerciseEntityCopyWithImpl(v, t, t2));
}

abstract class ExerciseEntityCopyWith<$R, $In extends ExerciseEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get categories;
  VideoEntityCopyWith<$R, VideoEntity, VideoEntity>? get video;
  ExerciseProgressEntityCopyWith<$R, ExerciseProgressEntity,
      ExerciseProgressEntity>? get progress;
  $R call(
      {String? id,
      String? name,
      String? description,
      String? image,
      ExerciseDifficulty? difficulty,
      int? kcal,
      Duration? duration,
      List<String>? categories,
      String? imageHash,
      VideoEntity? video,
      ExerciseProgressEntity? progress});
  ExerciseEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ExerciseEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExerciseEntity, $Out>
    implements ExerciseEntityCopyWith<$R, ExerciseEntity, $Out> {
  _ExerciseEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExerciseEntity> $mapper =
      ExerciseEntityMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get categories =>
      ListCopyWith($value.categories, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(categories: v));
  @override
  VideoEntityCopyWith<$R, VideoEntity, VideoEntity>? get video =>
      $value.video?.copyWith.$chain((v) => call(video: v));
  @override
  ExerciseProgressEntityCopyWith<$R, ExerciseProgressEntity,
          ExerciseProgressEntity>?
      get progress =>
          $value.progress?.copyWith.$chain((v) => call(progress: v));
  @override
  $R call(
          {String? id,
          String? name,
          String? description,
          String? image,
          ExerciseDifficulty? difficulty,
          int? kcal,
          Duration? duration,
          List<String>? categories,
          Object? imageHash = $none,
          Object? video = $none,
          Object? progress = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (image != null) #image: image,
        if (difficulty != null) #difficulty: difficulty,
        if (kcal != null) #kcal: kcal,
        if (duration != null) #duration: duration,
        if (categories != null) #categories: categories,
        if (imageHash != $none) #imageHash: imageHash,
        if (video != $none) #video: video,
        if (progress != $none) #progress: progress
      }));
  @override
  ExerciseEntity $make(CopyWithData data) => ExerciseEntity(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      image: data.get(#image, or: $value.image),
      difficulty: data.get(#difficulty, or: $value.difficulty),
      kcal: data.get(#kcal, or: $value.kcal),
      duration: data.get(#duration, or: $value.duration),
      categories: data.get(#categories, or: $value.categories),
      imageHash: data.get(#imageHash, or: $value.imageHash),
      video: data.get(#video, or: $value.video),
      progress: data.get(#progress, or: $value.progress));

  @override
  ExerciseEntityCopyWith<$R2, ExerciseEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ExerciseEntityCopyWithImpl($value, $cast, t);
}
