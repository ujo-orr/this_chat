// repository.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:this_chat/entity.dart';

abstract class LoginRepository {
  Future<LoginEntity?> signIn(String email, String password);
  Future<void> signOut();
}

class FirebaseAuthRepository implements LoginRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Future<LoginEntity?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return LoginEntity(email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
