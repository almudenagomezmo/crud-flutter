import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {

  final String title;
  final IconData icon;
  final bool required;
  final bool readOnly;

  const DetailCard({
    super.key,
    required this.title,
    required this.icon,
    this.required = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: TextFormField(
          initialValue: title,
          style: TextStyle(fontSize: 14, color: Colors.black),
          readOnly: readOnly,
          validator: (value) {
            if (required && (value == null || value.isEmpty)) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
      ),
    );

  }
}