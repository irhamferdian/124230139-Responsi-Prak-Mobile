import 'package:flutter/material.dart';
import '/models/user_model.dart';
import '/services/hive_service.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final hive = HiveService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              
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

              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Register"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      
                      final newUser = UserModel(
                        username: usernameC.text.trim(),
                        password: passwordC.text.trim(),
                      );

                      
                      hive.register(newUser);

                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Registrasi berhasil! Silahkan login."),
                        ),
                      );

                      
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),

              
              TextButton(
                child: Text("Sudah punya akun? Login"),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(),
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
