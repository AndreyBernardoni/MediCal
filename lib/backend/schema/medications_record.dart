import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MedicationsRecord extends FirestoreRecord {
  MedicationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  // "caregiver" field.
  DocumentReference? _caregiver;
  DocumentReference? get caregiver => _caregiver;
  bool hasCaregiver() => _caregiver != null;

  // "owner" field.
  DocumentReference? _owner;
  DocumentReference? get owner => _owner;
  bool hasOwner() => _owner != null;

  // "schedule_time" field.
  DateTime? _scheduleTime;
  DateTime? get scheduleTime => _scheduleTime;
  bool hasScheduleTime() => _scheduleTime != null;

  // "frequency" field.
  String? _frequency;
  String get frequency => _frequency ?? '';
  bool hasFrequency() => _frequency != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _quantity = castToType<int>(snapshotData['quantity']);
    _caregiver = snapshotData['caregiver'] as DocumentReference?;
    _owner = snapshotData['owner'] as DocumentReference?;
    _scheduleTime = snapshotData['schedule_time'] as DateTime?;
    _frequency = snapshotData['frequency'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('medications');

  static Stream<MedicationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MedicationsRecord.fromSnapshot(s));

  static Future<MedicationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MedicationsRecord.fromSnapshot(s));

  static MedicationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MedicationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MedicationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MedicationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MedicationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MedicationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMedicationsRecordData({
  String? name,
  String? description,
  int? quantity,
  DocumentReference? caregiver,
  DocumentReference? owner,
  DateTime? scheduleTime,
  String? frequency,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'caregiver': caregiver,
      'owner': owner,
      'schedule_time': scheduleTime,
      'frequency': frequency,
    }.withoutNulls,
  );

  return firestoreData;
}

class MedicationsRecordDocumentEquality implements Equality<MedicationsRecord> {
  const MedicationsRecordDocumentEquality();

  @override
  bool equals(MedicationsRecord? e1, MedicationsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.quantity == e2?.quantity &&
        e1?.caregiver == e2?.caregiver &&
        e1?.owner == e2?.owner &&
        e1?.scheduleTime == e2?.scheduleTime &&
        e1?.frequency == e2?.frequency;
  }

  @override
  int hash(MedicationsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.quantity,
        e?.caregiver,
        e?.owner,
        e?.scheduleTime,
        e?.frequency
      ]);

  @override
  bool isValidKey(Object? o) => o is MedicationsRecord;
}
