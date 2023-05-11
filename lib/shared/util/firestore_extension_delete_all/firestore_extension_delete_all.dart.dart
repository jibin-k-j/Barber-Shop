import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreExtenxionDeleteAllExtension on CollectionReference {
  deleteAll() async {
    var snapshot = await this.get();
    for (var i = 0; i < snapshot.docs.length; i++) {
      var doc = snapshot.docs[i];
      await this.doc(doc.id).delete();
    }
  }

  Future addAll(
    List items, {
    bool deleteAllExistingData = true,
  }) async {
    if (deleteAllExistingData) await this.deleteAll();

    for (var i = 0; i < items.length; i++) {
      var item = items[i];
      await this.add(item);
    }
  }
}
