import 'package:flutter/material.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPass = TextEditingController();
  final TextEditingController _newPass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool _hideOld = true;
  bool _hideNew = true;
  bool _hideConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi mật khẩu"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              _inputPassword(
                label: "Mật khẩu hiện tại",
                controller: _oldPass,
                hidden: _hideOld,
                onToggle: () => setState(() => _hideOld = !_hideOld),
              ),
              const SizedBox(height: 16),

              _inputPassword(
                label: "Mật khẩu mới",
                controller: _newPass,
                hidden: _hideNew,
                onToggle: () => setState(() => _hideNew = !_hideNew),
              ),
              const SizedBox(height: 16),

              _inputPassword(
                label: "Xác nhận mật khẩu mới",
                controller: _confirmPass,
                hidden: _hideConfirm,
                onToggle: () => setState(() => _hideConfirm = !_hideConfirm),
                validator: (value) {
                  if (value != _newPass.text) {
                    return "Mật khẩu xác nhận không khớp";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Cập nhật mật khẩu",
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

  Widget _inputPassword({
    required String label,
    required TextEditingController controller,
    required bool hidden,
    required VoidCallback onToggle,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: hidden,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(hidden ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggle,
        ),
      ),
      validator: validator ??
              (value) {
            if (value == null || value.trim().isEmpty) {
              return "Không được để trống";
            }
            if (value.length < 6) {
              return "Mật khẩu phải ít nhất 6 ký tự";
            }
            return null;
          },
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Gọi API đổi mật khẩu (nếu cần)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đổi mật khẩu thành công")),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _oldPass.dispose();
    _newPass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }
}
