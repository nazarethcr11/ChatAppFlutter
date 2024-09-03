import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  final authService  = AuthService();

  void signOut(BuildContext context) async{
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
                padding: EdgeInsets.only(bottom: 0.0, top: 30.0),
                child: Center(
                  child:Column(
                    children: [
                      Icon(
                        Icons.near_me_outlined,
                        size: 60,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(height: 25),
                      Text( authService.getCurrentUser()!.email.toString(),style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,fontSize: 14)),
                    ],
                  ),
                ),
              ),
              //home
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  title: Text("Home", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  leading:  Icon(Icons.home_outlined,color: Theme.of(context).colorScheme.primary),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              //settings
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  title: Text("Settings", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  leading:  Icon(Icons.settings_outlined,color: Theme.of(context).colorScheme.primary),
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
              title: Text("Logout", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              leading: Icon(Icons.logout_outlined,color: Theme.of(context).colorScheme.primary),
              onTap: ()=>signOut(context),
            ),
          ),
        ],
      )
    );
  }
}
