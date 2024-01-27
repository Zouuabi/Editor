import 'package:editor/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Editor',
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
      home: const HomePage(),
    );
  }
}
