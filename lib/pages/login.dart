import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:preform/pages/home.dart';
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
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.6),
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color: const Color(0xFFC4084F),
                                    width: 2.0,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 60.0,
                                    bottom: 60.0,
                                    left: 20.0,
                                    right: 20.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Login",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26.0,
                                            color: Color(0xFFFF6C37)),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Welcome back to Preform!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 30),
                                      Form(
                                        key: _formKey,
                                        child: Column(children: [
                                          TextFormField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 12.0),
                                              hintText:
                                                  'Enter your email address',
                                              hintStyle: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFFF6C37),
                                                  width: 1.0,
                                                ),
                                              ),
                                              prefixIcon: const Icon(
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
                                          const SizedBox(height: 25),
                                          TextFormField(
                                            controller: _passwordController,
                                            obscureText: _obscurePassword,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 12.0),
                                              hintText: 'Enter your password',
                                              hintStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFFF6C37),
                                                  width: 1.0,
                                                ),
                                              ),
                                              prefixIcon: const Icon(
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
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              const Text(
                                                "New to Preform? ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/signup');
                                                },
                                                child: const Text(
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
                                          const SizedBox(height: 16),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // _login(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Home()),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFFFF6C37),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                elevation: 0,
                                              ),
                                              child: const Text(
                                                'Login',
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        print("Error in creating user");
      }
    }
  }
}
