import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task2/splashScreen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isVisible = false;
  bool isLogedIn = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) => prefs = value);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(children: [
          const Center(
            child: Text(
              'Login Form',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'Email field is required' : null,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email', prefixIcon: Icon(Icons.email)),
                    ),
                    TextFormField(
                        controller: _passwordController,
                        validator: (value) => value!.isEmpty
                            ? 'Password field is required'
                            : null,
                        keyboardType: TextInputType.text,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Visibility(
                                  visible: isVisible,
                                  replacement: const Icon(Icons.visibility_off),
                                  child: const Icon(Icons.visibility),
                                )))),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            String email = _emailController.value.text;
                            String password = _passwordController.value.text;
                            setState(() {
                              isLogedIn = true;
                            });
                            _saveLogState(isLogedIn);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()));
                            print('$email $password $isLogedIn');
                          } else {
                            print('Enter valid data');
                          }
                        },
                        child: Text('Login'))
                  ],
                )),
          )
        ]),
      )),
    );
  }

  void _saveLogState(bool isLogedIn) async {
    if (prefs != null) {
      prefs.setBool("isLogedIn", isLogedIn);
    }
  }
}
