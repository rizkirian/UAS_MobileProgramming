import 'package:flutter/material.dart';

class WeightTextfield extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? errorText;
  final TextInputType textInputType;
  const WeightTextfield({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.errorText,
    required this.textInputType,
    this.onChanged,
  });

  @override
  State<WeightTextfield> createState() => _WeightTextfieldState();
}

class _WeightTextfieldState extends State<WeightTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autofocus: false,
          controller: widget.controller,
          onChanged: widget.onChanged,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(fontSize: 16, color: Colors.black45),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: Material(
                color: const Color(0xff827E7D),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'kg',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1))),
        ),
      ],
    );
  }
}
