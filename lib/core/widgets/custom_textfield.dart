import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller; // ✅ لازم يكون required
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller, // ✅ مهم
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = false;

  bool get _isActive =>
      _focusNode.hasFocus || widget.controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.isPassword;

    _focusNode.addListener(() => setState(() {}));
    widget.controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Colors.blue;
    final Color inactiveColor = Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: TextFormField(
        controller: widget.controller, // ✅ مباشر بدون أي تعقيد
        focusNode: _focusNode,
        obscureText: _obscureText,
        obscuringCharacter: '●',
        keyboardType: widget.keyboardType,
        style: const TextStyle(fontSize: 18),

        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.grey[50],

          labelStyle: TextStyle(
            color: _isActive ? activeColor : Colors.black54,
          ),

          prefixIcon: widget.prefixIcon != null
              ? Icon(
            widget.prefixIcon,
            color: _isActive ? activeColor : inactiveColor,
          )
              : null,

          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: _isActive ? activeColor : inactiveColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),

          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }
}