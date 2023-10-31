// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proj3k/screen/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ใส่โลโก้ของคุณที่นี่
              // แนะนำให้ใช้ Widget Image และ AssetImage ในการแสดงภาพจากไฟล์
              // สำหรับตัวอย่างนี้เราจะใช้ AssetImage ชั่วคราว

              // ระยะห่าง
              SizedBox(height: 20),

              // ปุ่มเข้าสู่ระบบ
              ElevatedButton(
                onPressed: () {
                  // โค้ดสำหรับการเข้าสู่ระบบ
                },
                child: Text('เข้าสู่ระบบ'),
              ),

              // ระยะห่าง
              SizedBox(height: 10),

              // ปุ่มสมัครสมาชิก
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => register()),
                  );
                },
                child: Text('สมัครสมาชิก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
