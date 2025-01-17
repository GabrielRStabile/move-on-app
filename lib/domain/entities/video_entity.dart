import 'package:dart_mappable/dart_mappable.dart';

part 'video_entity.mapper.dart';

/// Represents the available video formats
@MappableEnum(mode: ValuesMode.named)
enum VideoFormat {
  /// MP4 format - common video format
  mp4,

  /// HLS format - streaming format
  hls,
}

/// Represents a video resource for exercises
@MappableClass()
class VideoEntity with VideoEntityMappable {
  /// Creates a new video entity
  ///
  /// [url] URL for the video resource
  /// [format] Format of the video (MP4 or HLS)
  VideoEntity({
    required this.url,
    required this.format,
  });

  /// URL to access the video
  final String url;

  /// Format of the video
  final VideoFormat format;

  /// Factory methods for creating VideoEntity from different sources
  static const fromMap = VideoEntityMapper.fromMap;

  /// Factory methods for creating VideoEntity from JSON
  static const fromJson = VideoEntityMapper.fromJson;
}

/// Extension methods for creating dummy VideoEntity instances
extension VideoEntityDummy on VideoEntity {
  /// Creates a single dummy video
  static VideoEntity dummy({VideoFormat format = VideoFormat.mp4}) =>
      VideoEntity(
        url: format == VideoFormat.mp4
            ? 'https://example.com/video.mp4'
            : 'https://example.com/video/playlist.m3u8',
        format: format,
      );
}
