// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CommandmentsTableTable extends CommandmentsTable
    with TableInfo<$CommandmentsTableTable, CommandmentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommandmentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      '_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
      'NUMBER', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _commandmentTextMeta =
      const VerificationMeta('commandmentText');
  @override
  late final GeneratedColumn<String> commandmentText = GeneratedColumn<String>(
      'TEXT', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'CATEGORY', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commandmentMeta =
      const VerificationMeta('commandment');
  @override
  late final GeneratedColumn<String> commandment = GeneratedColumn<String>(
      'COMMANDMENT', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customIdMeta =
      const VerificationMeta('customId');
  @override
  late final GeneratedColumn<int> customId = GeneratedColumn<int>(
      'CUSTOM_ID', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, number, commandmentText, category, commandment, customId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'COMMANDMENTS';
  @override
  VerificationContext validateIntegrity(
      Insertable<CommandmentsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('_id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['_id']!, _idMeta));
    }
    if (data.containsKey('NUMBER')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['NUMBER']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('TEXT')) {
      context.handle(
          _commandmentTextMeta,
          commandmentText.isAcceptableOrUnknown(
              data['TEXT']!, _commandmentTextMeta));
    } else if (isInserting) {
      context.missing(_commandmentTextMeta);
    }
    if (data.containsKey('CATEGORY')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['CATEGORY']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('COMMANDMENT')) {
      context.handle(
          _commandmentMeta,
          commandment.isAcceptableOrUnknown(
              data['COMMANDMENT']!, _commandmentMeta));
    } else if (isInserting) {
      context.missing(_commandmentMeta);
    }
    if (data.containsKey('CUSTOM_ID')) {
      context.handle(_customIdMeta,
          customId.isAcceptableOrUnknown(data['CUSTOM_ID']!, _customIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommandmentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommandmentsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}_id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}NUMBER'])!,
      commandmentText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}TEXT'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}CATEGORY'])!,
      commandment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}COMMANDMENT'])!,
      customId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}CUSTOM_ID']),
    );
  }

  @override
  $CommandmentsTableTable createAlias(String alias) {
    return $CommandmentsTableTable(attachedDatabase, alias);
  }
}

class CommandmentsTableData extends DataClass
    implements Insertable<CommandmentsTableData> {
  final int id;
  final int number;
  final String commandmentText;
  final String category;
  final String commandment;
  final int? customId;
  const CommandmentsTableData(
      {required this.id,
      required this.number,
      required this.commandmentText,
      required this.category,
      required this.commandment,
      this.customId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['_id'] = Variable<int>(id);
    map['NUMBER'] = Variable<int>(number);
    map['TEXT'] = Variable<String>(commandmentText);
    map['CATEGORY'] = Variable<String>(category);
    map['COMMANDMENT'] = Variable<String>(commandment);
    if (!nullToAbsent || customId != null) {
      map['CUSTOM_ID'] = Variable<int>(customId);
    }
    return map;
  }

  CommandmentsTableCompanion toCompanion(bool nullToAbsent) {
    return CommandmentsTableCompanion(
      id: Value(id),
      number: Value(number),
      commandmentText: Value(commandmentText),
      category: Value(category),
      commandment: Value(commandment),
      customId: customId == null && nullToAbsent
          ? const Value.absent()
          : Value(customId),
    );
  }

  factory CommandmentsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommandmentsTableData(
      id: serializer.fromJson<int>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      commandmentText: serializer.fromJson<String>(json['commandmentText']),
      category: serializer.fromJson<String>(json['category']),
      commandment: serializer.fromJson<String>(json['commandment']),
      customId: serializer.fromJson<int?>(json['customId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'number': serializer.toJson<int>(number),
      'commandmentText': serializer.toJson<String>(commandmentText),
      'category': serializer.toJson<String>(category),
      'commandment': serializer.toJson<String>(commandment),
      'customId': serializer.toJson<int?>(customId),
    };
  }

  CommandmentsTableData copyWith(
          {int? id,
          int? number,
          String? commandmentText,
          String? category,
          String? commandment,
          Value<int?> customId = const Value.absent()}) =>
      CommandmentsTableData(
        id: id ?? this.id,
        number: number ?? this.number,
        commandmentText: commandmentText ?? this.commandmentText,
        category: category ?? this.category,
        commandment: commandment ?? this.commandment,
        customId: customId.present ? customId.value : this.customId,
      );
  CommandmentsTableData copyWithCompanion(CommandmentsTableCompanion data) {
    return CommandmentsTableData(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      commandmentText: data.commandmentText.present
          ? data.commandmentText.value
          : this.commandmentText,
      category: data.category.present ? data.category.value : this.category,
      commandment:
          data.commandment.present ? data.commandment.value : this.commandment,
      customId: data.customId.present ? data.customId.value : this.customId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommandmentsTableData(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('commandmentText: $commandmentText, ')
          ..write('category: $category, ')
          ..write('commandment: $commandment, ')
          ..write('customId: $customId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, number, commandmentText, category, commandment, customId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommandmentsTableData &&
          other.id == this.id &&
          other.number == this.number &&
          other.commandmentText == this.commandmentText &&
          other.category == this.category &&
          other.commandment == this.commandment &&
          other.customId == this.customId);
}

class CommandmentsTableCompanion
    extends UpdateCompanion<CommandmentsTableData> {
  final Value<int> id;
  final Value<int> number;
  final Value<String> commandmentText;
  final Value<String> category;
  final Value<String> commandment;
  final Value<int?> customId;
  const CommandmentsTableCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.commandmentText = const Value.absent(),
    this.category = const Value.absent(),
    this.commandment = const Value.absent(),
    this.customId = const Value.absent(),
  });
  CommandmentsTableCompanion.insert({
    this.id = const Value.absent(),
    required int number,
    required String commandmentText,
    required String category,
    required String commandment,
    this.customId = const Value.absent(),
  })  : number = Value(number),
        commandmentText = Value(commandmentText),
        category = Value(category),
        commandment = Value(commandment);
  static Insertable<CommandmentsTableData> custom({
    Expression<int>? id,
    Expression<int>? number,
    Expression<String>? commandmentText,
    Expression<String>? category,
    Expression<String>? commandment,
    Expression<int>? customId,
  }) {
    return RawValuesInsertable({
      if (id != null) '_id': id,
      if (number != null) 'NUMBER': number,
      if (commandmentText != null) 'TEXT': commandmentText,
      if (category != null) 'CATEGORY': category,
      if (commandment != null) 'COMMANDMENT': commandment,
      if (customId != null) 'CUSTOM_ID': customId,
    });
  }

  CommandmentsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? number,
      Value<String>? commandmentText,
      Value<String>? category,
      Value<String>? commandment,
      Value<int?>? customId}) {
    return CommandmentsTableCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      commandmentText: commandmentText ?? this.commandmentText,
      category: category ?? this.category,
      commandment: commandment ?? this.commandment,
      customId: customId ?? this.customId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['_id'] = Variable<int>(id.value);
    }
    if (number.present) {
      map['NUMBER'] = Variable<int>(number.value);
    }
    if (commandmentText.present) {
      map['TEXT'] = Variable<String>(commandmentText.value);
    }
    if (category.present) {
      map['CATEGORY'] = Variable<String>(category.value);
    }
    if (commandment.present) {
      map['COMMANDMENT'] = Variable<String>(commandment.value);
    }
    if (customId.present) {
      map['CUSTOM_ID'] = Variable<int>(customId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommandmentsTableCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('commandmentText: $commandmentText, ')
          ..write('category: $category, ')
          ..write('commandment: $commandment, ')
          ..write('customId: $customId')
          ..write(')'))
        .toString();
  }
}

class $ExaminationsTableTable extends ExaminationsTable
    with TableInfo<$ExaminationsTableTable, ExaminationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExaminationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      '_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _commandmentIdMeta =
      const VerificationMeta('commandmentId');
  @override
  late final GeneratedColumn<int> commandmentId = GeneratedColumn<int>(
      'COMMANDMENT_ID', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _adultMeta = const VerificationMeta('adult');
  @override
  late final GeneratedColumn<bool> adult = GeneratedColumn<bool>(
      'ADULT', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ADULT" IN (0, 1))'));
  static const VerificationMeta _singleMeta = const VerificationMeta('single');
  @override
  late final GeneratedColumn<bool> single = GeneratedColumn<bool>(
      'SINGLE', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("SINGLE" IN (0, 1))'));
  static const VerificationMeta _marriedMeta =
      const VerificationMeta('married');
  @override
  late final GeneratedColumn<bool> married = GeneratedColumn<bool>(
      'MARRIED', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("MARRIED" IN (0, 1))'));
  static const VerificationMeta _religiousMeta =
      const VerificationMeta('religious');
  @override
  late final GeneratedColumn<bool> religious = GeneratedColumn<bool>(
      'RELIGIOUS', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("RELIGIOUS" IN (0, 1))'));
  static const VerificationMeta _priestMeta = const VerificationMeta('priest');
  @override
  late final GeneratedColumn<bool> priest = GeneratedColumn<bool>(
      'PRIEST', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("PRIEST" IN (0, 1))'));
  static const VerificationMeta _teenMeta = const VerificationMeta('teen');
  @override
  late final GeneratedColumn<bool> teen = GeneratedColumn<bool>(
      'TEEN', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("TEEN" IN (0, 1))'));
  static const VerificationMeta _femaleMeta = const VerificationMeta('female');
  @override
  late final GeneratedColumn<bool> female = GeneratedColumn<bool>(
      'FEMALE', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("FEMALE" IN (0, 1))'));
  static const VerificationMeta _maleMeta = const VerificationMeta('male');
  @override
  late final GeneratedColumn<bool> male = GeneratedColumn<bool>(
      'MALE', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("MALE" IN (0, 1))'));
  static const VerificationMeta _childMeta = const VerificationMeta('child');
  @override
  late final GeneratedColumn<bool> child = GeneratedColumn<bool>(
      'CHILD', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("CHILD" IN (0, 1))'));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'IS_DELETED', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("IS_DELETED" IN (0, 1))'));
  static const VerificationMeta _customIdMeta =
      const VerificationMeta('customId');
  @override
  late final GeneratedColumn<String> customId = GeneratedColumn<String>(
      'CUSTOM_ID', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'DESCRIPTION', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activeTextMeta =
      const VerificationMeta('activeText');
  @override
  late final GeneratedColumn<String> activeText = GeneratedColumn<String>(
      'DESCRIPTION_ACTIVE', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'COUNT', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        commandmentId,
        adult,
        single,
        married,
        religious,
        priest,
        teen,
        female,
        male,
        child,
        isDeleted,
        customId,
        description,
        activeText,
        count
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'SIN';
  @override
  VerificationContext validateIntegrity(
      Insertable<ExaminationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('_id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['_id']!, _idMeta));
    }
    if (data.containsKey('COMMANDMENT_ID')) {
      context.handle(
          _commandmentIdMeta,
          commandmentId.isAcceptableOrUnknown(
              data['COMMANDMENT_ID']!, _commandmentIdMeta));
    } else if (isInserting) {
      context.missing(_commandmentIdMeta);
    }
    if (data.containsKey('ADULT')) {
      context.handle(
          _adultMeta, adult.isAcceptableOrUnknown(data['ADULT']!, _adultMeta));
    } else if (isInserting) {
      context.missing(_adultMeta);
    }
    if (data.containsKey('SINGLE')) {
      context.handle(_singleMeta,
          single.isAcceptableOrUnknown(data['SINGLE']!, _singleMeta));
    } else if (isInserting) {
      context.missing(_singleMeta);
    }
    if (data.containsKey('MARRIED')) {
      context.handle(_marriedMeta,
          married.isAcceptableOrUnknown(data['MARRIED']!, _marriedMeta));
    } else if (isInserting) {
      context.missing(_marriedMeta);
    }
    if (data.containsKey('RELIGIOUS')) {
      context.handle(_religiousMeta,
          religious.isAcceptableOrUnknown(data['RELIGIOUS']!, _religiousMeta));
    } else if (isInserting) {
      context.missing(_religiousMeta);
    }
    if (data.containsKey('PRIEST')) {
      context.handle(_priestMeta,
          priest.isAcceptableOrUnknown(data['PRIEST']!, _priestMeta));
    } else if (isInserting) {
      context.missing(_priestMeta);
    }
    if (data.containsKey('TEEN')) {
      context.handle(
          _teenMeta, teen.isAcceptableOrUnknown(data['TEEN']!, _teenMeta));
    } else if (isInserting) {
      context.missing(_teenMeta);
    }
    if (data.containsKey('FEMALE')) {
      context.handle(_femaleMeta,
          female.isAcceptableOrUnknown(data['FEMALE']!, _femaleMeta));
    } else if (isInserting) {
      context.missing(_femaleMeta);
    }
    if (data.containsKey('MALE')) {
      context.handle(
          _maleMeta, male.isAcceptableOrUnknown(data['MALE']!, _maleMeta));
    } else if (isInserting) {
      context.missing(_maleMeta);
    }
    if (data.containsKey('CHILD')) {
      context.handle(
          _childMeta, child.isAcceptableOrUnknown(data['CHILD']!, _childMeta));
    } else if (isInserting) {
      context.missing(_childMeta);
    }
    if (data.containsKey('IS_DELETED')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['IS_DELETED']!, _isDeletedMeta));
    }
    if (data.containsKey('CUSTOM_ID')) {
      context.handle(_customIdMeta,
          customId.isAcceptableOrUnknown(data['CUSTOM_ID']!, _customIdMeta));
    }
    if (data.containsKey('DESCRIPTION')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['DESCRIPTION']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('DESCRIPTION_ACTIVE')) {
      context.handle(
          _activeTextMeta,
          activeText.isAcceptableOrUnknown(
              data['DESCRIPTION_ACTIVE']!, _activeTextMeta));
    } else if (isInserting) {
      context.missing(_activeTextMeta);
    }
    if (data.containsKey('COUNT')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['COUNT']!, _countMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExaminationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExaminationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}_id'])!,
      commandmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}COMMANDMENT_ID'])!,
      adult: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ADULT'])!,
      single: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}SINGLE'])!,
      married: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}MARRIED'])!,
      religious: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}RELIGIOUS'])!,
      priest: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}PRIEST'])!,
      teen: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}TEEN'])!,
      female: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}FEMALE'])!,
      male: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}MALE'])!,
      child: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}CHILD'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}IS_DELETED']),
      customId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}CUSTOM_ID']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}DESCRIPTION'])!,
      activeText: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}DESCRIPTION_ACTIVE'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}COUNT'])!,
    );
  }

  @override
  $ExaminationsTableTable createAlias(String alias) {
    return $ExaminationsTableTable(attachedDatabase, alias);
  }
}

class ExaminationsTableData extends DataClass
    implements Insertable<ExaminationsTableData> {
  final int id;
  final int commandmentId;
  final bool adult;
  final bool single;
  final bool married;
  final bool religious;
  final bool priest;
  final bool teen;
  final bool female;
  final bool male;
  final bool child;
  final bool? isDeleted;
  final String? customId;
  final String description;
  final String activeText;
  final int count;
  const ExaminationsTableData(
      {required this.id,
      required this.commandmentId,
      required this.adult,
      required this.single,
      required this.married,
      required this.religious,
      required this.priest,
      required this.teen,
      required this.female,
      required this.male,
      required this.child,
      this.isDeleted,
      this.customId,
      required this.description,
      required this.activeText,
      required this.count});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['_id'] = Variable<int>(id);
    map['COMMANDMENT_ID'] = Variable<int>(commandmentId);
    map['ADULT'] = Variable<bool>(adult);
    map['SINGLE'] = Variable<bool>(single);
    map['MARRIED'] = Variable<bool>(married);
    map['RELIGIOUS'] = Variable<bool>(religious);
    map['PRIEST'] = Variable<bool>(priest);
    map['TEEN'] = Variable<bool>(teen);
    map['FEMALE'] = Variable<bool>(female);
    map['MALE'] = Variable<bool>(male);
    map['CHILD'] = Variable<bool>(child);
    if (!nullToAbsent || isDeleted != null) {
      map['IS_DELETED'] = Variable<bool>(isDeleted);
    }
    if (!nullToAbsent || customId != null) {
      map['CUSTOM_ID'] = Variable<String>(customId);
    }
    map['DESCRIPTION'] = Variable<String>(description);
    map['DESCRIPTION_ACTIVE'] = Variable<String>(activeText);
    map['COUNT'] = Variable<int>(count);
    return map;
  }

  ExaminationsTableCompanion toCompanion(bool nullToAbsent) {
    return ExaminationsTableCompanion(
      id: Value(id),
      commandmentId: Value(commandmentId),
      adult: Value(adult),
      single: Value(single),
      married: Value(married),
      religious: Value(religious),
      priest: Value(priest),
      teen: Value(teen),
      female: Value(female),
      male: Value(male),
      child: Value(child),
      isDeleted: isDeleted == null && nullToAbsent
          ? const Value.absent()
          : Value(isDeleted),
      customId: customId == null && nullToAbsent
          ? const Value.absent()
          : Value(customId),
      description: Value(description),
      activeText: Value(activeText),
      count: Value(count),
    );
  }

  factory ExaminationsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExaminationsTableData(
      id: serializer.fromJson<int>(json['id']),
      commandmentId: serializer.fromJson<int>(json['commandmentId']),
      adult: serializer.fromJson<bool>(json['adult']),
      single: serializer.fromJson<bool>(json['single']),
      married: serializer.fromJson<bool>(json['married']),
      religious: serializer.fromJson<bool>(json['religious']),
      priest: serializer.fromJson<bool>(json['priest']),
      teen: serializer.fromJson<bool>(json['teen']),
      female: serializer.fromJson<bool>(json['female']),
      male: serializer.fromJson<bool>(json['male']),
      child: serializer.fromJson<bool>(json['child']),
      isDeleted: serializer.fromJson<bool?>(json['isDeleted']),
      customId: serializer.fromJson<String?>(json['customId']),
      description: serializer.fromJson<String>(json['description']),
      activeText: serializer.fromJson<String>(json['activeText']),
      count: serializer.fromJson<int>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'commandmentId': serializer.toJson<int>(commandmentId),
      'adult': serializer.toJson<bool>(adult),
      'single': serializer.toJson<bool>(single),
      'married': serializer.toJson<bool>(married),
      'religious': serializer.toJson<bool>(religious),
      'priest': serializer.toJson<bool>(priest),
      'teen': serializer.toJson<bool>(teen),
      'female': serializer.toJson<bool>(female),
      'male': serializer.toJson<bool>(male),
      'child': serializer.toJson<bool>(child),
      'isDeleted': serializer.toJson<bool?>(isDeleted),
      'customId': serializer.toJson<String?>(customId),
      'description': serializer.toJson<String>(description),
      'activeText': serializer.toJson<String>(activeText),
      'count': serializer.toJson<int>(count),
    };
  }

  ExaminationsTableData copyWith(
          {int? id,
          int? commandmentId,
          bool? adult,
          bool? single,
          bool? married,
          bool? religious,
          bool? priest,
          bool? teen,
          bool? female,
          bool? male,
          bool? child,
          Value<bool?> isDeleted = const Value.absent(),
          Value<String?> customId = const Value.absent(),
          String? description,
          String? activeText,
          int? count}) =>
      ExaminationsTableData(
        id: id ?? this.id,
        commandmentId: commandmentId ?? this.commandmentId,
        adult: adult ?? this.adult,
        single: single ?? this.single,
        married: married ?? this.married,
        religious: religious ?? this.religious,
        priest: priest ?? this.priest,
        teen: teen ?? this.teen,
        female: female ?? this.female,
        male: male ?? this.male,
        child: child ?? this.child,
        isDeleted: isDeleted.present ? isDeleted.value : this.isDeleted,
        customId: customId.present ? customId.value : this.customId,
        description: description ?? this.description,
        activeText: activeText ?? this.activeText,
        count: count ?? this.count,
      );
  ExaminationsTableData copyWithCompanion(ExaminationsTableCompanion data) {
    return ExaminationsTableData(
      id: data.id.present ? data.id.value : this.id,
      commandmentId: data.commandmentId.present
          ? data.commandmentId.value
          : this.commandmentId,
      adult: data.adult.present ? data.adult.value : this.adult,
      single: data.single.present ? data.single.value : this.single,
      married: data.married.present ? data.married.value : this.married,
      religious: data.religious.present ? data.religious.value : this.religious,
      priest: data.priest.present ? data.priest.value : this.priest,
      teen: data.teen.present ? data.teen.value : this.teen,
      female: data.female.present ? data.female.value : this.female,
      male: data.male.present ? data.male.value : this.male,
      child: data.child.present ? data.child.value : this.child,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      customId: data.customId.present ? data.customId.value : this.customId,
      description:
          data.description.present ? data.description.value : this.description,
      activeText:
          data.activeText.present ? data.activeText.value : this.activeText,
      count: data.count.present ? data.count.value : this.count,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExaminationsTableData(')
          ..write('id: $id, ')
          ..write('commandmentId: $commandmentId, ')
          ..write('adult: $adult, ')
          ..write('single: $single, ')
          ..write('married: $married, ')
          ..write('religious: $religious, ')
          ..write('priest: $priest, ')
          ..write('teen: $teen, ')
          ..write('female: $female, ')
          ..write('male: $male, ')
          ..write('child: $child, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('customId: $customId, ')
          ..write('description: $description, ')
          ..write('activeText: $activeText, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      commandmentId,
      adult,
      single,
      married,
      religious,
      priest,
      teen,
      female,
      male,
      child,
      isDeleted,
      customId,
      description,
      activeText,
      count);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExaminationsTableData &&
          other.id == this.id &&
          other.commandmentId == this.commandmentId &&
          other.adult == this.adult &&
          other.single == this.single &&
          other.married == this.married &&
          other.religious == this.religious &&
          other.priest == this.priest &&
          other.teen == this.teen &&
          other.female == this.female &&
          other.male == this.male &&
          other.child == this.child &&
          other.isDeleted == this.isDeleted &&
          other.customId == this.customId &&
          other.description == this.description &&
          other.activeText == this.activeText &&
          other.count == this.count);
}

class ExaminationsTableCompanion
    extends UpdateCompanion<ExaminationsTableData> {
  final Value<int> id;
  final Value<int> commandmentId;
  final Value<bool> adult;
  final Value<bool> single;
  final Value<bool> married;
  final Value<bool> religious;
  final Value<bool> priest;
  final Value<bool> teen;
  final Value<bool> female;
  final Value<bool> male;
  final Value<bool> child;
  final Value<bool?> isDeleted;
  final Value<String?> customId;
  final Value<String> description;
  final Value<String> activeText;
  final Value<int> count;
  const ExaminationsTableCompanion({
    this.id = const Value.absent(),
    this.commandmentId = const Value.absent(),
    this.adult = const Value.absent(),
    this.single = const Value.absent(),
    this.married = const Value.absent(),
    this.religious = const Value.absent(),
    this.priest = const Value.absent(),
    this.teen = const Value.absent(),
    this.female = const Value.absent(),
    this.male = const Value.absent(),
    this.child = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.customId = const Value.absent(),
    this.description = const Value.absent(),
    this.activeText = const Value.absent(),
    this.count = const Value.absent(),
  });
  ExaminationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int commandmentId,
    required bool adult,
    required bool single,
    required bool married,
    required bool religious,
    required bool priest,
    required bool teen,
    required bool female,
    required bool male,
    required bool child,
    this.isDeleted = const Value.absent(),
    this.customId = const Value.absent(),
    required String description,
    required String activeText,
    this.count = const Value.absent(),
  })  : commandmentId = Value(commandmentId),
        adult = Value(adult),
        single = Value(single),
        married = Value(married),
        religious = Value(religious),
        priest = Value(priest),
        teen = Value(teen),
        female = Value(female),
        male = Value(male),
        child = Value(child),
        description = Value(description),
        activeText = Value(activeText);
  static Insertable<ExaminationsTableData> custom({
    Expression<int>? id,
    Expression<int>? commandmentId,
    Expression<bool>? adult,
    Expression<bool>? single,
    Expression<bool>? married,
    Expression<bool>? religious,
    Expression<bool>? priest,
    Expression<bool>? teen,
    Expression<bool>? female,
    Expression<bool>? male,
    Expression<bool>? child,
    Expression<bool>? isDeleted,
    Expression<String>? customId,
    Expression<String>? description,
    Expression<String>? activeText,
    Expression<int>? count,
  }) {
    return RawValuesInsertable({
      if (id != null) '_id': id,
      if (commandmentId != null) 'COMMANDMENT_ID': commandmentId,
      if (adult != null) 'ADULT': adult,
      if (single != null) 'SINGLE': single,
      if (married != null) 'MARRIED': married,
      if (religious != null) 'RELIGIOUS': religious,
      if (priest != null) 'PRIEST': priest,
      if (teen != null) 'TEEN': teen,
      if (female != null) 'FEMALE': female,
      if (male != null) 'MALE': male,
      if (child != null) 'CHILD': child,
      if (isDeleted != null) 'IS_DELETED': isDeleted,
      if (customId != null) 'CUSTOM_ID': customId,
      if (description != null) 'DESCRIPTION': description,
      if (activeText != null) 'DESCRIPTION_ACTIVE': activeText,
      if (count != null) 'COUNT': count,
    });
  }

  ExaminationsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? commandmentId,
      Value<bool>? adult,
      Value<bool>? single,
      Value<bool>? married,
      Value<bool>? religious,
      Value<bool>? priest,
      Value<bool>? teen,
      Value<bool>? female,
      Value<bool>? male,
      Value<bool>? child,
      Value<bool?>? isDeleted,
      Value<String?>? customId,
      Value<String>? description,
      Value<String>? activeText,
      Value<int>? count}) {
    return ExaminationsTableCompanion(
      id: id ?? this.id,
      commandmentId: commandmentId ?? this.commandmentId,
      adult: adult ?? this.adult,
      single: single ?? this.single,
      married: married ?? this.married,
      religious: religious ?? this.religious,
      priest: priest ?? this.priest,
      teen: teen ?? this.teen,
      female: female ?? this.female,
      male: male ?? this.male,
      child: child ?? this.child,
      isDeleted: isDeleted ?? this.isDeleted,
      customId: customId ?? this.customId,
      description: description ?? this.description,
      activeText: activeText ?? this.activeText,
      count: count ?? this.count,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['_id'] = Variable<int>(id.value);
    }
    if (commandmentId.present) {
      map['COMMANDMENT_ID'] = Variable<int>(commandmentId.value);
    }
    if (adult.present) {
      map['ADULT'] = Variable<bool>(adult.value);
    }
    if (single.present) {
      map['SINGLE'] = Variable<bool>(single.value);
    }
    if (married.present) {
      map['MARRIED'] = Variable<bool>(married.value);
    }
    if (religious.present) {
      map['RELIGIOUS'] = Variable<bool>(religious.value);
    }
    if (priest.present) {
      map['PRIEST'] = Variable<bool>(priest.value);
    }
    if (teen.present) {
      map['TEEN'] = Variable<bool>(teen.value);
    }
    if (female.present) {
      map['FEMALE'] = Variable<bool>(female.value);
    }
    if (male.present) {
      map['MALE'] = Variable<bool>(male.value);
    }
    if (child.present) {
      map['CHILD'] = Variable<bool>(child.value);
    }
    if (isDeleted.present) {
      map['IS_DELETED'] = Variable<bool>(isDeleted.value);
    }
    if (customId.present) {
      map['CUSTOM_ID'] = Variable<String>(customId.value);
    }
    if (description.present) {
      map['DESCRIPTION'] = Variable<String>(description.value);
    }
    if (activeText.present) {
      map['DESCRIPTION_ACTIVE'] = Variable<String>(activeText.value);
    }
    if (count.present) {
      map['COUNT'] = Variable<int>(count.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExaminationsTableCompanion(')
          ..write('id: $id, ')
          ..write('commandmentId: $commandmentId, ')
          ..write('adult: $adult, ')
          ..write('single: $single, ')
          ..write('married: $married, ')
          ..write('religious: $religious, ')
          ..write('priest: $priest, ')
          ..write('teen: $teen, ')
          ..write('female: $female, ')
          ..write('male: $male, ')
          ..write('child: $child, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('customId: $customId, ')
          ..write('description: $description, ')
          ..write('activeText: $activeText, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }
}

class $GuidesTableTable extends GuidesTable
    with TableInfo<$GuidesTableTable, GuidesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GuidesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      '_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _guideTitleMeta =
      const VerificationMeta('guideTitle');
  @override
  late final GeneratedColumn<String> guideTitle = GeneratedColumn<String>(
      'g_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _guideTextMeta =
      const VerificationMeta('guideText');
  @override
  late final GeneratedColumn<String> guideText = GeneratedColumn<String>(
      'text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _headerIdMeta =
      const VerificationMeta('headerId');
  @override
  late final GeneratedColumn<int> headerId = GeneratedColumn<int>(
      'h_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, guideTitle, guideText, headerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'guide_main';
  @override
  VerificationContext validateIntegrity(Insertable<GuidesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('_id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['_id']!, _idMeta));
    }
    if (data.containsKey('g_title')) {
      context.handle(_guideTitleMeta,
          guideTitle.isAcceptableOrUnknown(data['g_title']!, _guideTitleMeta));
    } else if (isInserting) {
      context.missing(_guideTitleMeta);
    }
    if (data.containsKey('text')) {
      context.handle(_guideTextMeta,
          guideText.isAcceptableOrUnknown(data['text']!, _guideTextMeta));
    } else if (isInserting) {
      context.missing(_guideTextMeta);
    }
    if (data.containsKey('h_id')) {
      context.handle(_headerIdMeta,
          headerId.isAcceptableOrUnknown(data['h_id']!, _headerIdMeta));
    } else if (isInserting) {
      context.missing(_headerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GuidesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GuidesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}_id'])!,
      guideTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}g_title'])!,
      guideText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text'])!,
      headerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}h_id'])!,
    );
  }

  @override
  $GuidesTableTable createAlias(String alias) {
    return $GuidesTableTable(attachedDatabase, alias);
  }
}

class GuidesTableData extends DataClass implements Insertable<GuidesTableData> {
  final int id;
  final String guideTitle;
  final String guideText;
  final int headerId;
  const GuidesTableData(
      {required this.id,
      required this.guideTitle,
      required this.guideText,
      required this.headerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['_id'] = Variable<int>(id);
    map['g_title'] = Variable<String>(guideTitle);
    map['text'] = Variable<String>(guideText);
    map['h_id'] = Variable<int>(headerId);
    return map;
  }

  GuidesTableCompanion toCompanion(bool nullToAbsent) {
    return GuidesTableCompanion(
      id: Value(id),
      guideTitle: Value(guideTitle),
      guideText: Value(guideText),
      headerId: Value(headerId),
    );
  }

  factory GuidesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GuidesTableData(
      id: serializer.fromJson<int>(json['id']),
      guideTitle: serializer.fromJson<String>(json['guideTitle']),
      guideText: serializer.fromJson<String>(json['guideText']),
      headerId: serializer.fromJson<int>(json['headerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'guideTitle': serializer.toJson<String>(guideTitle),
      'guideText': serializer.toJson<String>(guideText),
      'headerId': serializer.toJson<int>(headerId),
    };
  }

  GuidesTableData copyWith(
          {int? id, String? guideTitle, String? guideText, int? headerId}) =>
      GuidesTableData(
        id: id ?? this.id,
        guideTitle: guideTitle ?? this.guideTitle,
        guideText: guideText ?? this.guideText,
        headerId: headerId ?? this.headerId,
      );
  GuidesTableData copyWithCompanion(GuidesTableCompanion data) {
    return GuidesTableData(
      id: data.id.present ? data.id.value : this.id,
      guideTitle:
          data.guideTitle.present ? data.guideTitle.value : this.guideTitle,
      guideText: data.guideText.present ? data.guideText.value : this.guideText,
      headerId: data.headerId.present ? data.headerId.value : this.headerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GuidesTableData(')
          ..write('id: $id, ')
          ..write('guideTitle: $guideTitle, ')
          ..write('guideText: $guideText, ')
          ..write('headerId: $headerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, guideTitle, guideText, headerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GuidesTableData &&
          other.id == this.id &&
          other.guideTitle == this.guideTitle &&
          other.guideText == this.guideText &&
          other.headerId == this.headerId);
}

class GuidesTableCompanion extends UpdateCompanion<GuidesTableData> {
  final Value<int> id;
  final Value<String> guideTitle;
  final Value<String> guideText;
  final Value<int> headerId;
  const GuidesTableCompanion({
    this.id = const Value.absent(),
    this.guideTitle = const Value.absent(),
    this.guideText = const Value.absent(),
    this.headerId = const Value.absent(),
  });
  GuidesTableCompanion.insert({
    this.id = const Value.absent(),
    required String guideTitle,
    required String guideText,
    required int headerId,
  })  : guideTitle = Value(guideTitle),
        guideText = Value(guideText),
        headerId = Value(headerId);
  static Insertable<GuidesTableData> custom({
    Expression<int>? id,
    Expression<String>? guideTitle,
    Expression<String>? guideText,
    Expression<int>? headerId,
  }) {
    return RawValuesInsertable({
      if (id != null) '_id': id,
      if (guideTitle != null) 'g_title': guideTitle,
      if (guideText != null) 'text': guideText,
      if (headerId != null) 'h_id': headerId,
    });
  }

  GuidesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? guideTitle,
      Value<String>? guideText,
      Value<int>? headerId}) {
    return GuidesTableCompanion(
      id: id ?? this.id,
      guideTitle: guideTitle ?? this.guideTitle,
      guideText: guideText ?? this.guideText,
      headerId: headerId ?? this.headerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['_id'] = Variable<int>(id.value);
    }
    if (guideTitle.present) {
      map['g_title'] = Variable<String>(guideTitle.value);
    }
    if (guideText.present) {
      map['text'] = Variable<String>(guideText.value);
    }
    if (headerId.present) {
      map['h_id'] = Variable<int>(headerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GuidesTableCompanion(')
          ..write('id: $id, ')
          ..write('guideTitle: $guideTitle, ')
          ..write('guideText: $guideText, ')
          ..write('headerId: $headerId')
          ..write(')'))
        .toString();
  }
}

class $PrayersTableTable extends PrayersTable
    with TableInfo<$PrayersTableTable, PrayersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      '_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _prayerNameMeta =
      const VerificationMeta('prayerName');
  @override
  late final GeneratedColumn<String> prayerName = GeneratedColumn<String>(
      'PRAYERNAME', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _prayerTextMeta =
      const VerificationMeta('prayerText');
  @override
  late final GeneratedColumn<String> prayerText = GeneratedColumn<String>(
      'PRAYERTEXT', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'GROUPNAME', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, prayerName, prayerText, groupName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'PRAYERS';
  @override
  VerificationContext validateIntegrity(Insertable<PrayersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('_id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['_id']!, _idMeta));
    }
    if (data.containsKey('PRAYERNAME')) {
      context.handle(
          _prayerNameMeta,
          prayerName.isAcceptableOrUnknown(
              data['PRAYERNAME']!, _prayerNameMeta));
    } else if (isInserting) {
      context.missing(_prayerNameMeta);
    }
    if (data.containsKey('PRAYERTEXT')) {
      context.handle(
          _prayerTextMeta,
          prayerText.isAcceptableOrUnknown(
              data['PRAYERTEXT']!, _prayerTextMeta));
    } else if (isInserting) {
      context.missing(_prayerTextMeta);
    }
    if (data.containsKey('GROUPNAME')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['GROUPNAME']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrayersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}_id'])!,
      prayerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}PRAYERNAME'])!,
      prayerText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}PRAYERTEXT'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}GROUPNAME'])!,
    );
  }

  @override
  $PrayersTableTable createAlias(String alias) {
    return $PrayersTableTable(attachedDatabase, alias);
  }
}

class PrayersTableData extends DataClass
    implements Insertable<PrayersTableData> {
  final int id;
  final String prayerName;
  final String prayerText;
  final String groupName;
  const PrayersTableData(
      {required this.id,
      required this.prayerName,
      required this.prayerText,
      required this.groupName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['_id'] = Variable<int>(id);
    map['PRAYERNAME'] = Variable<String>(prayerName);
    map['PRAYERTEXT'] = Variable<String>(prayerText);
    map['GROUPNAME'] = Variable<String>(groupName);
    return map;
  }

  PrayersTableCompanion toCompanion(bool nullToAbsent) {
    return PrayersTableCompanion(
      id: Value(id),
      prayerName: Value(prayerName),
      prayerText: Value(prayerText),
      groupName: Value(groupName),
    );
  }

  factory PrayersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayersTableData(
      id: serializer.fromJson<int>(json['id']),
      prayerName: serializer.fromJson<String>(json['prayerName']),
      prayerText: serializer.fromJson<String>(json['prayerText']),
      groupName: serializer.fromJson<String>(json['groupName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prayerName': serializer.toJson<String>(prayerName),
      'prayerText': serializer.toJson<String>(prayerText),
      'groupName': serializer.toJson<String>(groupName),
    };
  }

  PrayersTableData copyWith(
          {int? id,
          String? prayerName,
          String? prayerText,
          String? groupName}) =>
      PrayersTableData(
        id: id ?? this.id,
        prayerName: prayerName ?? this.prayerName,
        prayerText: prayerText ?? this.prayerText,
        groupName: groupName ?? this.groupName,
      );
  PrayersTableData copyWithCompanion(PrayersTableCompanion data) {
    return PrayersTableData(
      id: data.id.present ? data.id.value : this.id,
      prayerName:
          data.prayerName.present ? data.prayerName.value : this.prayerName,
      prayerText:
          data.prayerText.present ? data.prayerText.value : this.prayerText,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayersTableData(')
          ..write('id: $id, ')
          ..write('prayerName: $prayerName, ')
          ..write('prayerText: $prayerText, ')
          ..write('groupName: $groupName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, prayerName, prayerText, groupName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayersTableData &&
          other.id == this.id &&
          other.prayerName == this.prayerName &&
          other.prayerText == this.prayerText &&
          other.groupName == this.groupName);
}

class PrayersTableCompanion extends UpdateCompanion<PrayersTableData> {
  final Value<int> id;
  final Value<String> prayerName;
  final Value<String> prayerText;
  final Value<String> groupName;
  const PrayersTableCompanion({
    this.id = const Value.absent(),
    this.prayerName = const Value.absent(),
    this.prayerText = const Value.absent(),
    this.groupName = const Value.absent(),
  });
  PrayersTableCompanion.insert({
    this.id = const Value.absent(),
    required String prayerName,
    required String prayerText,
    required String groupName,
  })  : prayerName = Value(prayerName),
        prayerText = Value(prayerText),
        groupName = Value(groupName);
  static Insertable<PrayersTableData> custom({
    Expression<int>? id,
    Expression<String>? prayerName,
    Expression<String>? prayerText,
    Expression<String>? groupName,
  }) {
    return RawValuesInsertable({
      if (id != null) '_id': id,
      if (prayerName != null) 'PRAYERNAME': prayerName,
      if (prayerText != null) 'PRAYERTEXT': prayerText,
      if (groupName != null) 'GROUPNAME': groupName,
    });
  }

  PrayersTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? prayerName,
      Value<String>? prayerText,
      Value<String>? groupName}) {
    return PrayersTableCompanion(
      id: id ?? this.id,
      prayerName: prayerName ?? this.prayerName,
      prayerText: prayerText ?? this.prayerText,
      groupName: groupName ?? this.groupName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['_id'] = Variable<int>(id.value);
    }
    if (prayerName.present) {
      map['PRAYERNAME'] = Variable<String>(prayerName.value);
    }
    if (prayerText.present) {
      map['PRAYERTEXT'] = Variable<String>(prayerText.value);
    }
    if (groupName.present) {
      map['GROUPNAME'] = Variable<String>(groupName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayersTableCompanion(')
          ..write('id: $id, ')
          ..write('prayerName: $prayerName, ')
          ..write('prayerText: $prayerText, ')
          ..write('groupName: $groupName')
          ..write(')'))
        .toString();
  }
}

class $InspirationsTableTable extends InspirationsTable
    with TableInfo<$InspirationsTableTable, InspirationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspirationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      '_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'AUTHOR', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quoteMeta = const VerificationMeta('quote');
  @override
  late final GeneratedColumn<String> quote = GeneratedColumn<String>(
      'QUOTE', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, author, quote];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'INSPIRATION';
  @override
  VerificationContext validateIntegrity(
      Insertable<InspirationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('_id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['_id']!, _idMeta));
    }
    if (data.containsKey('AUTHOR')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['AUTHOR']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('QUOTE')) {
      context.handle(
          _quoteMeta, quote.isAcceptableOrUnknown(data['QUOTE']!, _quoteMeta));
    } else if (isInserting) {
      context.missing(_quoteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InspirationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspirationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}_id'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}AUTHOR'])!,
      quote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}QUOTE'])!,
    );
  }

  @override
  $InspirationsTableTable createAlias(String alias) {
    return $InspirationsTableTable(attachedDatabase, alias);
  }
}

class InspirationsTableData extends DataClass
    implements Insertable<InspirationsTableData> {
  final int id;
  final String author;
  final String quote;
  const InspirationsTableData(
      {required this.id, required this.author, required this.quote});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['_id'] = Variable<int>(id);
    map['AUTHOR'] = Variable<String>(author);
    map['QUOTE'] = Variable<String>(quote);
    return map;
  }

  InspirationsTableCompanion toCompanion(bool nullToAbsent) {
    return InspirationsTableCompanion(
      id: Value(id),
      author: Value(author),
      quote: Value(quote),
    );
  }

  factory InspirationsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspirationsTableData(
      id: serializer.fromJson<int>(json['id']),
      author: serializer.fromJson<String>(json['author']),
      quote: serializer.fromJson<String>(json['quote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'author': serializer.toJson<String>(author),
      'quote': serializer.toJson<String>(quote),
    };
  }

  InspirationsTableData copyWith({int? id, String? author, String? quote}) =>
      InspirationsTableData(
        id: id ?? this.id,
        author: author ?? this.author,
        quote: quote ?? this.quote,
      );
  InspirationsTableData copyWithCompanion(InspirationsTableCompanion data) {
    return InspirationsTableData(
      id: data.id.present ? data.id.value : this.id,
      author: data.author.present ? data.author.value : this.author,
      quote: data.quote.present ? data.quote.value : this.quote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspirationsTableData(')
          ..write('id: $id, ')
          ..write('author: $author, ')
          ..write('quote: $quote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, author, quote);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspirationsTableData &&
          other.id == this.id &&
          other.author == this.author &&
          other.quote == this.quote);
}

class InspirationsTableCompanion
    extends UpdateCompanion<InspirationsTableData> {
  final Value<int> id;
  final Value<String> author;
  final Value<String> quote;
  const InspirationsTableCompanion({
    this.id = const Value.absent(),
    this.author = const Value.absent(),
    this.quote = const Value.absent(),
  });
  InspirationsTableCompanion.insert({
    this.id = const Value.absent(),
    required String author,
    required String quote,
  })  : author = Value(author),
        quote = Value(quote);
  static Insertable<InspirationsTableData> custom({
    Expression<int>? id,
    Expression<String>? author,
    Expression<String>? quote,
  }) {
    return RawValuesInsertable({
      if (id != null) '_id': id,
      if (author != null) 'AUTHOR': author,
      if (quote != null) 'QUOTE': quote,
    });
  }

  InspirationsTableCompanion copyWith(
      {Value<int>? id, Value<String>? author, Value<String>? quote}) {
    return InspirationsTableCompanion(
      id: id ?? this.id,
      author: author ?? this.author,
      quote: quote ?? this.quote,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['_id'] = Variable<int>(id.value);
    }
    if (author.present) {
      map['AUTHOR'] = Variable<String>(author.value);
    }
    if (quote.present) {
      map['QUOTE'] = Variable<String>(quote.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspirationsTableCompanion(')
          ..write('id: $id, ')
          ..write('author: $author, ')
          ..write('quote: $quote')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CommandmentsTableTable commandmentsTable =
      $CommandmentsTableTable(this);
  late final $ExaminationsTableTable examinationsTable =
      $ExaminationsTableTable(this);
  late final $GuidesTableTable guidesTable = $GuidesTableTable(this);
  late final $PrayersTableTable prayersTable = $PrayersTableTable(this);
  late final $InspirationsTableTable inspirationsTable =
      $InspirationsTableTable(this);
  late final CommandmentsDao commandmentsDao =
      CommandmentsDao(this as AppDatabase);
  late final ExaminationsDao examinationsDao =
      ExaminationsDao(this as AppDatabase);
  late final PrayersDao prayersDao = PrayersDao(this as AppDatabase);
  late final GuidesDao guidesDao = GuidesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        commandmentsTable,
        examinationsTable,
        guidesTable,
        prayersTable,
        inspirationsTable
      ];
}

typedef $$CommandmentsTableTableCreateCompanionBuilder
    = CommandmentsTableCompanion Function({
  Value<int> id,
  required int number,
  required String commandmentText,
  required String category,
  required String commandment,
  Value<int?> customId,
});
typedef $$CommandmentsTableTableUpdateCompanionBuilder
    = CommandmentsTableCompanion Function({
  Value<int> id,
  Value<int> number,
  Value<String> commandmentText,
  Value<String> category,
  Value<String> commandment,
  Value<int?> customId,
});

class $$CommandmentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CommandmentsTableTable> {
  $$CommandmentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get commandmentText => $composableBuilder(
      column: $table.commandmentText,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get commandment => $composableBuilder(
      column: $table.commandment, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get customId => $composableBuilder(
      column: $table.customId, builder: (column) => ColumnFilters(column));
}

class $$CommandmentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CommandmentsTableTable> {
  $$CommandmentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get commandmentText => $composableBuilder(
      column: $table.commandmentText,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get commandment => $composableBuilder(
      column: $table.commandment, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customId => $composableBuilder(
      column: $table.customId, builder: (column) => ColumnOrderings(column));
}

class $$CommandmentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommandmentsTableTable> {
  $$CommandmentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get commandmentText => $composableBuilder(
      column: $table.commandmentText, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get commandment => $composableBuilder(
      column: $table.commandment, builder: (column) => column);

  GeneratedColumn<int> get customId =>
      $composableBuilder(column: $table.customId, builder: (column) => column);
}

class $$CommandmentsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CommandmentsTableTable,
    CommandmentsTableData,
    $$CommandmentsTableTableFilterComposer,
    $$CommandmentsTableTableOrderingComposer,
    $$CommandmentsTableTableAnnotationComposer,
    $$CommandmentsTableTableCreateCompanionBuilder,
    $$CommandmentsTableTableUpdateCompanionBuilder,
    (
      CommandmentsTableData,
      BaseReferences<_$AppDatabase, $CommandmentsTableTable,
          CommandmentsTableData>
    ),
    CommandmentsTableData,
    PrefetchHooks Function()> {
  $$CommandmentsTableTableTableManager(
      _$AppDatabase db, $CommandmentsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommandmentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommandmentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommandmentsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> number = const Value.absent(),
            Value<String> commandmentText = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> commandment = const Value.absent(),
            Value<int?> customId = const Value.absent(),
          }) =>
              CommandmentsTableCompanion(
            id: id,
            number: number,
            commandmentText: commandmentText,
            category: category,
            commandment: commandment,
            customId: customId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int number,
            required String commandmentText,
            required String category,
            required String commandment,
            Value<int?> customId = const Value.absent(),
          }) =>
              CommandmentsTableCompanion.insert(
            id: id,
            number: number,
            commandmentText: commandmentText,
            category: category,
            commandment: commandment,
            customId: customId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CommandmentsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CommandmentsTableTable,
    CommandmentsTableData,
    $$CommandmentsTableTableFilterComposer,
    $$CommandmentsTableTableOrderingComposer,
    $$CommandmentsTableTableAnnotationComposer,
    $$CommandmentsTableTableCreateCompanionBuilder,
    $$CommandmentsTableTableUpdateCompanionBuilder,
    (
      CommandmentsTableData,
      BaseReferences<_$AppDatabase, $CommandmentsTableTable,
          CommandmentsTableData>
    ),
    CommandmentsTableData,
    PrefetchHooks Function()>;
typedef $$ExaminationsTableTableCreateCompanionBuilder
    = ExaminationsTableCompanion Function({
  Value<int> id,
  required int commandmentId,
  required bool adult,
  required bool single,
  required bool married,
  required bool religious,
  required bool priest,
  required bool teen,
  required bool female,
  required bool male,
  required bool child,
  Value<bool?> isDeleted,
  Value<String?> customId,
  required String description,
  required String activeText,
  Value<int> count,
});
typedef $$ExaminationsTableTableUpdateCompanionBuilder
    = ExaminationsTableCompanion Function({
  Value<int> id,
  Value<int> commandmentId,
  Value<bool> adult,
  Value<bool> single,
  Value<bool> married,
  Value<bool> religious,
  Value<bool> priest,
  Value<bool> teen,
  Value<bool> female,
  Value<bool> male,
  Value<bool> child,
  Value<bool?> isDeleted,
  Value<String?> customId,
  Value<String> description,
  Value<String> activeText,
  Value<int> count,
});

class $$ExaminationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExaminationsTableTable> {
  $$ExaminationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get commandmentId => $composableBuilder(
      column: $table.commandmentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get adult => $composableBuilder(
      column: $table.adult, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get single => $composableBuilder(
      column: $table.single, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get married => $composableBuilder(
      column: $table.married, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get religious => $composableBuilder(
      column: $table.religious, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get priest => $composableBuilder(
      column: $table.priest, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get teen => $composableBuilder(
      column: $table.teen, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get female => $composableBuilder(
      column: $table.female, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get male => $composableBuilder(
      column: $table.male, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get child => $composableBuilder(
      column: $table.child, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customId => $composableBuilder(
      column: $table.customId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activeText => $composableBuilder(
      column: $table.activeText, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnFilters(column));
}

class $$ExaminationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExaminationsTableTable> {
  $$ExaminationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get commandmentId => $composableBuilder(
      column: $table.commandmentId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get adult => $composableBuilder(
      column: $table.adult, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get single => $composableBuilder(
      column: $table.single, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get married => $composableBuilder(
      column: $table.married, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get religious => $composableBuilder(
      column: $table.religious, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get priest => $composableBuilder(
      column: $table.priest, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get teen => $composableBuilder(
      column: $table.teen, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get female => $composableBuilder(
      column: $table.female, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get male => $composableBuilder(
      column: $table.male, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get child => $composableBuilder(
      column: $table.child, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customId => $composableBuilder(
      column: $table.customId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activeText => $composableBuilder(
      column: $table.activeText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnOrderings(column));
}

class $$ExaminationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExaminationsTableTable> {
  $$ExaminationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get commandmentId => $composableBuilder(
      column: $table.commandmentId, builder: (column) => column);

  GeneratedColumn<bool> get adult =>
      $composableBuilder(column: $table.adult, builder: (column) => column);

  GeneratedColumn<bool> get single =>
      $composableBuilder(column: $table.single, builder: (column) => column);

  GeneratedColumn<bool> get married =>
      $composableBuilder(column: $table.married, builder: (column) => column);

  GeneratedColumn<bool> get religious =>
      $composableBuilder(column: $table.religious, builder: (column) => column);

  GeneratedColumn<bool> get priest =>
      $composableBuilder(column: $table.priest, builder: (column) => column);

  GeneratedColumn<bool> get teen =>
      $composableBuilder(column: $table.teen, builder: (column) => column);

  GeneratedColumn<bool> get female =>
      $composableBuilder(column: $table.female, builder: (column) => column);

  GeneratedColumn<bool> get male =>
      $composableBuilder(column: $table.male, builder: (column) => column);

  GeneratedColumn<bool> get child =>
      $composableBuilder(column: $table.child, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get customId =>
      $composableBuilder(column: $table.customId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get activeText => $composableBuilder(
      column: $table.activeText, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);
}

class $$ExaminationsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExaminationsTableTable,
    ExaminationsTableData,
    $$ExaminationsTableTableFilterComposer,
    $$ExaminationsTableTableOrderingComposer,
    $$ExaminationsTableTableAnnotationComposer,
    $$ExaminationsTableTableCreateCompanionBuilder,
    $$ExaminationsTableTableUpdateCompanionBuilder,
    (
      ExaminationsTableData,
      BaseReferences<_$AppDatabase, $ExaminationsTableTable,
          ExaminationsTableData>
    ),
    ExaminationsTableData,
    PrefetchHooks Function()> {
  $$ExaminationsTableTableTableManager(
      _$AppDatabase db, $ExaminationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExaminationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExaminationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExaminationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> commandmentId = const Value.absent(),
            Value<bool> adult = const Value.absent(),
            Value<bool> single = const Value.absent(),
            Value<bool> married = const Value.absent(),
            Value<bool> religious = const Value.absent(),
            Value<bool> priest = const Value.absent(),
            Value<bool> teen = const Value.absent(),
            Value<bool> female = const Value.absent(),
            Value<bool> male = const Value.absent(),
            Value<bool> child = const Value.absent(),
            Value<bool?> isDeleted = const Value.absent(),
            Value<String?> customId = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> activeText = const Value.absent(),
            Value<int> count = const Value.absent(),
          }) =>
              ExaminationsTableCompanion(
            id: id,
            commandmentId: commandmentId,
            adult: adult,
            single: single,
            married: married,
            religious: religious,
            priest: priest,
            teen: teen,
            female: female,
            male: male,
            child: child,
            isDeleted: isDeleted,
            customId: customId,
            description: description,
            activeText: activeText,
            count: count,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int commandmentId,
            required bool adult,
            required bool single,
            required bool married,
            required bool religious,
            required bool priest,
            required bool teen,
            required bool female,
            required bool male,
            required bool child,
            Value<bool?> isDeleted = const Value.absent(),
            Value<String?> customId = const Value.absent(),
            required String description,
            required String activeText,
            Value<int> count = const Value.absent(),
          }) =>
              ExaminationsTableCompanion.insert(
            id: id,
            commandmentId: commandmentId,
            adult: adult,
            single: single,
            married: married,
            religious: religious,
            priest: priest,
            teen: teen,
            female: female,
            male: male,
            child: child,
            isDeleted: isDeleted,
            customId: customId,
            description: description,
            activeText: activeText,
            count: count,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExaminationsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExaminationsTableTable,
    ExaminationsTableData,
    $$ExaminationsTableTableFilterComposer,
    $$ExaminationsTableTableOrderingComposer,
    $$ExaminationsTableTableAnnotationComposer,
    $$ExaminationsTableTableCreateCompanionBuilder,
    $$ExaminationsTableTableUpdateCompanionBuilder,
    (
      ExaminationsTableData,
      BaseReferences<_$AppDatabase, $ExaminationsTableTable,
          ExaminationsTableData>
    ),
    ExaminationsTableData,
    PrefetchHooks Function()>;
typedef $$GuidesTableTableCreateCompanionBuilder = GuidesTableCompanion
    Function({
  Value<int> id,
  required String guideTitle,
  required String guideText,
  required int headerId,
});
typedef $$GuidesTableTableUpdateCompanionBuilder = GuidesTableCompanion
    Function({
  Value<int> id,
  Value<String> guideTitle,
  Value<String> guideText,
  Value<int> headerId,
});

class $$GuidesTableTableFilterComposer
    extends Composer<_$AppDatabase, $GuidesTableTable> {
  $$GuidesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get guideTitle => $composableBuilder(
      column: $table.guideTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get guideText => $composableBuilder(
      column: $table.guideText, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get headerId => $composableBuilder(
      column: $table.headerId, builder: (column) => ColumnFilters(column));
}

class $$GuidesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GuidesTableTable> {
  $$GuidesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get guideTitle => $composableBuilder(
      column: $table.guideTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get guideText => $composableBuilder(
      column: $table.guideText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get headerId => $composableBuilder(
      column: $table.headerId, builder: (column) => ColumnOrderings(column));
}

class $$GuidesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GuidesTableTable> {
  $$GuidesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get guideTitle => $composableBuilder(
      column: $table.guideTitle, builder: (column) => column);

  GeneratedColumn<String> get guideText =>
      $composableBuilder(column: $table.guideText, builder: (column) => column);

  GeneratedColumn<int> get headerId =>
      $composableBuilder(column: $table.headerId, builder: (column) => column);
}

class $$GuidesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GuidesTableTable,
    GuidesTableData,
    $$GuidesTableTableFilterComposer,
    $$GuidesTableTableOrderingComposer,
    $$GuidesTableTableAnnotationComposer,
    $$GuidesTableTableCreateCompanionBuilder,
    $$GuidesTableTableUpdateCompanionBuilder,
    (
      GuidesTableData,
      BaseReferences<_$AppDatabase, $GuidesTableTable, GuidesTableData>
    ),
    GuidesTableData,
    PrefetchHooks Function()> {
  $$GuidesTableTableTableManager(_$AppDatabase db, $GuidesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GuidesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GuidesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GuidesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> guideTitle = const Value.absent(),
            Value<String> guideText = const Value.absent(),
            Value<int> headerId = const Value.absent(),
          }) =>
              GuidesTableCompanion(
            id: id,
            guideTitle: guideTitle,
            guideText: guideText,
            headerId: headerId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String guideTitle,
            required String guideText,
            required int headerId,
          }) =>
              GuidesTableCompanion.insert(
            id: id,
            guideTitle: guideTitle,
            guideText: guideText,
            headerId: headerId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GuidesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GuidesTableTable,
    GuidesTableData,
    $$GuidesTableTableFilterComposer,
    $$GuidesTableTableOrderingComposer,
    $$GuidesTableTableAnnotationComposer,
    $$GuidesTableTableCreateCompanionBuilder,
    $$GuidesTableTableUpdateCompanionBuilder,
    (
      GuidesTableData,
      BaseReferences<_$AppDatabase, $GuidesTableTable, GuidesTableData>
    ),
    GuidesTableData,
    PrefetchHooks Function()>;
typedef $$PrayersTableTableCreateCompanionBuilder = PrayersTableCompanion
    Function({
  Value<int> id,
  required String prayerName,
  required String prayerText,
  required String groupName,
});
typedef $$PrayersTableTableUpdateCompanionBuilder = PrayersTableCompanion
    Function({
  Value<int> id,
  Value<String> prayerName,
  Value<String> prayerText,
  Value<String> groupName,
});

class $$PrayersTableTableFilterComposer
    extends Composer<_$AppDatabase, $PrayersTableTable> {
  $$PrayersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prayerName => $composableBuilder(
      column: $table.prayerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prayerText => $composableBuilder(
      column: $table.prayerText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnFilters(column));
}

class $$PrayersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayersTableTable> {
  $$PrayersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prayerName => $composableBuilder(
      column: $table.prayerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prayerText => $composableBuilder(
      column: $table.prayerText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnOrderings(column));
}

class $$PrayersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayersTableTable> {
  $$PrayersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get prayerName => $composableBuilder(
      column: $table.prayerName, builder: (column) => column);

  GeneratedColumn<String> get prayerText => $composableBuilder(
      column: $table.prayerText, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);
}

class $$PrayersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PrayersTableTable,
    PrayersTableData,
    $$PrayersTableTableFilterComposer,
    $$PrayersTableTableOrderingComposer,
    $$PrayersTableTableAnnotationComposer,
    $$PrayersTableTableCreateCompanionBuilder,
    $$PrayersTableTableUpdateCompanionBuilder,
    (
      PrayersTableData,
      BaseReferences<_$AppDatabase, $PrayersTableTable, PrayersTableData>
    ),
    PrayersTableData,
    PrefetchHooks Function()> {
  $$PrayersTableTableTableManager(_$AppDatabase db, $PrayersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrayersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> prayerName = const Value.absent(),
            Value<String> prayerText = const Value.absent(),
            Value<String> groupName = const Value.absent(),
          }) =>
              PrayersTableCompanion(
            id: id,
            prayerName: prayerName,
            prayerText: prayerText,
            groupName: groupName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String prayerName,
            required String prayerText,
            required String groupName,
          }) =>
              PrayersTableCompanion.insert(
            id: id,
            prayerName: prayerName,
            prayerText: prayerText,
            groupName: groupName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PrayersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PrayersTableTable,
    PrayersTableData,
    $$PrayersTableTableFilterComposer,
    $$PrayersTableTableOrderingComposer,
    $$PrayersTableTableAnnotationComposer,
    $$PrayersTableTableCreateCompanionBuilder,
    $$PrayersTableTableUpdateCompanionBuilder,
    (
      PrayersTableData,
      BaseReferences<_$AppDatabase, $PrayersTableTable, PrayersTableData>
    ),
    PrayersTableData,
    PrefetchHooks Function()>;
typedef $$InspirationsTableTableCreateCompanionBuilder
    = InspirationsTableCompanion Function({
  Value<int> id,
  required String author,
  required String quote,
});
typedef $$InspirationsTableTableUpdateCompanionBuilder
    = InspirationsTableCompanion Function({
  Value<int> id,
  Value<String> author,
  Value<String> quote,
});

class $$InspirationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InspirationsTableTable> {
  $$InspirationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quote => $composableBuilder(
      column: $table.quote, builder: (column) => ColumnFilters(column));
}

class $$InspirationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InspirationsTableTable> {
  $$InspirationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quote => $composableBuilder(
      column: $table.quote, builder: (column) => ColumnOrderings(column));
}

class $$InspirationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspirationsTableTable> {
  $$InspirationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get quote =>
      $composableBuilder(column: $table.quote, builder: (column) => column);
}

class $$InspirationsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InspirationsTableTable,
    InspirationsTableData,
    $$InspirationsTableTableFilterComposer,
    $$InspirationsTableTableOrderingComposer,
    $$InspirationsTableTableAnnotationComposer,
    $$InspirationsTableTableCreateCompanionBuilder,
    $$InspirationsTableTableUpdateCompanionBuilder,
    (
      InspirationsTableData,
      BaseReferences<_$AppDatabase, $InspirationsTableTable,
          InspirationsTableData>
    ),
    InspirationsTableData,
    PrefetchHooks Function()> {
  $$InspirationsTableTableTableManager(
      _$AppDatabase db, $InspirationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspirationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspirationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspirationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<String> quote = const Value.absent(),
          }) =>
              InspirationsTableCompanion(
            id: id,
            author: author,
            quote: quote,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String author,
            required String quote,
          }) =>
              InspirationsTableCompanion.insert(
            id: id,
            author: author,
            quote: quote,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InspirationsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InspirationsTableTable,
    InspirationsTableData,
    $$InspirationsTableTableFilterComposer,
    $$InspirationsTableTableOrderingComposer,
    $$InspirationsTableTableAnnotationComposer,
    $$InspirationsTableTableCreateCompanionBuilder,
    $$InspirationsTableTableUpdateCompanionBuilder,
    (
      InspirationsTableData,
      BaseReferences<_$AppDatabase, $InspirationsTableTable,
          InspirationsTableData>
    ),
    InspirationsTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CommandmentsTableTableTableManager get commandmentsTable =>
      $$CommandmentsTableTableTableManager(_db, _db.commandmentsTable);
  $$ExaminationsTableTableTableManager get examinationsTable =>
      $$ExaminationsTableTableTableManager(_db, _db.examinationsTable);
  $$GuidesTableTableTableManager get guidesTable =>
      $$GuidesTableTableTableManager(_db, _db.guidesTable);
  $$PrayersTableTableTableManager get prayersTable =>
      $$PrayersTableTableTableManager(_db, _db.prayersTable);
  $$InspirationsTableTableTableManager get inspirationsTable =>
      $$InspirationsTableTableTableManager(_db, _db.inspirationsTable);
}
