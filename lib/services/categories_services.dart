import 'package:firebase_auth/firebase_auth.dart';
import 'package:unisocial/models/user.dart';
import 'package:unisocial/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_services.dart';

class CategoriesServices {
  User user;

  CategoriesServices({this.user});

  final AuthService _auth = FirebaseAuthService();
  final databaseReference = Firestore.instance;

  Future<void> createUserRecord(String firstName, String lastName, int day,
      int month, int year, List<String> categoriesList, FirebaseUser user) async {
    final user = await _auth.currentUser();
    await databaseReference.collection("users").document(user.uid).setData({ // TODO: če je inputtan INVALID_EMAIL v Register page-u , potem ta metoda ne bo delovala
      'firstName': firstName,
      'lastName': lastName,
      'age': {
        'day': day,
        'month': month,
        'year': year,
      },
      'categories': []
    });
    for (var i = 0; i < categoriesList.length; i++) {
      addCategoriesToFirestore(categoriesList[i]);
    }
    
  }

  Future<void> addCategoriesToFirestore(String category) async {
    final user = await _auth.currentUser();

    DocumentReference docRef =
        Firestore.instance.collection('users').document(user.uid);
//    DocumentSnapshot doc = await docRef.get();
//    List categories = doc.data['categories'];
    docRef.updateData({
        'categories': FieldValue.arrayUnion([category])
      });

/*     if (categories.contains(category) == true) {
      docRef.updateData({
        'categories': FieldValue.arrayRemove([category])
      });
    } else {
      docRef.updateData({
        'categories': FieldValue.arrayUnion([category])
      });
    } */
  }
}
