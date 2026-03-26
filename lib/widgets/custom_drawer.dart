import 'package:flutter/material.dart';
Widget buildDrawer(BuildContext context, VoidCallback onHomeTap) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: const Text(
            'News App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Go to Home'),
          onTap: () {
            Navigator.of(context).pop(); //todo : close drawer.
            onHomeTap();
          },
        ),
      ],
    ),
  );
}