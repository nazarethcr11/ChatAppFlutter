import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';

import 'package:flutter/material.dart';

import '../components/my_textfield_show.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  //login function
  void login(BuildContext context) async{
    //auth service
    final authService  = AuthService();

    //try to sign in
    try{
      await authService.signInWithEmailAndPassword(
          emailController.text,
          passwordController.text
      );
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            //logo
            Icon(
                Icons.near_me_outlined,
                size: 60,
                color: Theme.of(context).colorScheme.primary
            ),
            const SizedBox(height: 40),
            //welcome message
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            //email textfield
            MyTextfield(
                hintText: "Email",
                obscureText: false,
              controller: emailController,
              labelText: true,
            ),
            const SizedBox(height: 10),
            //password textfield
            MyTextfieldShow(
              controller: passwordController,
                hintText: "Password"
            ),
            const SizedBox(height: 20),
            //login button
            MyButton(
                text: "Login",
                onTap: ()=>login(context),
            ),
            const SizedBox(height: 10),
            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
