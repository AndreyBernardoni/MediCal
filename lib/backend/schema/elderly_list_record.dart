import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ElderlyListRecord extends FirestoreRecord {
  ElderlyListRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _email = snapshotData['email'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('elderly_list')
          : FirebaseFirestore.instance.collectionGroup('elderly_list');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('elderly_list').doc();

  static Stream<ElderlyListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ElderlyListRecord.fromSnapshot(s));

  static Future<ElderlyListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ElderlyListRecord.fromSnapshot(s));

  static ElderlyListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ElderlyListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ElderlyListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ElderlyListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ElderlyListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ElderlyListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createElderlyListRecordData({
  String? displayName,
  String? photoUrl,
  String? uid,
  String? email,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'email': email,
    }.withoutNulls,
  );

  return firestoreData;
}

class ElderlyListRecordDocumentEquality implements Equality<ElderlyListRecord> {
  const ElderlyListRecordDocumentEquality();

  @override
  bool equals(ElderlyListRecord? e1, ElderlyListRecord? e2) {
    return e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.email == e2?.email;
  }

  @override
  int hash(ElderlyListRecord? e) => const ListEquality()
      .hash([e?.displayName, e?.photoUrl, e?.uid, e?.email]);

  @override
  bool isValidKey(Object? o) => o is ElderlyListRecord;
}
