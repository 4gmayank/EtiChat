import 'package:eti_chat/core/conifg/localization.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.getString('register')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: locale.translate('email'),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: locale.translate('country'),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: locale.translate('displayName'),
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: locale.translate('password'),
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: locale.translate('confirmPassword'),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: locale.translate('mobile'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text(locale.translate('register')),
            ),
          ],
        ),
      ),
    );
  }
}
