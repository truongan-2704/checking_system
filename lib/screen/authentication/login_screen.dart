import 'package:checking_system/screen/authentication/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../main.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                logo_widget(),
                title_widget(),
                SizedBox(
                  height: 20,
                ),
                input_email_widget(),
                SizedBox(
                  height: 20,
                ),
                input_password_widget(),
                SizedBox(
                  height: 20,
                ),
                button_login_widget(),
                SizedBox(
                  height: 10,
                ),
                register_widget(),
              ],
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
                colors: [Color(0xffee4c14), Color(0xffffc371)],
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
      'SIGN IN',
      style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.deepOrange),
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
            prefixIcon: const Icon(Icons.mail,color: Colors.deepOrange,),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.deepOrange[100],
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
            prefixIcon: const Icon(Icons.vpn_key, color: Colors.deepOrange,),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.deepOrange[100],
            filled: true,
            suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.deepOrange,),
          )),
    );
  }

  Widget button_login_widget(){
    return TextButton (
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
        },
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 50,
            width: 350,
            child: const Center(
              child: Text(
                "Submit",
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
