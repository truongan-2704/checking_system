import 'package:checking_system/screen/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
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
                SizedBox(
                  height: 20,
                ),
                title_widget(),
                SizedBox(
                  height: 20,
                ),
                input_email_widget (),
                SizedBox(
                  height: 20,
                ),
                input_password_widget(),
                SizedBox(
                  height: 20,
                ),
                input_conform_password_widget(),
                SizedBox(
                  height: 20,
                ),
                button_register_widget(),
                SizedBox(
                  height: 10,
                ),
                signin_widget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo_widget(){
    return Stack(
      children: [
        ClipPath(
          clipper: DrawClip(),
          child: Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0052D4), Color(0xFF65C7F7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 270,
          width: double.infinity,
          child: Lottie.asset('assets/json/login.json'),
        ),
      ],
    );
  }

  Widget title_widget () {
    return Text(
      'SIGN UP',
      style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.blue),
    );
  }

  Widget input_email_widget () {
    return Container(
      width: 350,
      child: TextFormField(
          autofocus: false,
          controller: null,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Vui Lòng Nhập Email");
            }
            // reg expression for email validation
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return ("Vui lòng nhập email hợp lệ");
            }
            return null;
          },
          onSaved: (value) {

          },

          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.mail,color: Colors.blue,),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue[100],
            filled: true,
          )),
    );
  }

  Widget input_password_widget(){
    return Container(
      width: 350,
      child: TextFormField(
          autofocus: false,
          controller: null,
          obscureText: true,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Mật Khẩu bắt buộc để đăng nhập");
            }
            if (!regex.hasMatch(value)) {
              return ("Nhập mật khẩu hợp lệ(Tối thiểu 6 kí tự)");
            }
          },
          onSaved: (value) {

          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.vpn_key, color: Colors.blue,),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue[100],
            filled: true,
            suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.blue,),
          )),
    );
  }

  Widget input_conform_password_widget(){
    return Container(
      width: 350,
      child: TextFormField(
          autofocus: false,
          controller: null,
          obscureText: true,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Mật Khẩu bắt buộc để đăng nhập");
            }
            if (!regex.hasMatch(value)) {
              return ("Nhập mật khẩu hợp lệ(Tối thiểu 6 kí tự)");
            }
          },
          onSaved: (value) {

          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.vpn_key, color: Colors.blue,),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Confirm password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue[100],
            filled: true,
            suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.blue,),
          )),
    );
  }

  Widget button_register_widget(){
    return TextButton (
        onPressed: () {
        },
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 50,
            width: 350,
            child: const Center(
              child: Text(
                "Register",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ));
  }

  Widget register_widget() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Do not have an account?",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Register_Screen()));
              },
              child: const Text(
                " Sign Up",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          ]),
    );
  }

  Widget signin_widget() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Already have an account?",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login_Screen()));
              },
              child: const Text(
                " Sign In",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          ]),
    );
  }
}


class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.1, size.height - 30);
    path.lineTo(size.width * 0.9, size.height - 30);
    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldCliper) {
    return true;
  }

}
