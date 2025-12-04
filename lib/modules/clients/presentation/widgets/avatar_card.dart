import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {

  final String name;
  final String initials;

  const AvatarCard({
    super.key,
    required this.name,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: primaryColor.withOpacity(0.15),
          child: Text(
            initials,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );

  }
}