import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Demo dữ liệu – sau này anh truyền từ user thực tế vào
  final TextEditingController _nameController =
  TextEditingController(text: "Nguyễn Văn A");
  final TextEditingController _emailController =
  TextEditingController(text: "phuhuynh@example.com");
  final TextEditingController _phoneController =
  TextEditingController(text: "0912345678");
  final TextEditingController _addressController =
  TextEditingController(text: "Đà Nẵng");

  String _role = "Phụ huynh"; // hoặc "Giáo viên"

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa thông tin"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 🔹 Avatar + nút đổi ảnh
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () {
                        // TODO: chọn ảnh từ gallery / camera
                      },
                      icon: const Icon(Icons.camera_alt, size: 18),
                      label: const Text("Đổi ảnh đại diện"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Họ tên
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Họ và tên",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập họ tên";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // 🔹 Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Vui lòng nhập email";
                  }
                  if (!value.contains("@")) {
                    return "Email không hợp lệ";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // 🔹 Số điện thoại
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Số điện thoại",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 16),

              // 🔹 Địa chỉ
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Địa chỉ",
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),

              const SizedBox(height: 16),

              // 🔹 Vai trò
              DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(
                  labelText: "Vai trò",
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Phụ huynh",
                    child: Text("Phụ huynh"),
                  ),
                  DropdownMenuItem(
                    value: "Giáo viên",
                    child: Text("Giáo viên"),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _role = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 24),

              // 🔹 Nút Lưu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSavePressed,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Lưu thay đổi",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSavePressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: gọi API / lưu local / update provider, v.v.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đã lưu thông tin cá nhân")),
      );
      Navigator.pop(context); // quay lại màn trước
    }
  }
}
