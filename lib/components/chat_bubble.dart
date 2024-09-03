import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageId,
    required this.userId,
  });

  //show options
  void _showOptions(BuildContext context, String messageId, String userId) {
    //show modal bottom sheet
    showModalBottomSheet(
        context: context,
        builder: (context){
          return SafeArea(
              child: Wrap(
                children:[
                  //report message button
                  ListTile(
                    leading: Icon(Icons.flag),
                    title: Text('Report'),
                    onTap: () {
                      Navigator.pop(context);
                      _reportMessage(context,messageId,userId);
                    },
                  ),
                  //block user button
                  ListTile(
                    leading: Icon(Icons.block),
                    title: Text('Block User'),
                    onTap: () {
                      Navigator.pop(context);
                      _blockUser(context,userId);
                    },
                  ),
                  //cancel button
                  ListTile(
                    leading: Icon(Icons.cancel),
                    title: Text('Cancel'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ]
              )
          );
        }
    );
  }
  //report message
  void _reportMessage(BuildContext context, String messageId, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Report Content'),
          content: Text('Are you sure you want to report this message?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')
            ),
            TextButton(
                onPressed: () {
                  ChatService().reportUser(messageId, userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Message reported'),
                      )
                  );
                },
                child: Text('Report')
            ),
          ],
        )
    );
  }
  //block user
  void _blockUser(BuildContext context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Block User'),
          content: Text('Are you sure you want to block this user?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')
            ),
            TextButton(
                onPressed: () {
                  ChatService().blockUser(userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('User blocked'),
                      )
                  );
                },
                child: Text('Block')
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return GestureDetector(
      onLongPress: () {
        if(!isCurrentUser) {
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Align(
          alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
                  : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isCurrentUser
                    ? Colors.white
                    : (isDarkMode ? Colors.white : Colors.grey.shade800),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
