import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confimPasswordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confimPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Join us today"),
            
            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Email"

              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Password"
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: confimPasswordController,
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Confirm Password"
              ),

            ),
            SizedBox(height: 10,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                
              },
              child: Text("Signup Button"),
            ),
            ),
        
            SizedBox(height: 10,
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Already have an account?"),
            ),
            ),

          ],
        ),
      ),
    );
  }
}