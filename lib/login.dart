import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter123/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var _email = "";
  var _password = "";
  bool _isLoading = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        child: Center(
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        "Email",
                      ),
                      hintText: "Enter Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return _email.contains("@") ? null : "Enter valid email";
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(
                        "Password",
                      ),
                      hintText: "Enter Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      return _password.length > 6
                          ? null
                          : "Password should contain min 6 characters";
                    },
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      login();
                    },
                    child: const Text(
                      "Login",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (_formkey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
    setState(() {
      _isLoading = true;
    });

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: 'Sign up successfully');
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
