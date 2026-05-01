import 'package:flutter/material.dart';
import 'package:project_flutter/api_service.dart';
import 'package:project_flutter/home_screen.dart';
import 'login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final token = await ApiService.getToken();

  runApp(const MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: token != null ? HomeScreen() : LoginScreen(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}

