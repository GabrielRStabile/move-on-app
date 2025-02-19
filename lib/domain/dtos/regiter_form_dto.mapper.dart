// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'regiter_form_dto.dart';

class GenderMapper extends EnumMapper<Gender> {
  GenderMapper._();

  static GenderMapper? _instance;
  static GenderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GenderMapper._());
    }
    return _instance!;
  }

  static Gender fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Gender decode(dynamic value) {
    switch (value) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'other':
        return Gender.other;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Gender self) {
    switch (self) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      case Gender.other:
        return 'other';
    }
  }
}

extension GenderMapperExtension on Gender {
  String toValue() {
    GenderMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Gender>(this) as String;
  }
}

class GoalMapper extends EnumMapper<Goal> {
  GoalMapper._();

  static GoalMapper? _instance;
  static GoalMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GoalMapper._());
    }
    return _instance!;
  }

  static Goal fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Goal decode(dynamic value) {
    switch (value) {
      case 'loseWeight':
        return Goal.loseWeight;
      case 'gainWeight':
        return Goal.gainWeight;
      case 'gainMuscle':
        return Goal.gainMuscle;
      case 'reduceStress':
        return Goal.reduceStress;
      case 'improveHealth':
        return Goal.improveHealth;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Goal self) {
    switch (self) {
      case Goal.loseWeight:
        return 'loseWeight';
      case Goal.gainWeight:
        return 'gainWeight';
      case Goal.gainMuscle:
        return 'gainMuscle';
      case Goal.reduceStress:
        return 'reduceStress';
      case Goal.improveHealth:
        return 'improveHealth';
    }
  }
}

extension GoalMapperExtension on Goal {
  String toValue() {
    GoalMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Goal>(this) as String;
  }
}

class ActiveLevelMapper extends EnumMapper<ActiveLevel> {
  ActiveLevelMapper._();

  static ActiveLevelMapper? _instance;
  static ActiveLevelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ActiveLevelMapper._());
    }
    return _instance!;
  }

  static ActiveLevel fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ActiveLevel decode(dynamic value) {
    switch (value) {
      case 'sedentary':
        return ActiveLevel.sedentary;
      case 'lightlyActive':
        return ActiveLevel.lightlyActive;
      case 'veryActive':
        return ActiveLevel.veryActive;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ActiveLevel self) {
    switch (self) {
      case ActiveLevel.sedentary:
        return 'sedentary';
      case ActiveLevel.lightlyActive:
        return 'lightlyActive';
      case ActiveLevel.veryActive:
        return 'veryActive';
    }
  }
}

extension ActiveLevelMapperExtension on ActiveLevel {
  String toValue() {
    ActiveLevelMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ActiveLevel>(this) as String;
  }
}

class RegisterFormDTOMapper extends ClassMapperBase<RegisterFormDTO> {
  RegisterFormDTOMapper._();

  static RegisterFormDTOMapper? _instance;
  static RegisterFormDTOMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegisterFormDTOMapper._());
      GenderMapper.ensureInitialized();
      GoalMapper.ensureInitialized();
      ActiveLevelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RegisterFormDTO';

  static String? _$name(RegisterFormDTO v) => v.name;
  static const Field<RegisterFormDTO, String> _f$name =
      Field('name', _$name, opt: true);
  static int? _$age(RegisterFormDTO v) => v.age;
  static const Field<RegisterFormDTO, int> _f$age =
      Field('age', _$age, opt: true);
  static Gender? _$gender(RegisterFormDTO v) => v.gender;
  static const Field<RegisterFormDTO, Gender> _f$gender =
      Field('gender', _$gender, opt: true);
  static List<Goal>? _$goal(RegisterFormDTO v) => v.goal;
  static const Field<RegisterFormDTO, List<Goal>> _f$goal =
      Field('goal', _$goal, opt: true);
  static int? _$weight(RegisterFormDTO v) => v.weight;
  static const Field<RegisterFormDTO, int> _f$weight =
      Field('weight', _$weight, opt: true);
  static int? _$height(RegisterFormDTO v) => v.height;
  static const Field<RegisterFormDTO, int> _f$height =
      Field('height', _$height, opt: true);
  static ActiveLevel? _$activeLevel(RegisterFormDTO v) => v.activeLevel;
  static const Field<RegisterFormDTO, ActiveLevel> _f$activeLevel =
      Field('activeLevel', _$activeLevel, opt: true);

  @override
  final MappableFields<RegisterFormDTO> fields = const {
    #name: _f$name,
    #age: _f$age,
    #gender: _f$gender,
    #goal: _f$goal,
    #weight: _f$weight,
    #height: _f$height,
    #activeLevel: _f$activeLevel,
  };

  static RegisterFormDTO _instantiate(DecodingData data) {
    return RegisterFormDTO(
        name: data.dec(_f$name),
        age: data.dec(_f$age),
        gender: data.dec(_f$gender),
        goal: data.dec(_f$goal),
        weight: data.dec(_f$weight),
        height: data.dec(_f$height),
        activeLevel: data.dec(_f$activeLevel));
  }

  @override
  final Function instantiate = _instantiate;

  static RegisterFormDTO fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegisterFormDTO>(map);
  }

  static RegisterFormDTO fromJson(String json) {
    return ensureInitialized().decodeJson<RegisterFormDTO>(json);
  }
}

mixin RegisterFormDTOMappable {
  String toJson() {
    return RegisterFormDTOMapper.ensureInitialized()
        .encodeJson<RegisterFormDTO>(this as RegisterFormDTO);
  }

  Map<String, dynamic> toMap() {
    return RegisterFormDTOMapper.ensureInitialized()
        .encodeMap<RegisterFormDTO>(this as RegisterFormDTO);
  }

  RegisterFormDTOCopyWith<RegisterFormDTO, RegisterFormDTO, RegisterFormDTO>
      get copyWith => _RegisterFormDTOCopyWithImpl(
          this as RegisterFormDTO, $identity, $identity);
  @override
  String toString() {
    return RegisterFormDTOMapper.ensureInitialized()
        .stringifyValue(this as RegisterFormDTO);
  }

  @override
  bool operator ==(Object other) {
    return RegisterFormDTOMapper.ensureInitialized()
        .equalsValue(this as RegisterFormDTO, other);
  }

  @override
  int get hashCode {
    return RegisterFormDTOMapper.ensureInitialized()
        .hashValue(this as RegisterFormDTO);
  }
}

extension RegisterFormDTOValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegisterFormDTO, $Out> {
  RegisterFormDTOCopyWith<$R, RegisterFormDTO, $Out> get $asRegisterFormDTO =>
      $base.as((v, t, t2) => _RegisterFormDTOCopyWithImpl(v, t, t2));
}

abstract class RegisterFormDTOCopyWith<$R, $In extends RegisterFormDTO, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Goal, ObjectCopyWith<$R, Goal, Goal>>? get goal;
  $R call(
      {String? name,
      int? age,
      Gender? gender,
      List<Goal>? goal,
      int? weight,
      int? height,
      ActiveLevel? activeLevel});
  RegisterFormDTOCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RegisterFormDTOCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegisterFormDTO, $Out>
    implements RegisterFormDTOCopyWith<$R, RegisterFormDTO, $Out> {
  _RegisterFormDTOCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegisterFormDTO> $mapper =
      RegisterFormDTOMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Goal, ObjectCopyWith<$R, Goal, Goal>>? get goal =>
      $value.goal != null
          ? ListCopyWith($value.goal!,
              (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(goal: v))
          : null;
  @override
  $R call(
          {Object? name = $none,
          Object? age = $none,
          Object? gender = $none,
          Object? goal = $none,
          Object? weight = $none,
          Object? height = $none,
          Object? activeLevel = $none}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (age != $none) #age: age,
        if (gender != $none) #gender: gender,
        if (goal != $none) #goal: goal,
        if (weight != $none) #weight: weight,
        if (height != $none) #height: height,
        if (activeLevel != $none) #activeLevel: activeLevel
      }));
  @override
  RegisterFormDTO $make(CopyWithData data) => RegisterFormDTO(
      name: data.get(#name, or: $value.name),
      age: data.get(#age, or: $value.age),
      gender: data.get(#gender, or: $value.gender),
      goal: data.get(#goal, or: $value.goal),
      weight: data.get(#weight, or: $value.weight),
      height: data.get(#height, or: $value.height),
      activeLevel: data.get(#activeLevel, or: $value.activeLevel));

  @override
  RegisterFormDTOCopyWith<$R2, RegisterFormDTO, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RegisterFormDTOCopyWithImpl($value, $cast, t);
}
