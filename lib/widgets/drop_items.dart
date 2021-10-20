import 'package:flutter/material.dart';

class DropItem extends StatefulWidget {
  void Function(String value) onModeChanged;
  DropItem({ Key? key , required this.onModeChanged}) : super(key: key);

  @override
  _DropItemState createState() => _DropItemState();
}

class _DropItemState extends State<DropItem> {
  final List<String> _versusMode = ['versus', 'computer'];

  String _modeValue = 'versus';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 100,
      child: FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0))
            ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: const Text("Select Mode"),
              value: _modeValue,
              isDense: true,
              onChanged: (newValue) {
                widget.onModeChanged(newValue ?? '');
                setState(() {
                  _modeValue = newValue ?? '';
                });
              },
              items: _versusMode.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    ),
    );
  }
}