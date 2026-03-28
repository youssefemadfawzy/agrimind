import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = false;

  bool get _isActive =>
      _focusNode.hasFocus || _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.isPassword;

    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChange);
  }

  void _onFocusChange() => setState(() {});
  void _onTextChange() => setState(() {});

  @override
  void dispose() {
    _focusNode.dispose();

    // مهم: منعملش dispose لو جاي من برا
    if (widget.controller == null) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Colors.blue;
    final Color inactiveColor = Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        obscureText: _obscureText,
        obscuringCharacter: '●',
        keyboardType: widget.keyboardType,
        style: const TextStyle(
          fontSize: 18,
          letterSpacing: 1,
        ),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.grey[50],

          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),

          // 🔹 Label
          labelStyle: TextStyle(
            color: _isActive ? activeColor : Colors.black54,
          ),

          // 🔹 Prefix Icon
          prefixIcon: widget.prefixIcon != null
              ? Icon(
            widget.prefixIcon,
            color: _isActive ? activeColor : inactiveColor,
          )
              : null,

          // 🔹 Suffix Icon (Password)
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

          // 🔹 Borders
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: activeColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}