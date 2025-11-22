import 'dart:convert';
import 'package:checking_system/screen/authentication/register_screen.dart';
import 'package:checking_system/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../main.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // ---------------------------
  // LOGIN API CALL FIXED
  // ---------------------------
  Future<void> login() async {
    setState(() => isLoading = true);

    final url = Uri.parse("https://project-nodejs-1-feg9.onrender.com/api/login");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json", // IMPORTANT FIX
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["token"] != null) {
        // Lưu thông tin user vào Hive
        LocalStorage.saveUserInfo(
          name: data["user"]["username"],
          accessToken: data["token"],
          typeUser: "user",
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng nhập thành công!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Đăng nhập thất bại")),
        );
      }
    } catch (e, stack) {
      print("ERROR: $e");
      print("STACK: $stack");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi kết nối server: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logo_widget(),
              title_widget(),
              const SizedBox(height: 20),
              input_email_widget(),
              const SizedBox(height: 20),
              input_password_widget(),
              const SizedBox(height: 20),
              button_login_widget(),
              const SizedBox(height: 10),
              register_widget(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------
  // UI ELEMENTS
  // ---------------------------

  Widget logo_widget() {
    return Stack(
      children: [
        ClipPath(
          clipper: DrawClip(),
          child: Container(
            height: 280,
            width: double.infinity,
            decoration: const BoxDecoration(
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

  Widget title_widget() {
    return const Text(
      'SIGN IN',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }

  Widget input_email_widget() {
    return SizedBox(
      width: 350,
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail, color: Colors.blue),
          hintText: "Email",
          filled: true,
          fillColor: Colors.blue[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget input_password_widget() {
    return SizedBox(
      width: 350,
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key, color: Colors.blue),
          hintText: "Password",
          filled: true,
          fillColor: Colors.blue[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.blue),
        ),
      ),
    );
  }

  Widget button_login_widget() {
    return TextButton(
      onPressed: isLoading ? null : login,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: isLoading ? Colors.grey : Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 50,
          width: 350,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
              "Submit",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget register_widget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Do not have an account?",
            style: TextStyle(fontSize: 15, color: Colors.green)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Register_Screen()),
            );
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        )
      ],
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
  bool shouldReclip(covariant CustomClipper<Path> oldCliper) => true;
}
