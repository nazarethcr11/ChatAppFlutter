import 'package:chat_app/components/my_textfield_show.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});
  //register function
  void register(BuildContext context){
    //auth service
    final _auth = AuthService();
    //passwords match => create account
    if(passwordController.text == confirmPasswordController.text){
      //register
      try{
        _auth.registerWithEmailAndPassword(emailController.text, passwordController.text);
      }catch(e){
        //show error
        showDialog(
            context: context,
            builder: (context)=> AlertDialog(
              title: Text(e.toString()),
            )
        );
      }
    }
    //password don't match
    else{
      showDialog(
          context: context,
          builder: (context)=> AlertDialog(
            title: Text("Passwords do not match"),
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
              "Let's create your account!",
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
            const SizedBox(height: 10),
            //confirm password textfield
            MyTextfieldShow(
                controller: confirmPasswordController,
                hintText: "Confirm Password"
            ),
            const SizedBox(height: 20),
            //login button
            MyButton(
              text: "Register",
              onTap: ()=>register(context),
            ),
            const SizedBox(height: 10),
            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",
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
