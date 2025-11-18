import 'package:flutter/material.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                logo_widget(),
                input_email_widget (),
                input_password_widget(),
                button_register_widget(),
                button_login_widget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo_widget(){
    return Container(
      child: Text("Logo here"),
    );
  }

  Widget input_email_widget () {
    return Container(
      child: Text("Email"),
    );
  }

  Widget input_password_widget(){
    return Container(
      child: Text("Password"),
    );
  }
  Widget button_register_widget(){
    return Container(
      child: Text("click register here"),
    );
  }
  Widget button_login_widget(){
    return Container(
      child: Text("button here"),
    );
  }

}
