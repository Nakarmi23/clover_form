import 'package:flutter/material.dart';

class FormDateSelection extends StatefulWidget {
  final String title;
  final ValueChanged<String?> onDateSelected;
  final String? defaultDate;
  final Color borderColor;

  const FormDateSelection({
    super.key,
    required this.title,
    required this.onDateSelected,
    required this.defaultDate,
    required this.borderColor,
  });

  @override
  _FormDateSelectionState createState() => _FormDateSelectionState();
}

class _FormDateSelectionState extends State<FormDateSelection> {
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Set the initial date based on the defaultDate parameter
    _selectedDate =
        widget.defaultDate != null ? DateTime.parse(widget.defaultDate!) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style:  TextStyle(
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
              width: 1.0,
            ),
            borderRadius:
                BorderRadius.circular(5.0), // Optional: add border radius
          ),
          child: InkWell(
            onTap: () => _selectDate(context),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : '${_selectedDate!.toLocal()}'.split(' ')[0],
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = _selectedDate ?? DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateSelected('${_selectedDate!.toLocal()}'.split(' ')[0]);
      });
    }
  }
}
