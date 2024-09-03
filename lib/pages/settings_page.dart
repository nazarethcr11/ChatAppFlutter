import 'package:chat_app/pages/blocked_users_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
   SettingsPage({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              //dark mode switch
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //dark mode
                    Text("Dark Mode", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20),),
                    //switch toggle
                    CupertinoSwitch(
                        value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                        onChanged: (value)=>Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                    )
                  ],
                ),
              ),
              //block users
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //dark mode
                    Text("Block Users", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20),),
                    //button to go to block users page
                    IconButton(
                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> BlockedUsersPage())),
                        icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.primary,)
                    )
                  ],
                ),
              ),
              //delete account
              Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delete Account", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 20),),
                    //button to delete account
                    IconButton(
                        onPressed: (){
                    //show dialog to confirm account deletion
                          showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text("Delete Account", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                  content: Text("Are you sure you want to delete your account?", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                  actions: [
                                    TextButton(
                                        onPressed: ()=>Navigator.pop(context),
                                        child: Text("Cancel", style: TextStyle(color: Theme.of(context).colorScheme.primary))
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          //delete account
                                          _authService.deleteAccount();
                                          //return to login page
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Delete", style: TextStyle(color: Theme.of(context).colorScheme.primary))
                                    )
                                  ],
                                );
                              }
                          );
                        },
                        icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary,)
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
