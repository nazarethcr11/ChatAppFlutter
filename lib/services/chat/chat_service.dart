import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../models/message.dart';

class ChatService extends ChangeNotifier{
  //get instance of firestore & firebase auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //GET ALL USERS STREAM
  Stream<List<Map<String,dynamic>>> getUserStream(){
    return _firestore.collection('Users').snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        //go through each individual user
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //GET ALL USERS EXCEPT BLOCKED USERS
  Stream<List<Map<String,dynamic>>> getUsersStreamExcludingBlocked(){
    final currentUser = _auth.currentUser;

    return _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
          //get blocked users ids
          final blockedUsersIds = snapshot.docs.map((doc) => doc.id).toList();
          //get all users
          final usersSnapshot = await _firestore.collection('Users').get();
          //return as a stream list, excluding blocked users and current user
          return usersSnapshot.docs
              .where((doc) =>
                doc.data()['email'] != currentUser.email &&
                !blockedUsersIds.contains(doc.id))
              .map((doc) => doc.data())
              .toList();
    });
  }

  //SEND MESSAGE
  Future<void> sendMessage(String receiverID, message) async{
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );
    //construct chat room id for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the ids (this ensure that chatroomID is the same for any two users)
    String chatRoomID = ids.join('_');
    //save message into the database
    await _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').add(newMessage.toMap());
  }

  //GET MESSAGES
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    //construct chat room id for the two users (sorted to ensure uniqueness)
    List<String> ids = [userID, otherUserID];
    ids.sort(); //sort the ids (this ensure that chatroomID is the same for any two users)
    String chatRoomID = ids.join('_');
    return _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').orderBy('timestamp',descending: false).snapshots();
  }

  //REPORT USER
  Future<void> reportUser(String messageId, String userId)async{
    final currentUser = _auth.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp()
    };
    await _firestore.collection('Reports').add(report);
  }

  //BLOCK USER
  Future<void> blockUser(String userId)async{
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(userId)
        .set({});
    notifyListeners();
  }

  //UNBLOCK USER
  Future<void> unblockUser(String blockedUserId)async{
    final currentUser = _auth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(blockedUserId)
        .delete();
    notifyListeners();
  }

  //GET BLOCKED USERS
  Stream <List<Map<String,dynamic>>> getBlockedUsersStream(String userId) {
    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot)async{
          //get a list of blocked users ids
          final blockedUsersIds = snapshot.docs.map((doc)=>doc.id).toList();
          //get the user documents
          final userDocs = await Future.wait(
              blockedUsersIds
              .map((id)=>_firestore.collection('Users').doc(id).get()),
          );
          //return the user data as a list
          return userDocs.map((doc)=>doc.data() as Map<String,dynamic>).toList();
    });
  }
}

