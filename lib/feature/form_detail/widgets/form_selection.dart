import 'package:flutter/material.dart';

class FormSelection extends StatefulWidget {
  final String title;
  final int index;
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onSelectionChanged;
  final Color borderColor;

  const FormSelection({
    super.key,
    required this.title,
    required this.index,
    required this.options,
    required this.selectedOption,
    required this.onSelectionChanged,
    required this.borderColor,
  });

  @override
  _FormSelectionState createState() => _FormSelectionState();
}

class _FormSelectionState extends State<FormSelection> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: widget.borderColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    if (newValue != null && newValue.isNotEmpty) {
                      setState(() {
                        selectedValue = newValue;
                      });
                      widget.onSelectionChanged(newValue);
                    }
                  },
                  items: widget.options.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
