import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:preform/user_auth/firebase_auth_services.dart';
import 'package:preform/user_auth/user_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  @override
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color: Color(0xFFC4084F),
                                    width: 2.0,
                                  )),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 60.0,
                                    bottom: 60.0,
                                    left: 20.0,
                                    right: 20.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Login",
                                        style: TextStyle(
                                            fontFamily: 'DMSans',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 26.0,
                                            color: Color(0xFFFF6C37)),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Welcome back to Preform!",
                                        style: TextStyle(
                                            fontFamily: 'DMSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                      SizedBox(height: 30),
                                      Form(
                                        key: _formKey,
                                        child: Column(children: [
                                          TextFormField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 12.0),
                                              hintText:
                                                  'Enter your email address',
                                              hintStyle: TextStyle(
                                                fontFamily: 'DMSans',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Color(0xFFFF6C37),
                                                  width: 1.0,
                                                ),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.black,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 25),
                                          TextFormField(
                                            controller: _passwordController,
                                            obscureText: _obscurePassword,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 12.0),
                                              hintText: 'Enter your password',
                                              hintStyle: TextStyle(
                                                fontFamily: 'DMSans',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Color(0xFFFF6C37),
                                                  width: 1.0,
                                                ),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.password,
                                                color: Colors.black,
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _obscurePassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _obscurePassword =
                                                        !_obscurePassword;
                                                  });
                                                },
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Text(
                                                "New to Preform? ",
                                                style: TextStyle(
                                                  fontFamily: 'DMSans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/signup');
                                                },
                                                child: Text(
                                                  "Sign up here!",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0,
                                                    color: Color(0xFFFF6C37),
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          Container(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _login(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFFFF6C37),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0),
                                                elevation: 0,
                                              ),
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                    fontFamily: 'DMSans',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      )
                                    ]),
                              )))
                    ])))));
  }

  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user =
          await _auth.signInWithEmailAndPassword(context, email, password);

      if (user != null) {
        print("User successfully logged in");
        Provider.of<UserProvider>(context, listen: false)
            .setUserEmail(user.email);
        Navigator.pushNamed(context, '/');
      } else {
        print("Error in creating user");
      }
    }
  }
}
