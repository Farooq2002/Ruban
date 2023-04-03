import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('languages'),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.grid_goldenratio_outlined),
              title: Text('english'),
              onTap:()=> LocaleNotifier.of(context)?.change('en'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.grid_goldenratio_outlined),
              title: Text('dutch'),
              onTap:()=> LocaleNotifier.of(context)?.change('nl'),
            ),
          )
        ],
      ),
    );
  }
}
