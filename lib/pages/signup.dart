import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:preform/user_auth/firebase_auth_services.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  @override
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
                                        "Sign Up",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26.0,
                                            color: Color(0xFFFF6C37)),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Ready to kickstart your career?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
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
                                                fontWeight: FontWeight.normal,
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
                                            obscureText: _obscurePassword,
                                            controller: _passwordController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 12.0),
                                              hintText: 'Enter your password',
                                              hintStyle: TextStyle(
                                                fontWeight: FontWeight.normal,
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
                                                return 'Please enter your password';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            controller:
                                                _confirmpasswordController,
                                            obscureText:
                                                _obscureConfirmPassword,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 12.0),
                                              hintText:
                                                  'Enter your password again',
                                              hintStyle: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _obscureConfirmPassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _obscureConfirmPassword =
                                                        !_obscureConfirmPassword;
                                                  });
                                                },
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
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your password';
                                              } else if (value !=
                                                  _passwordController.text) {
                                                return 'Passwords do not match';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 25),
                                          Row(
                                            children: [
                                              Text(
                                                "Already have an account? ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/login');
                                                },
                                                child: Text(
                                                  "Login here!",
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
                                                _signUp();
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
                                                'Sign Up',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        print("User successfully created");
        await _addUserDataToRealTimeDB(user.uid, email);
        Navigator.pushNamed(context, '/login');
      } else {
        print("Error in creating user");
      }
    }
  }

  Future<void> _addUserDataToRealTimeDB(String uid, String email) async {
    try {
      final DatabaseReference usersRef =
          FirebaseDatabase.instance.ref().child('Users');
      await usersRef.child(uid).set({
        'uid': uid,
        'email': email,
      });

      print("User data added to Firebase Realtime Database");
    } catch (e) {
      print("Error adding user data to Firebase Realtime Database: $e");
    }
  }
}
