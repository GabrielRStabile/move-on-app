// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'video_entity.dart';

class VideoFormatMapper extends EnumMapper<VideoFormat> {
  VideoFormatMapper._();

  static VideoFormatMapper? _instance;
  static VideoFormatMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VideoFormatMapper._());
    }
    return _instance!;
  }

  static VideoFormat fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  VideoFormat decode(dynamic value) {
    switch (value) {
      case 'mp4':
        return VideoFormat.mp4;
      case 'hls':
        return VideoFormat.hls;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(VideoFormat self) {
    switch (self) {
      case VideoFormat.mp4:
        return 'mp4';
      case VideoFormat.hls:
        return 'hls';
    }
  }
}

extension VideoFormatMapperExtension on VideoFormat {
  String toValue() {
    VideoFormatMapper.ensureInitialized();
    return MapperContainer.globals.toValue<VideoFormat>(this) as String;
  }
}

class VideoEntityMapper extends ClassMapperBase<VideoEntity> {
  VideoEntityMapper._();

  static VideoEntityMapper? _instance;
  static VideoEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VideoEntityMapper._());
      VideoFormatMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VideoEntity';

  static String _$url(VideoEntity v) => v.url;
  static const Field<VideoEntity, String> _f$url = Field('url', _$url);
  static VideoFormat _$format(VideoEntity v) => v.format;
  static const Field<VideoEntity, VideoFormat> _f$format =
      Field('format', _$format);

  @override
  final MappableFields<VideoEntity> fields = const {
    #url: _f$url,
    #format: _f$format,
  };

  static VideoEntity _instantiate(DecodingData data) {
    return VideoEntity(url: data.dec(_f$url), format: data.dec(_f$format));
  }

  @override
  final Function instantiate = _instantiate;

  static VideoEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VideoEntity>(map);
  }

  static VideoEntity fromJson(String json) {
    return ensureInitialized().decodeJson<VideoEntity>(json);
  }
}

mixin VideoEntityMappable {
  String toJson() {
    return VideoEntityMapper.ensureInitialized()
        .encodeJson<VideoEntity>(this as VideoEntity);
  }

  Map<String, dynamic> toMap() {
    return VideoEntityMapper.ensureInitialized()
        .encodeMap<VideoEntity>(this as VideoEntity);
  }

  VideoEntityCopyWith<VideoEntity, VideoEntity, VideoEntity> get copyWith =>
      _VideoEntityCopyWithImpl(this as VideoEntity, $identity, $identity);
  @override
  String toString() {
    return VideoEntityMapper.ensureInitialized()
        .stringifyValue(this as VideoEntity);
  }

  @override
  bool operator ==(Object other) {
    return VideoEntityMapper.ensureInitialized()
        .equalsValue(this as VideoEntity, other);
  }

  @override
  int get hashCode {
    return VideoEntityMapper.ensureInitialized().hashValue(this as VideoEntity);
  }
}

extension VideoEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VideoEntity, $Out> {
  VideoEntityCopyWith<$R, VideoEntity, $Out> get $asVideoEntity =>
      $base.as((v, t, t2) => _VideoEntityCopyWithImpl(v, t, t2));
}

abstract class VideoEntityCopyWith<$R, $In extends VideoEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? url, VideoFormat? format});
  VideoEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VideoEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VideoEntity, $Out>
    implements VideoEntityCopyWith<$R, VideoEntity, $Out> {
  _VideoEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VideoEntity> $mapper =
      VideoEntityMapper.ensureInitialized();
  @override
  $R call({String? url, VideoFormat? format}) => $apply(FieldCopyWithData(
      {if (url != null) #url: url, if (format != null) #format: format}));
  @override
  VideoEntity $make(CopyWithData data) => VideoEntity(
      url: data.get(#url, or: $value.url),
      format: data.get(#format, or: $value.format));

  @override
  VideoEntityCopyWith<$R2, VideoEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _VideoEntityCopyWithImpl($value, $cast, t);
}
