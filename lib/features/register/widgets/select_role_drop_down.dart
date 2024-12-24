import 'package:flutter/material.dart';

class UserRoleDropdown extends StatefulWidget {
  final List<String> roles;
  final String? initialValue;
  final Function(String?) onChanged;

  const UserRoleDropdown({
    super.key,
    required this.roles,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<UserRoleDropdown> createState() => _UserRoleDropdownState();
}

class _UserRoleDropdownState extends State<UserRoleDropdown> {
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.initialValue ?? widget.roles.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      items: widget.roles.map((role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(
            role,
            style: TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedRole = value;
        });
        widget.onChanged(value);
      },
    );
  }
}