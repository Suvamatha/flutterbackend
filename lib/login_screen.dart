import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

@override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handlelogic(){

    String email = emailController.text;
    String password = passwordController.text;
    if(email.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(" please Enter the Email"),),
    );

    return;

    }

    if(password.length<6){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(" please enter the password"),),
    );

    return;
  }
      print("Email : ${emailController.text}");
      print("Password: ${passwordController.text}");
      print("Navigate to Home");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=> HomeScreen())
      );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text("Welcome Back", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),),

            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.red),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.white)
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.red),
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20,
            width: double.infinity,

            child: ElevatedButton(
              onPressed: () => {
                _handlelogic()
              },
              child: Text("Login",),
            ),  
            ),
          ],
        ),
      ),
    );
  }
}