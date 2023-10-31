// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isObscured = true;
  bool _isObscured2 = true;

  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('Registered user: ${userCredential.user!.uid}');
      // ทำการบันทึกข้อมูลผู้ใช้ไปยัง Firebase Firestore ตรงนี้
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('รหัสผ่านไม่ปลอดภัย');
      } else if (e.code == 'email-already-in-use') {
        print('อีเมลนี้มีผู้ใช้แล้ว');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _userIDController,
              decoration: InputDecoration(
                labelText: 'UserID',
                errorText:
                    _userIDController.text.isEmpty ? 'กรุณากรอก UserID' : null,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText:
                    _emailController.text.isEmpty ? 'กรุณากรอกอีเมล' : null,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: _isObscured,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
                errorText: _passwordController.text.isEmpty
                    ? 'กรุณากรอกรหัสผ่าน'
                    : null,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _isObscured2,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(
                      _isObscured2 ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscured2 = !_isObscured2;
                    });
                  },
                ),
                errorText: _confirmPasswordController.text.isEmpty
                    ? 'กรุณายืนยันรหัสผ่าน'
                    : _confirmPasswordController.text !=
                            _passwordController.text
                        ? 'รหัสผ่านไม่ตรงกัน'
                        : null,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _register,
              child: Text('สมัครสมาชิก'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: register(),
  ));
}
