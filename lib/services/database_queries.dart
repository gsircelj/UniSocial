import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final databaseReference = Firestore.instance;

  void createCollection(String nameOfCollection) {
    databaseReference.collection(nameOfCollection);
  }

  void createDocument(String nameOfCollection, String nameOfRecord) {
    databaseReference.collection(nameOfCollection).document(nameOfRecord);
  }

  void setData(String nameOfCollection, String nameOfRecord, String nameOfTitle) async {
    /* await databaseReference.collection(nameOfCollection).document(nameOfRecord).setData({'tag'}); */
    DocumentReference docRef = Firestore.instance.collection(nameOfCollection).document(nameOfRecord);
    DocumentSnapshot doc = await docRef.get();
    List categories = doc.data['categories'];

/*     if(categories.contains(category) == true) {
      docRef.updateData({'categories' : FieldValue.arrayRemove([category])});
    }
    else {
      docRef.updateData({'categories' : FieldValue.arrayUnion([category])});
    } */
  }
}
