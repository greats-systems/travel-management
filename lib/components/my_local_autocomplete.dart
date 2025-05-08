import 'package:flutter/material.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class MyLocalAutocomplete extends StatelessWidget {
  final ValueChanged<String> onCitySelected;
  final FormFieldValidator validator;
  final String? initialValue;
  final String hintText;
  const MyLocalAutocomplete({
    super.key,
    required this.validator,
    required this.onCitySelected,
    required this.initialValue,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        if (initialValue != null) {
          controller.text = initialValue!;
        }
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.black12, width: 2.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.black12, width: 4.5),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
          ),
        );
      },
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) {
          return const Iterable.empty();
        }
        return constants.localCities.where((String option) {
          return option.contains(value.text);
        });
      },
      onSelected: (String selection) {
        onCitySelected(selection);
      },
    );
  }
}
