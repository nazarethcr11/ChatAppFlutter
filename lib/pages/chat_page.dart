import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverID;

  ChatPage({
    super.key,
    required this.recieverEmail,
    required this.recieverID,
});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //for text field focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //causes a delay so the keyboard has time to show up
        //then the amount of remaining space is calculated
        //then scroll down to the bottom
        Future.delayed(
            const Duration(milliseconds: 500),
            ()=> scrollDown()
        );
      }
    });
    //wait a bit for list view to build, then scroll to the bottom
    Future.delayed(
        const Duration(milliseconds: 500),
            ()=> scrollDown()
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void _sendMessage()async{
    //if there is something inside the text field
    if(_messageController.text.isNotEmpty){
      //send message
      await _chatService.sendMessage(widget.recieverID, _messageController.text);
      //clear the text field
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverEmail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children:[
          //display messages
          Expanded(
              child: _buildMessageList(),
          ),
          //user input
          _buildUserInput(),
        ]
      )
    );
  }

  //build message list
  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.recieverID, senderID),
      builder: (context, snapshot){
        //errors
        if(snapshot.hasError){
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        //loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //return list view
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc)=>_buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    //align message to the right if sender is the current user, otherwise align to the left
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
              message: data["message"],
              isCurrentUser: isCurrentUser,
              messageId: doc.id,
              userId: data["senderID"],
          )
        ],
      )
    );
  }

  //build message input
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              controller: _messageController,
              hintText: 'Type a message...',
              obscureText: false,
              focusNode: myFocusNode,
            )
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            margin: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Icons.send,color: Colors.white,),
              onPressed: _sendMessage,
            ),
          )
        ],
      ),
    );
  }
}
