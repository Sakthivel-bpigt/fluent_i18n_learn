import 'package:fluent_i18n/fluent_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localization_keywords.dart';

const List<Locale> SUPPORTED_LOCALES = [
  Locale('ja'),
  Locale('en'),
  Locale('ta'),
];

Locale locale = SUPPORTED_LOCALES.first;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizationKeywords.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
      locale: locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FluentLocalizationsDelegate(SUPPORTED_LOCALES),
      ],
      supportedLocales: SUPPORTED_LOCALES,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizationKeywords.homeTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizationKeywords.pushedButtonThisManyTimes(_counter),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Language: "),
                DropdownButton<Locale>(
                    value: locale,
                    items: SUPPORTED_LOCALES.map((language) {
                      return DropdownMenuItem(
                        child: Text(language.toString()),
                        value: language,
                      );
                    }).toList(),
                    onChanged: (value) async {
                      if (value != null) {
                        await AppLocalizationKeywords.applyLocale(value);
                        setState(() {
                          locale = value;
                        });
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: AppLocalizationKeywords.increment,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
