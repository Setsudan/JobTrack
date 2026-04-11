// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_schemas.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJobApplicationEntityCollection on Isar {
  IsarCollection<JobApplicationEntity> get jobApplicationEntitys =>
      this.collection();
}

const JobApplicationEntitySchema = CollectionSchema(
  name: r'JobApplicationEntity',
  id: -9116029740316421142,
  properties: {
    r'applicationId': PropertySchema(
      id: 0,
      name: r'applicationId',
      type: IsarType.string,
    ),
    r'archiveGroupKey': PropertySchema(
      id: 1,
      name: r'archiveGroupKey',
      type: IsarType.string,
    ),
    r'archiveGroupLabel': PropertySchema(
      id: 2,
      name: r'archiveGroupLabel',
      type: IsarType.string,
    ),
    r'companyName': PropertySchema(
      id: 3,
      name: r'companyName',
      type: IsarType.string,
    ),
    r'isArchived': PropertySchema(
      id: 4,
      name: r'isArchived',
      type: IsarType.bool,
    ),
    r'jobTitle': PropertySchema(
      id: 5,
      name: r'jobTitle',
      type: IsarType.string,
    ),
    r'postingUrl': PropertySchema(
      id: 6,
      name: r'postingUrl',
      type: IsarType.string,
    ),
    r'statusName': PropertySchema(
      id: 7,
      name: r'statusName',
      type: IsarType.string,
    ),
    r'submittedOn': PropertySchema(
      id: 8,
      name: r'submittedOn',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _jobApplicationEntityEstimateSize,
  serialize: _jobApplicationEntitySerialize,
  deserialize: _jobApplicationEntityDeserialize,
  deserializeProp: _jobApplicationEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'applicationId': IndexSchema(
      id: -6637474116175318442,
      name: r'applicationId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'applicationId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _jobApplicationEntityGetId,
  getLinks: _jobApplicationEntityGetLinks,
  attach: _jobApplicationEntityAttach,
  version: '3.1.0+1',
);

int _jobApplicationEntityEstimateSize(
  JobApplicationEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.applicationId.length * 3;
  {
    final value = object.archiveGroupKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.archiveGroupLabel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.companyName.length * 3;
  bytesCount += 3 + object.jobTitle.length * 3;
  bytesCount += 3 + object.postingUrl.length * 3;
  bytesCount += 3 + object.statusName.length * 3;
  return bytesCount;
}

void _jobApplicationEntitySerialize(
  JobApplicationEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.applicationId);
  writer.writeString(offsets[1], object.archiveGroupKey);
  writer.writeString(offsets[2], object.archiveGroupLabel);
  writer.writeString(offsets[3], object.companyName);
  writer.writeBool(offsets[4], object.isArchived);
  writer.writeString(offsets[5], object.jobTitle);
  writer.writeString(offsets[6], object.postingUrl);
  writer.writeString(offsets[7], object.statusName);
  writer.writeDateTime(offsets[8], object.submittedOn);
}

JobApplicationEntity _jobApplicationEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = JobApplicationEntity();
  object.applicationId = reader.readString(offsets[0]);
  object.archiveGroupKey = reader.readStringOrNull(offsets[1]);
  object.archiveGroupLabel = reader.readStringOrNull(offsets[2]);
  object.companyName = reader.readString(offsets[3]);
  object.id = id;
  object.isArchived = reader.readBool(offsets[4]);
  object.jobTitle = reader.readString(offsets[5]);
  object.postingUrl = reader.readString(offsets[6]);
  object.statusName = reader.readString(offsets[7]);
  object.submittedOn = reader.readDateTime(offsets[8]);
  return object;
}

P _jobApplicationEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _jobApplicationEntityGetId(JobApplicationEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _jobApplicationEntityGetLinks(
    JobApplicationEntity object) {
  return [];
}

void _jobApplicationEntityAttach(
    IsarCollection<dynamic> col, Id id, JobApplicationEntity object) {
  object.id = id;
}

extension JobApplicationEntityByIndex on IsarCollection<JobApplicationEntity> {
  Future<JobApplicationEntity?> getByApplicationId(String applicationId) {
    return getByIndex(r'applicationId', [applicationId]);
  }

  JobApplicationEntity? getByApplicationIdSync(String applicationId) {
    return getByIndexSync(r'applicationId', [applicationId]);
  }

  Future<bool> deleteByApplicationId(String applicationId) {
    return deleteByIndex(r'applicationId', [applicationId]);
  }

  bool deleteByApplicationIdSync(String applicationId) {
    return deleteByIndexSync(r'applicationId', [applicationId]);
  }

  Future<List<JobApplicationEntity?>> getAllByApplicationId(
      List<String> applicationIdValues) {
    final values = applicationIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'applicationId', values);
  }

  List<JobApplicationEntity?> getAllByApplicationIdSync(
      List<String> applicationIdValues) {
    final values = applicationIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'applicationId', values);
  }

  Future<int> deleteAllByApplicationId(List<String> applicationIdValues) {
    final values = applicationIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'applicationId', values);
  }

  int deleteAllByApplicationIdSync(List<String> applicationIdValues) {
    final values = applicationIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'applicationId', values);
  }

  Future<Id> putByApplicationId(JobApplicationEntity object) {
    return putByIndex(r'applicationId', object);
  }

  Id putByApplicationIdSync(JobApplicationEntity object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'applicationId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByApplicationId(List<JobApplicationEntity> objects) {
    return putAllByIndex(r'applicationId', objects);
  }

  List<Id> putAllByApplicationIdSync(List<JobApplicationEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'applicationId', objects, saveLinks: saveLinks);
  }
}

extension JobApplicationEntityQueryWhereSort
    on QueryBuilder<JobApplicationEntity, JobApplicationEntity, QWhere> {
  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension JobApplicationEntityQueryWhere
    on QueryBuilder<JobApplicationEntity, JobApplicationEntity, QWhereClause> {
  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterWhereClause>
      applicationIdEqualTo(String applicationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'applicationId',
        value: [applicationId],
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterWhereClause>
      applicationIdNotEqualTo(String applicationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'applicationId',
              lower: [],
              upper: [applicationId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'applicationId',
              lower: [applicationId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'applicationId',
              lower: [applicationId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'applicationId',
              lower: [],
              upper: [applicationId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension JobApplicationEntityQueryFilter on QueryBuilder<JobApplicationEntity,
    JobApplicationEntity, QFilterCondition> {
  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> applicationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> applicationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> applicationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> applicationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'applicationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> applicationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> applicationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      applicationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'applicationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      applicationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'applicationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> applicationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationId',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> applicationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'applicationId',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'archiveGroupKey',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'archiveGroupKey',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'archiveGroupKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'archiveGroupKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'archiveGroupKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'archiveGroupKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'archiveGroupKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'archiveGroupKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      archiveGroupKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'archiveGroupKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      archiveGroupKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'archiveGroupKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'archiveGroupKey',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'archiveGroupKey',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'archiveGroupLabel',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'archiveGroupLabel',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'archiveGroupLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'archiveGroupLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'archiveGroupLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'archiveGroupLabel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'archiveGroupLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'archiveGroupLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      archiveGroupLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'archiveGroupLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      archiveGroupLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'archiveGroupLabel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'archiveGroupLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> archiveGroupLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'archiveGroupLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> companyNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> companyNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> companyNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> companyNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> companyNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> companyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      companyNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      companyNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> companyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> companyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> isArchivedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isArchived',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> jobTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> jobTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> jobTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> jobTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jobTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> jobTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> jobTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      jobTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      jobTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jobTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> jobTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> jobTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jobTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> postingUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postingUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> postingUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'postingUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> postingUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'postingUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> postingUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'postingUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> postingUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'postingUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> postingUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'postingUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      postingUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'postingUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      postingUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'postingUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> postingUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postingUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> postingUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'postingUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> statusNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> statusNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> statusNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> statusNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statusName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> statusNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> statusNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      statusNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
          QAfterFilterCondition>
      statusNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statusName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> statusNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusName',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> statusNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statusName',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> submittedOnEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'submittedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> submittedOnGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'submittedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> submittedOnLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'submittedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity,
      QAfterFilterCondition> submittedOnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'submittedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension JobApplicationEntityQueryObject on QueryBuilder<JobApplicationEntity,
    JobApplicationEntity, QFilterCondition> {}

extension JobApplicationEntityQueryLinks on QueryBuilder<JobApplicationEntity,
    JobApplicationEntity, QFilterCondition> {}

extension JobApplicationEntityQuerySortBy
    on QueryBuilder<JobApplicationEntity, JobApplicationEntity, QSortBy> {
  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByApplicationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByApplicationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByArchiveGroupKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archiveGroupKey', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByArchiveGroupKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archiveGroupKey', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByArchiveGroupLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archiveGroupLabel', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByArchiveGroupLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archiveGroupLabel', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByJobTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByJobTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByPostingUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postingUrl', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByPostingUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postingUrl', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByStatusName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusName', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortByStatusNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusName', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortBySubmittedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submittedOn', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      sortBySubmittedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submittedOn', Sort.desc);
    });
  }
}

extension JobApplicationEntityQuerySortThenBy
    on QueryBuilder<JobApplicationEntity, JobApplicationEntity, QSortThenBy> {
  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByApplicationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByApplicationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationId', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByArchiveGroupKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archiveGroupKey', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByArchiveGroupKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archiveGroupKey', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByArchiveGroupLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archiveGroupLabel', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByArchiveGroupLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archiveGroupLabel', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByJobTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByJobTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByPostingUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postingUrl', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByPostingUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postingUrl', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByStatusName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusName', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenByStatusNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusName', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenBySubmittedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submittedOn', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QAfterSortBy>
      thenBySubmittedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submittedOn', Sort.desc);
    });
  }
}

extension JobApplicationEntityQueryWhereDistinct
    on QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct> {
  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct>
      distinctByApplicationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'applicationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct>
      distinctByArchiveGroupKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'archiveGroupKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct>
      distinctByArchiveGroupLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'archiveGroupLabel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct>
      distinctByCompanyName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct>
      distinctByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isArchived');
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct>
      distinctByJobTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct>
      distinctByPostingUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'postingUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct>
      distinctByStatusName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationEntity, JobApplicationEntity, QDistinct>
      distinctBySubmittedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'submittedOn');
    });
  }
}

extension JobApplicationEntityQueryProperty on QueryBuilder<
    JobApplicationEntity, JobApplicationEntity, QQueryProperty> {
  QueryBuilder<JobApplicationEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<JobApplicationEntity, String, QQueryOperations>
      applicationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applicationId');
    });
  }

  QueryBuilder<JobApplicationEntity, String?, QQueryOperations>
      archiveGroupKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'archiveGroupKey');
    });
  }

  QueryBuilder<JobApplicationEntity, String?, QQueryOperations>
      archiveGroupLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'archiveGroupLabel');
    });
  }

  QueryBuilder<JobApplicationEntity, String, QQueryOperations>
      companyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyName');
    });
  }

  QueryBuilder<JobApplicationEntity, bool, QQueryOperations>
      isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isArchived');
    });
  }

  QueryBuilder<JobApplicationEntity, String, QQueryOperations>
      jobTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobTitle');
    });
  }

  QueryBuilder<JobApplicationEntity, String, QQueryOperations>
      postingUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'postingUrl');
    });
  }

  QueryBuilder<JobApplicationEntity, String, QQueryOperations>
      statusNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusName');
    });
  }

  QueryBuilder<JobApplicationEntity, DateTime, QQueryOperations>
      submittedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'submittedOn');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppSettingsEntityCollection on Isar {
  IsarCollection<AppSettingsEntity> get appSettingsEntitys => this.collection();
}

const AppSettingsEntitySchema = CollectionSchema(
  name: r'AppSettingsEntity',
  id: 5506238605616873742,
  properties: {
    r'appBackgroundImageFileName': PropertySchema(
      id: 0,
      name: r'appBackgroundImageFileName',
      type: IsarType.string,
    ),
    r'appBackgroundKind': PropertySchema(
      id: 1,
      name: r'appBackgroundKind',
      type: IsarType.string,
    ),
    r'appBackgroundPresetId': PropertySchema(
      id: 2,
      name: r'appBackgroundPresetId',
      type: IsarType.string,
    ),
    r'languageCode': PropertySchema(
      id: 3,
      name: r'languageCode',
      type: IsarType.string,
    ),
    r'rowKey': PropertySchema(
      id: 4,
      name: r'rowKey',
      type: IsarType.string,
    ),
    r'swipeEndPane': PropertySchema(
      id: 5,
      name: r'swipeEndPane',
      type: IsarType.string,
    ),
    r'swipeStartPane': PropertySchema(
      id: 6,
      name: r'swipeStartPane',
      type: IsarType.string,
    ),
    r'themeMode': PropertySchema(
      id: 7,
      name: r'themeMode',
      type: IsarType.string,
    ),
    r'waitingFollowUpDays': PropertySchema(
      id: 8,
      name: r'waitingFollowUpDays',
      type: IsarType.long,
    )
  },
  estimateSize: _appSettingsEntityEstimateSize,
  serialize: _appSettingsEntitySerialize,
  deserialize: _appSettingsEntityDeserialize,
  deserializeProp: _appSettingsEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'rowKey': IndexSchema(
      id: -4629187292167891774,
      name: r'rowKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'rowKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _appSettingsEntityGetId,
  getLinks: _appSettingsEntityGetLinks,
  attach: _appSettingsEntityAttach,
  version: '3.1.0+1',
);

int _appSettingsEntityEstimateSize(
  AppSettingsEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.appBackgroundImageFileName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.appBackgroundKind;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.appBackgroundPresetId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.languageCode.length * 3;
  bytesCount += 3 + object.rowKey.length * 3;
  bytesCount += 3 + object.swipeEndPane.length * 3;
  bytesCount += 3 + object.swipeStartPane.length * 3;
  bytesCount += 3 + object.themeMode.length * 3;
  return bytesCount;
}

void _appSettingsEntitySerialize(
  AppSettingsEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appBackgroundImageFileName);
  writer.writeString(offsets[1], object.appBackgroundKind);
  writer.writeString(offsets[2], object.appBackgroundPresetId);
  writer.writeString(offsets[3], object.languageCode);
  writer.writeString(offsets[4], object.rowKey);
  writer.writeString(offsets[5], object.swipeEndPane);
  writer.writeString(offsets[6], object.swipeStartPane);
  writer.writeString(offsets[7], object.themeMode);
  writer.writeLong(offsets[8], object.waitingFollowUpDays);
}

AppSettingsEntity _appSettingsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettingsEntity();
  object.appBackgroundImageFileName = reader.readStringOrNull(offsets[0]);
  object.appBackgroundKind = reader.readStringOrNull(offsets[1]);
  object.appBackgroundPresetId = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.languageCode = reader.readString(offsets[3]);
  object.rowKey = reader.readString(offsets[4]);
  object.swipeEndPane = reader.readString(offsets[5]);
  object.swipeStartPane = reader.readString(offsets[6]);
  object.themeMode = reader.readString(offsets[7]);
  object.waitingFollowUpDays = reader.readLong(offsets[8]);
  return object;
}

P _appSettingsEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appSettingsEntityGetId(AppSettingsEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingsEntityGetLinks(
    AppSettingsEntity object) {
  return [];
}

void _appSettingsEntityAttach(
    IsarCollection<dynamic> col, Id id, AppSettingsEntity object) {
  object.id = id;
}

extension AppSettingsEntityByIndex on IsarCollection<AppSettingsEntity> {
  Future<AppSettingsEntity?> getByRowKey(String rowKey) {
    return getByIndex(r'rowKey', [rowKey]);
  }

  AppSettingsEntity? getByRowKeySync(String rowKey) {
    return getByIndexSync(r'rowKey', [rowKey]);
  }

  Future<bool> deleteByRowKey(String rowKey) {
    return deleteByIndex(r'rowKey', [rowKey]);
  }

  bool deleteByRowKeySync(String rowKey) {
    return deleteByIndexSync(r'rowKey', [rowKey]);
  }

  Future<List<AppSettingsEntity?>> getAllByRowKey(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'rowKey', values);
  }

  List<AppSettingsEntity?> getAllByRowKeySync(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'rowKey', values);
  }

  Future<int> deleteAllByRowKey(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'rowKey', values);
  }

  int deleteAllByRowKeySync(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'rowKey', values);
  }

  Future<Id> putByRowKey(AppSettingsEntity object) {
    return putByIndex(r'rowKey', object);
  }

  Id putByRowKeySync(AppSettingsEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'rowKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRowKey(List<AppSettingsEntity> objects) {
    return putAllByIndex(r'rowKey', objects);
  }

  List<Id> putAllByRowKeySync(List<AppSettingsEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rowKey', objects, saveLinks: saveLinks);
  }
}

extension AppSettingsEntityQueryWhereSort
    on QueryBuilder<AppSettingsEntity, AppSettingsEntity, QWhere> {
  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingsEntityQueryWhere
    on QueryBuilder<AppSettingsEntity, AppSettingsEntity, QWhereClause> {
  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterWhereClause>
      rowKeyEqualTo(String rowKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rowKey',
        value: [rowKey],
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterWhereClause>
      rowKeyNotEqualTo(String rowKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [],
              upper: [rowKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [rowKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [rowKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [],
              upper: [rowKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AppSettingsEntityQueryFilter
    on QueryBuilder<AppSettingsEntity, AppSettingsEntity, QFilterCondition> {
  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'appBackgroundImageFileName',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'appBackgroundImageFileName',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appBackgroundImageFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appBackgroundImageFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appBackgroundImageFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appBackgroundImageFileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appBackgroundImageFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appBackgroundImageFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appBackgroundImageFileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appBackgroundImageFileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appBackgroundImageFileName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundImageFileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appBackgroundImageFileName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'appBackgroundKind',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'appBackgroundKind',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appBackgroundKind',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appBackgroundKind',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appBackgroundKind',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appBackgroundKind',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appBackgroundKind',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appBackgroundKind',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appBackgroundKind',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appBackgroundKind',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appBackgroundKind',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundKindIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appBackgroundKind',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'appBackgroundPresetId',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'appBackgroundPresetId',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appBackgroundPresetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appBackgroundPresetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appBackgroundPresetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appBackgroundPresetId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appBackgroundPresetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appBackgroundPresetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appBackgroundPresetId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appBackgroundPresetId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appBackgroundPresetId',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      appBackgroundPresetIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appBackgroundPresetId',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'languageCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'languageCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      languageCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'languageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rowKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rowKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowKey',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      rowKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rowKey',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'swipeEndPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'swipeEndPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'swipeEndPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'swipeEndPane',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'swipeEndPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'swipeEndPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'swipeEndPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'swipeEndPane',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'swipeEndPane',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeEndPaneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'swipeEndPane',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'swipeStartPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'swipeStartPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'swipeStartPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'swipeStartPane',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'swipeStartPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'swipeStartPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'swipeStartPane',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'swipeStartPane',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'swipeStartPane',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      swipeStartPaneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'swipeStartPane',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themeMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'themeMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      themeModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'themeMode',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      waitingFollowUpDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waitingFollowUpDays',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      waitingFollowUpDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waitingFollowUpDays',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      waitingFollowUpDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waitingFollowUpDays',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterFilterCondition>
      waitingFollowUpDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waitingFollowUpDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppSettingsEntityQueryObject
    on QueryBuilder<AppSettingsEntity, AppSettingsEntity, QFilterCondition> {}

extension AppSettingsEntityQueryLinks
    on QueryBuilder<AppSettingsEntity, AppSettingsEntity, QFilterCondition> {}

extension AppSettingsEntityQuerySortBy
    on QueryBuilder<AppSettingsEntity, AppSettingsEntity, QSortBy> {
  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByAppBackgroundImageFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundImageFileName', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByAppBackgroundImageFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundImageFileName', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByAppBackgroundKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundKind', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByAppBackgroundKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundKind', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByAppBackgroundPresetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundPresetId', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByAppBackgroundPresetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundPresetId', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByRowKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByRowKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortBySwipeEndPane() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'swipeEndPane', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortBySwipeEndPaneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'swipeEndPane', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortBySwipeStartPane() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'swipeStartPane', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortBySwipeStartPaneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'swipeStartPane', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByWaitingFollowUpDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waitingFollowUpDays', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      sortByWaitingFollowUpDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waitingFollowUpDays', Sort.desc);
    });
  }
}

extension AppSettingsEntityQuerySortThenBy
    on QueryBuilder<AppSettingsEntity, AppSettingsEntity, QSortThenBy> {
  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByAppBackgroundImageFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundImageFileName', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByAppBackgroundImageFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundImageFileName', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByAppBackgroundKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundKind', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByAppBackgroundKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundKind', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByAppBackgroundPresetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundPresetId', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByAppBackgroundPresetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appBackgroundPresetId', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByRowKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByRowKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenBySwipeEndPane() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'swipeEndPane', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenBySwipeEndPaneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'swipeEndPane', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenBySwipeStartPane() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'swipeStartPane', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenBySwipeStartPaneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'swipeStartPane', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByWaitingFollowUpDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waitingFollowUpDays', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QAfterSortBy>
      thenByWaitingFollowUpDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waitingFollowUpDays', Sort.desc);
    });
  }
}

extension AppSettingsEntityQueryWhereDistinct
    on QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct> {
  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct>
      distinctByAppBackgroundImageFileName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appBackgroundImageFileName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct>
      distinctByAppBackgroundKind({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appBackgroundKind',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct>
      distinctByAppBackgroundPresetId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appBackgroundPresetId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct>
      distinctByLanguageCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'languageCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct>
      distinctByRowKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rowKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct>
      distinctBySwipeEndPane({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'swipeEndPane', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct>
      distinctBySwipeStartPane({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'swipeStartPane',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct>
      distinctByThemeMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsEntity, AppSettingsEntity, QDistinct>
      distinctByWaitingFollowUpDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waitingFollowUpDays');
    });
  }
}

extension AppSettingsEntityQueryProperty
    on QueryBuilder<AppSettingsEntity, AppSettingsEntity, QQueryProperty> {
  QueryBuilder<AppSettingsEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettingsEntity, String?, QQueryOperations>
      appBackgroundImageFileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appBackgroundImageFileName');
    });
  }

  QueryBuilder<AppSettingsEntity, String?, QQueryOperations>
      appBackgroundKindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appBackgroundKind');
    });
  }

  QueryBuilder<AppSettingsEntity, String?, QQueryOperations>
      appBackgroundPresetIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appBackgroundPresetId');
    });
  }

  QueryBuilder<AppSettingsEntity, String, QQueryOperations>
      languageCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'languageCode');
    });
  }

  QueryBuilder<AppSettingsEntity, String, QQueryOperations> rowKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rowKey');
    });
  }

  QueryBuilder<AppSettingsEntity, String, QQueryOperations>
      swipeEndPaneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'swipeEndPane');
    });
  }

  QueryBuilder<AppSettingsEntity, String, QQueryOperations>
      swipeStartPaneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'swipeStartPane');
    });
  }

  QueryBuilder<AppSettingsEntity, String, QQueryOperations>
      themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeMode');
    });
  }

  QueryBuilder<AppSettingsEntity, int, QQueryOperations>
      waitingFollowUpDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waitingFollowUpDays');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserProfileEntityCollection on Isar {
  IsarCollection<UserProfileEntity> get userProfileEntitys => this.collection();
}

const UserProfileEntitySchema = CollectionSchema(
  name: r'UserProfileEntity',
  id: -588086384777568406,
  properties: {
    r'profileJson': PropertySchema(
      id: 0,
      name: r'profileJson',
      type: IsarType.string,
    ),
    r'rowKey': PropertySchema(
      id: 1,
      name: r'rowKey',
      type: IsarType.string,
    )
  },
  estimateSize: _userProfileEntityEstimateSize,
  serialize: _userProfileEntitySerialize,
  deserialize: _userProfileEntityDeserialize,
  deserializeProp: _userProfileEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'rowKey': IndexSchema(
      id: -4629187292167891774,
      name: r'rowKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'rowKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userProfileEntityGetId,
  getLinks: _userProfileEntityGetLinks,
  attach: _userProfileEntityAttach,
  version: '3.1.0+1',
);

int _userProfileEntityEstimateSize(
  UserProfileEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.profileJson.length * 3;
  bytesCount += 3 + object.rowKey.length * 3;
  return bytesCount;
}

void _userProfileEntitySerialize(
  UserProfileEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.profileJson);
  writer.writeString(offsets[1], object.rowKey);
}

UserProfileEntity _userProfileEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserProfileEntity();
  object.id = id;
  object.profileJson = reader.readString(offsets[0]);
  object.rowKey = reader.readString(offsets[1]);
  return object;
}

P _userProfileEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userProfileEntityGetId(UserProfileEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userProfileEntityGetLinks(
    UserProfileEntity object) {
  return [];
}

void _userProfileEntityAttach(
    IsarCollection<dynamic> col, Id id, UserProfileEntity object) {
  object.id = id;
}

extension UserProfileEntityByIndex on IsarCollection<UserProfileEntity> {
  Future<UserProfileEntity?> getByRowKey(String rowKey) {
    return getByIndex(r'rowKey', [rowKey]);
  }

  UserProfileEntity? getByRowKeySync(String rowKey) {
    return getByIndexSync(r'rowKey', [rowKey]);
  }

  Future<bool> deleteByRowKey(String rowKey) {
    return deleteByIndex(r'rowKey', [rowKey]);
  }

  bool deleteByRowKeySync(String rowKey) {
    return deleteByIndexSync(r'rowKey', [rowKey]);
  }

  Future<List<UserProfileEntity?>> getAllByRowKey(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'rowKey', values);
  }

  List<UserProfileEntity?> getAllByRowKeySync(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'rowKey', values);
  }

  Future<int> deleteAllByRowKey(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'rowKey', values);
  }

  int deleteAllByRowKeySync(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'rowKey', values);
  }

  Future<Id> putByRowKey(UserProfileEntity object) {
    return putByIndex(r'rowKey', object);
  }

  Id putByRowKeySync(UserProfileEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'rowKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRowKey(List<UserProfileEntity> objects) {
    return putAllByIndex(r'rowKey', objects);
  }

  List<Id> putAllByRowKeySync(List<UserProfileEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rowKey', objects, saveLinks: saveLinks);
  }
}

extension UserProfileEntityQueryWhereSort
    on QueryBuilder<UserProfileEntity, UserProfileEntity, QWhere> {
  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserProfileEntityQueryWhere
    on QueryBuilder<UserProfileEntity, UserProfileEntity, QWhereClause> {
  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterWhereClause>
      rowKeyEqualTo(String rowKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rowKey',
        value: [rowKey],
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterWhereClause>
      rowKeyNotEqualTo(String rowKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [],
              upper: [rowKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [rowKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [rowKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [],
              upper: [rowKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserProfileEntityQueryFilter
    on QueryBuilder<UserProfileEntity, UserProfileEntity, QFilterCondition> {
  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileJson',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      profileJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileJson',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rowKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rowKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterFilterCondition>
      rowKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rowKey',
        value: '',
      ));
    });
  }
}

extension UserProfileEntityQueryObject
    on QueryBuilder<UserProfileEntity, UserProfileEntity, QFilterCondition> {}

extension UserProfileEntityQueryLinks
    on QueryBuilder<UserProfileEntity, UserProfileEntity, QFilterCondition> {}

extension UserProfileEntityQuerySortBy
    on QueryBuilder<UserProfileEntity, UserProfileEntity, QSortBy> {
  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy>
      sortByProfileJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileJson', Sort.asc);
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy>
      sortByProfileJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileJson', Sort.desc);
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy>
      sortByRowKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.asc);
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy>
      sortByRowKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.desc);
    });
  }
}

extension UserProfileEntityQuerySortThenBy
    on QueryBuilder<UserProfileEntity, UserProfileEntity, QSortThenBy> {
  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy>
      thenByProfileJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileJson', Sort.asc);
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy>
      thenByProfileJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileJson', Sort.desc);
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy>
      thenByRowKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.asc);
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QAfterSortBy>
      thenByRowKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.desc);
    });
  }
}

extension UserProfileEntityQueryWhereDistinct
    on QueryBuilder<UserProfileEntity, UserProfileEntity, QDistinct> {
  QueryBuilder<UserProfileEntity, UserProfileEntity, QDistinct>
      distinctByProfileJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfileEntity, UserProfileEntity, QDistinct>
      distinctByRowKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rowKey', caseSensitive: caseSensitive);
    });
  }
}

extension UserProfileEntityQueryProperty
    on QueryBuilder<UserProfileEntity, UserProfileEntity, QQueryProperty> {
  QueryBuilder<UserProfileEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserProfileEntity, String, QQueryOperations>
      profileJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileJson');
    });
  }

  QueryBuilder<UserProfileEntity, String, QQueryOperations> rowKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rowKey');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNotificationStateEntityCollection on Isar {
  IsarCollection<NotificationStateEntity> get notificationStateEntitys =>
      this.collection();
}

const NotificationStateEntitySchema = CollectionSchema(
  name: r'NotificationStateEntity',
  id: 3944597428543894059,
  properties: {
    r'draftTrackedNotificationIds': PropertySchema(
      id: 0,
      name: r'draftTrackedNotificationIds',
      type: IsarType.longList,
    ),
    r'rowKey': PropertySchema(
      id: 1,
      name: r'rowKey',
      type: IsarType.string,
    ),
    r'waitingTrackedNotificationIds': PropertySchema(
      id: 2,
      name: r'waitingTrackedNotificationIds',
      type: IsarType.longList,
    )
  },
  estimateSize: _notificationStateEntityEstimateSize,
  serialize: _notificationStateEntitySerialize,
  deserialize: _notificationStateEntityDeserialize,
  deserializeProp: _notificationStateEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'rowKey': IndexSchema(
      id: -4629187292167891774,
      name: r'rowKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'rowKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _notificationStateEntityGetId,
  getLinks: _notificationStateEntityGetLinks,
  attach: _notificationStateEntityAttach,
  version: '3.1.0+1',
);

int _notificationStateEntityEstimateSize(
  NotificationStateEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.draftTrackedNotificationIds.length * 8;
  bytesCount += 3 + object.rowKey.length * 3;
  bytesCount += 3 + object.waitingTrackedNotificationIds.length * 8;
  return bytesCount;
}

void _notificationStateEntitySerialize(
  NotificationStateEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.draftTrackedNotificationIds);
  writer.writeString(offsets[1], object.rowKey);
  writer.writeLongList(offsets[2], object.waitingTrackedNotificationIds);
}

NotificationStateEntity _notificationStateEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotificationStateEntity();
  object.draftTrackedNotificationIds = reader.readLongList(offsets[0]) ?? [];
  object.id = id;
  object.rowKey = reader.readString(offsets[1]);
  object.waitingTrackedNotificationIds = reader.readLongList(offsets[2]) ?? [];
  return object;
}

P _notificationStateEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _notificationStateEntityGetId(NotificationStateEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _notificationStateEntityGetLinks(
    NotificationStateEntity object) {
  return [];
}

void _notificationStateEntityAttach(
    IsarCollection<dynamic> col, Id id, NotificationStateEntity object) {
  object.id = id;
}

extension NotificationStateEntityByIndex
    on IsarCollection<NotificationStateEntity> {
  Future<NotificationStateEntity?> getByRowKey(String rowKey) {
    return getByIndex(r'rowKey', [rowKey]);
  }

  NotificationStateEntity? getByRowKeySync(String rowKey) {
    return getByIndexSync(r'rowKey', [rowKey]);
  }

  Future<bool> deleteByRowKey(String rowKey) {
    return deleteByIndex(r'rowKey', [rowKey]);
  }

  bool deleteByRowKeySync(String rowKey) {
    return deleteByIndexSync(r'rowKey', [rowKey]);
  }

  Future<List<NotificationStateEntity?>> getAllByRowKey(
      List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'rowKey', values);
  }

  List<NotificationStateEntity?> getAllByRowKeySync(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'rowKey', values);
  }

  Future<int> deleteAllByRowKey(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'rowKey', values);
  }

  int deleteAllByRowKeySync(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'rowKey', values);
  }

  Future<Id> putByRowKey(NotificationStateEntity object) {
    return putByIndex(r'rowKey', object);
  }

  Id putByRowKeySync(NotificationStateEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'rowKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRowKey(List<NotificationStateEntity> objects) {
    return putAllByIndex(r'rowKey', objects);
  }

  List<Id> putAllByRowKeySync(List<NotificationStateEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rowKey', objects, saveLinks: saveLinks);
  }
}

extension NotificationStateEntityQueryWhereSort
    on QueryBuilder<NotificationStateEntity, NotificationStateEntity, QWhere> {
  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NotificationStateEntityQueryWhere on QueryBuilder<
    NotificationStateEntity, NotificationStateEntity, QWhereClause> {
  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterWhereClause> rowKeyEqualTo(String rowKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rowKey',
        value: [rowKey],
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterWhereClause> rowKeyNotEqualTo(String rowKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [],
              upper: [rowKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [rowKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [rowKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [],
              upper: [rowKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension NotificationStateEntityQueryFilter on QueryBuilder<
    NotificationStateEntity, NotificationStateEntity, QFilterCondition> {
  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
          QAfterFilterCondition>
      draftTrackedNotificationIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'draftTrackedNotificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> draftTrackedNotificationIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'draftTrackedNotificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> draftTrackedNotificationIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'draftTrackedNotificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> draftTrackedNotificationIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'draftTrackedNotificationIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
          QAfterFilterCondition>
      draftTrackedNotificationIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftTrackedNotificationIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> draftTrackedNotificationIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftTrackedNotificationIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> draftTrackedNotificationIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftTrackedNotificationIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> draftTrackedNotificationIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftTrackedNotificationIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> draftTrackedNotificationIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftTrackedNotificationIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> draftTrackedNotificationIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'draftTrackedNotificationIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> rowKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> rowKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> rowKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> rowKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rowKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> rowKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> rowKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
          QAfterFilterCondition>
      rowKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
          QAfterFilterCondition>
      rowKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rowKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> rowKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowKey',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> rowKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rowKey',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
          QAfterFilterCondition>
      waitingTrackedNotificationIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waitingTrackedNotificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> waitingTrackedNotificationIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waitingTrackedNotificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> waitingTrackedNotificationIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waitingTrackedNotificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> waitingTrackedNotificationIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waitingTrackedNotificationIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
          QAfterFilterCondition>
      waitingTrackedNotificationIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waitingTrackedNotificationIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> waitingTrackedNotificationIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waitingTrackedNotificationIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> waitingTrackedNotificationIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waitingTrackedNotificationIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> waitingTrackedNotificationIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waitingTrackedNotificationIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> waitingTrackedNotificationIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waitingTrackedNotificationIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity,
      QAfterFilterCondition> waitingTrackedNotificationIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waitingTrackedNotificationIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension NotificationStateEntityQueryObject on QueryBuilder<
    NotificationStateEntity, NotificationStateEntity, QFilterCondition> {}

extension NotificationStateEntityQueryLinks on QueryBuilder<
    NotificationStateEntity, NotificationStateEntity, QFilterCondition> {}

extension NotificationStateEntityQuerySortBy
    on QueryBuilder<NotificationStateEntity, NotificationStateEntity, QSortBy> {
  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QAfterSortBy>
      sortByRowKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.asc);
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QAfterSortBy>
      sortByRowKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.desc);
    });
  }
}

extension NotificationStateEntityQuerySortThenBy on QueryBuilder<
    NotificationStateEntity, NotificationStateEntity, QSortThenBy> {
  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QAfterSortBy>
      thenByRowKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.asc);
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QAfterSortBy>
      thenByRowKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.desc);
    });
  }
}

extension NotificationStateEntityQueryWhereDistinct on QueryBuilder<
    NotificationStateEntity, NotificationStateEntity, QDistinct> {
  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QDistinct>
      distinctByDraftTrackedNotificationIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'draftTrackedNotificationIds');
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QDistinct>
      distinctByRowKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rowKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationStateEntity, NotificationStateEntity, QDistinct>
      distinctByWaitingTrackedNotificationIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waitingTrackedNotificationIds');
    });
  }
}

extension NotificationStateEntityQueryProperty on QueryBuilder<
    NotificationStateEntity, NotificationStateEntity, QQueryProperty> {
  QueryBuilder<NotificationStateEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NotificationStateEntity, List<int>, QQueryOperations>
      draftTrackedNotificationIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'draftTrackedNotificationIds');
    });
  }

  QueryBuilder<NotificationStateEntity, String, QQueryOperations>
      rowKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rowKey');
    });
  }

  QueryBuilder<NotificationStateEntity, List<int>, QQueryOperations>
      waitingTrackedNotificationIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waitingTrackedNotificationIds');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppMetaEntityCollection on Isar {
  IsarCollection<AppMetaEntity> get appMetaEntitys => this.collection();
}

const AppMetaEntitySchema = CollectionSchema(
  name: r'AppMetaEntity',
  id: 4798171179488078482,
  properties: {
    r'prefsMigrationV1Complete': PropertySchema(
      id: 0,
      name: r'prefsMigrationV1Complete',
      type: IsarType.bool,
    ),
    r'rowKey': PropertySchema(
      id: 1,
      name: r'rowKey',
      type: IsarType.string,
    )
  },
  estimateSize: _appMetaEntityEstimateSize,
  serialize: _appMetaEntitySerialize,
  deserialize: _appMetaEntityDeserialize,
  deserializeProp: _appMetaEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'rowKey': IndexSchema(
      id: -4629187292167891774,
      name: r'rowKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'rowKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _appMetaEntityGetId,
  getLinks: _appMetaEntityGetLinks,
  attach: _appMetaEntityAttach,
  version: '3.1.0+1',
);

int _appMetaEntityEstimateSize(
  AppMetaEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.rowKey.length * 3;
  return bytesCount;
}

void _appMetaEntitySerialize(
  AppMetaEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.prefsMigrationV1Complete);
  writer.writeString(offsets[1], object.rowKey);
}

AppMetaEntity _appMetaEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppMetaEntity();
  object.id = id;
  object.prefsMigrationV1Complete = reader.readBool(offsets[0]);
  object.rowKey = reader.readString(offsets[1]);
  return object;
}

P _appMetaEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appMetaEntityGetId(AppMetaEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appMetaEntityGetLinks(AppMetaEntity object) {
  return [];
}

void _appMetaEntityAttach(
    IsarCollection<dynamic> col, Id id, AppMetaEntity object) {
  object.id = id;
}

extension AppMetaEntityByIndex on IsarCollection<AppMetaEntity> {
  Future<AppMetaEntity?> getByRowKey(String rowKey) {
    return getByIndex(r'rowKey', [rowKey]);
  }

  AppMetaEntity? getByRowKeySync(String rowKey) {
    return getByIndexSync(r'rowKey', [rowKey]);
  }

  Future<bool> deleteByRowKey(String rowKey) {
    return deleteByIndex(r'rowKey', [rowKey]);
  }

  bool deleteByRowKeySync(String rowKey) {
    return deleteByIndexSync(r'rowKey', [rowKey]);
  }

  Future<List<AppMetaEntity?>> getAllByRowKey(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'rowKey', values);
  }

  List<AppMetaEntity?> getAllByRowKeySync(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'rowKey', values);
  }

  Future<int> deleteAllByRowKey(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'rowKey', values);
  }

  int deleteAllByRowKeySync(List<String> rowKeyValues) {
    final values = rowKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'rowKey', values);
  }

  Future<Id> putByRowKey(AppMetaEntity object) {
    return putByIndex(r'rowKey', object);
  }

  Id putByRowKeySync(AppMetaEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'rowKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRowKey(List<AppMetaEntity> objects) {
    return putAllByIndex(r'rowKey', objects);
  }

  List<Id> putAllByRowKeySync(List<AppMetaEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'rowKey', objects, saveLinks: saveLinks);
  }
}

extension AppMetaEntityQueryWhereSort
    on QueryBuilder<AppMetaEntity, AppMetaEntity, QWhere> {
  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppMetaEntityQueryWhere
    on QueryBuilder<AppMetaEntity, AppMetaEntity, QWhereClause> {
  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterWhereClause> rowKeyEqualTo(
      String rowKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rowKey',
        value: [rowKey],
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterWhereClause>
      rowKeyNotEqualTo(String rowKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [],
              upper: [rowKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [rowKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [rowKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rowKey',
              lower: [],
              upper: [rowKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AppMetaEntityQueryFilter
    on QueryBuilder<AppMetaEntity, AppMetaEntity, QFilterCondition> {
  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      prefsMigrationV1CompleteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prefsMigrationV1Complete',
        value: value,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rowKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rowKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rowKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowKey',
        value: '',
      ));
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterFilterCondition>
      rowKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rowKey',
        value: '',
      ));
    });
  }
}

extension AppMetaEntityQueryObject
    on QueryBuilder<AppMetaEntity, AppMetaEntity, QFilterCondition> {}

extension AppMetaEntityQueryLinks
    on QueryBuilder<AppMetaEntity, AppMetaEntity, QFilterCondition> {}

extension AppMetaEntityQuerySortBy
    on QueryBuilder<AppMetaEntity, AppMetaEntity, QSortBy> {
  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy>
      sortByPrefsMigrationV1Complete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prefsMigrationV1Complete', Sort.asc);
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy>
      sortByPrefsMigrationV1CompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prefsMigrationV1Complete', Sort.desc);
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy> sortByRowKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.asc);
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy> sortByRowKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.desc);
    });
  }
}

extension AppMetaEntityQuerySortThenBy
    on QueryBuilder<AppMetaEntity, AppMetaEntity, QSortThenBy> {
  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy>
      thenByPrefsMigrationV1Complete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prefsMigrationV1Complete', Sort.asc);
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy>
      thenByPrefsMigrationV1CompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prefsMigrationV1Complete', Sort.desc);
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy> thenByRowKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.asc);
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QAfterSortBy> thenByRowKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowKey', Sort.desc);
    });
  }
}

extension AppMetaEntityQueryWhereDistinct
    on QueryBuilder<AppMetaEntity, AppMetaEntity, QDistinct> {
  QueryBuilder<AppMetaEntity, AppMetaEntity, QDistinct>
      distinctByPrefsMigrationV1Complete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prefsMigrationV1Complete');
    });
  }

  QueryBuilder<AppMetaEntity, AppMetaEntity, QDistinct> distinctByRowKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rowKey', caseSensitive: caseSensitive);
    });
  }
}

extension AppMetaEntityQueryProperty
    on QueryBuilder<AppMetaEntity, AppMetaEntity, QQueryProperty> {
  QueryBuilder<AppMetaEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppMetaEntity, bool, QQueryOperations>
      prefsMigrationV1CompleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prefsMigrationV1Complete');
    });
  }

  QueryBuilder<AppMetaEntity, String, QQueryOperations> rowKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rowKey');
    });
  }
}
