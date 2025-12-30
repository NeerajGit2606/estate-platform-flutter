import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/models/property.dart';
import '../../shared/enums/property_status.dart';

class PropertyRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collection = 'properties';

  Stream<List<Property>> streamByOwner(String ownerId) {
    return _db
        .collection(_collection)
        .where('ownerId', isEqualTo: ownerId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Property.fromMap(doc.data())).toList(),
        );
  }

  Stream<List<Property>> streamSubmitted() {
    return _db
        .collection(_collection)
        .where('status', isEqualTo: PropertyStatus.submitted.name)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Property.fromMap(doc.data())).toList(),
        );
  }

  Future<void> add(Property property) {
    return _db.collection(_collection).doc(property.id).set(property.toMap());
  }

  Future<void> updateStatus(String id, PropertyStatus status) {
    return _db.collection(_collection).doc(id).update({'status': status.name});
  }

  Stream<List<Property>> streamApprovedForBuyers() {
    return _db
        .collection(_collection)
        .where('status', isEqualTo: PropertyStatus.approved.name)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) =>
                        Property.fromMap(doc.data()),
                  )
                  .toList(),
        );
  }
}
