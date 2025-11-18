import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/login/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'services/session_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  await Hive.initFlutter();
  await Hive.openBox('users');    
  await Hive.openBox('session');  

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final session = SessionService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: session.getLogin(),
      builder: (context, snapshot) {

        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        
        final username = snapshot.data;
        final isLoggedIn = username != null;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: isLoggedIn ? HomeScreen() : LoginScreen(),
        );
      },
    );
  }
}
