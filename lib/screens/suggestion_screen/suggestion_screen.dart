import 'package:flutter/material.dart';

import '../../config/app_text.dart';

class SuggestionScreen extends StatelessWidget {
  static const routeName = '/suggestions';
  const SuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.medium('Vos suggestions'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Suggestion'),
      ),
    );
  }
}
