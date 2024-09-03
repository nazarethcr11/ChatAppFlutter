import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  //instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign in with email and password

  //get current user
  User? getCurrentUser(){
    return _auth.currentUser;
  }


  Future<UserCredential> signInWithEmailAndPassword(String email, password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      //save user if it doesn't exist
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
  //register with email and password
  Future<UserCredential> registerWithEmailAndPassword(String email, password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //save user info in a separate doc
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
  //sign out
  Future<void> signOut() async{
    await _auth.signOut();
  }
  //delete account
  Future<void> deleteAccount() async{
    //firebase firestore delete user and chat room
    await _firestore.collection('ChatRooms').doc(_auth.currentUser!.uid).delete();
    await _firestore.collection('Users').doc(_auth.currentUser!.uid).delete();
    //firebase auth delete
    await _auth.currentUser!.delete();
    await _auth.signOut();
  }
}
