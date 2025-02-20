import 'package:dart_mappable/dart_mappable.dart';
import 'package:forui/forui.dart';
import 'package:move_on_app/ui/core/assets.gen.dart';

part 'register_form_dto.mapper.dart';

@MappableEnum()
enum Gender {
  male(friendlyName: 'masculino'),
  female(friendlyName: 'feminino'),
  other(friendlyName: 'outro');

  const Gender({required this.friendlyName});

  final String friendlyName;

  String get icon {
    switch (this) {
      case Gender.male:
        return Assets.icons.genderMale.path;
      case Gender.female:
        return Assets.icons.genderFemale.path;
      case Gender.other:
        return Assets.icons.genderOther.path;
    }
  }
}

@MappableEnum()
enum Goal {
  loseWeight(friendlyName: 'Perder peso'),
  gainWeight(friendlyName: 'Ganhar peso'),
  gainMuscle(friendlyName: 'Ganhar massa muscular'),
  reduceStress(friendlyName: 'Reduzir estresse'),
  improveHealth(friendlyName: 'Melhorar saúde');

  const Goal({required this.friendlyName});

  final String friendlyName;

  SvgAsset get icon {
    switch (this) {
      case Goal.loseWeight:
      case Goal.gainWeight:
        return FAssets.icons.scale;
      case Goal.gainMuscle:
        return FAssets.icons.dumbbell;
      case Goal.reduceStress:
        return FAssets.icons.brain;
      case Goal.improveHealth:
        return FAssets.icons.heart;
    }
  }
}

@MappableEnum()
enum ActiveLevel {
  sedentary(
    friendlyName: 'Sedentário',
  ),
  lightlyActive(friendlyName: 'Levemente ativo'),
  veryActive(friendlyName: 'Muito ativo');

  const ActiveLevel({
    required this.friendlyName,
  });

  final String friendlyName;

  String get icon {
    switch (this) {
      case ActiveLevel.sedentary:
        return Assets.icons.activeLevelLow.path;
      case ActiveLevel.lightlyActive:
        return Assets.icons.activeLevelMediun.path;
      case ActiveLevel.veryActive:
        return Assets.icons.activeLevelHigt.path;
    }
  }
}

@MappableClass()
class RegisterFormDTO with RegisterFormDTOMappable {
  RegisterFormDTO({
    this.name,
    this.age,
    this.gender,
    this.goal,
    this.weight,
    this.height,
    this.activeLevel,
  });
  String? name;
  int? age;
  Gender? gender;
  int? weight;
  int? height;
  List<Goal>? goal;
  ActiveLevel? activeLevel;

  /// Factory methods for creating RegisterFormDTO from different sources
  static const fromMap = RegisterFormDTOMapper.fromMap;

  /// Factory methods for creating RegisterFormDTO from JSON
  static const fromJson = RegisterFormDTOMapper.fromJson;
}
