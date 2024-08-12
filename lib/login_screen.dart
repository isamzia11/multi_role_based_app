import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_role_based_app/home_screen.dart';
import 'package:multi_role_based_app/student_screen.dart';
import 'package:multi_role_based_app/teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  String? dropdownValue;
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'Email', prefixIcon: Icon(CupertinoIcons.mail)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: show,
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(CupertinoIcons.lock),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: show
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Age', prefixIcon: Icon(CupertinoIcons.person)),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton<String>(
                value: dropdownValue,
                hint: const Text('Select User Type'),
                icon: const Icon(CupertinoIcons.person),
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue != null) {
                      dropdownValue = newValue;
                    }
                  });
                },
                items: const [
                  DropdownMenuItem<String>(
                      value: 'student', child: Text('student')),
                  DropdownMenuItem<String>(
                      value: 'Teacher', child: Text('Teacher')),
                ]),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('email', emailController.text.toString());
                sp.setString('age', ageController.text.toString());
                sp.setString('userType', dropdownValue ?? '');
                sp.setBool('isLogin', true);
                if (dropdownValue == 'Teacher') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TeacherScreen()));
                } else if (dropdownValue == 'student') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StudentScreen()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                height: 50,
                width: 200,
                child: const Center(
                  child: Text(
                    "Signup",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
