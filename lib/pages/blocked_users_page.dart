import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({Key? key}) : super(key: key);

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  //show confirm unblock box
  void _showUnblockBox(BuildContext context, String userId){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title:  Text("Unblock User", style: TextStyle(color: Theme.of(context).colorScheme.primary) ),
          content:  Text("Are you sure you want to unblock this user?", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: (){
                _chatService.unblockUser(userId);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("User unblocked"),
                  )
                );
              },
              child: const Text("Unblock"),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    String userId = _authService.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Blocked Users"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getBlockedUsersStream(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("An error occurred"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text("No blocked users", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return UserTile(
                  text: user["email"],
                  onTap: ()=>_showUnblockBox(context, user["uid"])
              );
            },
          );
        },
      )
    );
  }
}
