import 'package:dart_mappable/dart_mappable.dart';

/// Maps a [Duration] object to and from JSON
class DurationMapper extends SimpleMapper<Duration> {
  /// Creates a new duration mapper
  const DurationMapper();

  @override
  Duration decode(Object value) {
    if (value is int) {
      return Duration(milliseconds: value);
    } else {
      throw Exception('Cannot decode $value to Duration');
    }
  }

  @override
  Object? encode(Duration self) {
    return self.inMilliseconds;
  }
}
