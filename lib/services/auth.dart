import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  Future<User?> signUp(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _firestore.collection('webusers').doc(user.user!.uid).set({
      'username': name,
      'email': email,
      'password': password,
      'contact_count': 0,
      'contacts': {},
      'uid': user.user!.uid,
      'subscribe': false,
    });
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }
}
