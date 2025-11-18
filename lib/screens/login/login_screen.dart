import 'package:flutter/material.dart';
import '/services/hive_service.dart';
import '/services/session_service.dart';
import '../register/register_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final hive = HiveService();
  final session = SessionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Username
              TextFormField(
                controller: usernameC,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Username tidak boleh kosong" : null,
              ),
              SizedBox(height: 20),

              // Password
              TextFormField(
                controller: passwordC,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Password tidak boleh kosong" : null,
              ),
              SizedBox(height: 30),

              // Tombol Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Login"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final user =
                          hive.login(usernameC.text.trim(), passwordC.text.trim());

                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Username atau password salah!"),
                          ),
                        );
                        return;
                      }

                      // Simpan session ke SharedPreferences
                      await session.saveLogin(user.username);

                      // Navigasi ke Home
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),

              SizedBox(height: 20),

              TextButton(
                child: Text("Belum punya akun? Register"),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
