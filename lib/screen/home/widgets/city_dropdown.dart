import 'package:cek_ongkir/data/model/city_model.dart';
import 'package:flutter/material.dart';

class CityDropdown extends StatefulWidget {
  final List<Results> cityList;
  final String title;
  final String hint;
  final String? errorText;
  final Function(String) onSelected;

  const CityDropdown({
    Key? key,
    required this.cityList,
    required this.title,
    required this.hint,
    this.errorText,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<CityDropdown> createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  String? selectedCity;
  bool focused = false;
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (focus) => setState(() => focused = focus),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedCity,
            hint: Text(widget.hint),
            items: widget.cityList
                .map(
                  (city) => DropdownMenuItem(
                    value: city.cityId,
                    child: Text(city.cityName),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedCity = value;
              });
              widget.onSelected(value!);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              hintText: widget.hint,
              filled: true,
              fillColor: Colors.white,
              errorText: widget.errorText,
            ),
          ),
        ],
      ),
    );
  }
}
