import 'package:chat_app/pages/blocked_users_page.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
            ],
          ),
        ),
      )
    );
  }
}
