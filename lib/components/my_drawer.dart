import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  void signOut(BuildContext context) async{
    //auth service
    final authService  = AuthService();
    //try to sign out
    try{
      await authService.signOut();
    }
    //catch error
    catch(e){
      //show error
      showDialog(
          context: context,
          builder: (context)=> AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children:[
              //drawer header
              DrawerHeader(
                child: Center(
                  child:Icon(
                    Icons.mark_unread_chat_alt_rounded,
                    size: 60,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              //home
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  title: Text("H O M E", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  leading:  Icon(Icons.home,color: Theme.of(context).colorScheme.primary),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              //settings
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  title: Text("S E T T I N G S", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  leading:  Icon(Icons.settings,color: Theme.of(context).colorScheme.primary),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                  },
                ),
              ),
            ]
          ),
          //logout
          Padding(
            padding: const EdgeInsets.only(left: 20.0,bottom: 20.0),
            child: ListTile(
              title: Text("L O G O U T", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              leading: Icon(Icons.logout,color: Theme.of(context).colorScheme.primary),
              onTap: ()=>signOut(context),
            ),
          ),
        ],
      )
    );
  }
}
