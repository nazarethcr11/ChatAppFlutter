import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: _buidUserList(),
    );
  }

  Widget _buidUserList() {
    return StreamBuilder(
      stream: ChatService().getUsersStreamExcludingBlocked(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.map<Widget>((userData) =>
              _buidUserListItem(userData, context)).toList(),
        );
      },
    );
  }

//build individual user list item
  Widget _buidUserListItem(Map<String, dynamic> userData,
      BuildContext context) {
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          //navigate to chat screen
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              ChatPage(
                recieverEmail: userData["email"],
                recieverID: userData["uid"],)
          ),
          );
        },
      );
    }else{
      return Container();
    }
  }
}