import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color corLogo = Color(0xFF359eb3);
  static const Color corLogo2 = Color(0xFFde1c81);
  static const Color corScaffold = Color(0xFFd4d4f3);
  static const Color corFonte = Colors.white;
  static const Color corFonteProgress = Colors.white70;

  static final TextStyle tituloTopo = GoogleFonts.roboto(
    color: corLogo,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 26,
  );

  static final TextStyle tituloTopo2 = GoogleFonts.pacifico(
    color: corLogo2,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 20,
  );

  static final TextStyle subTitulo = GoogleFonts.poiretOne(
    color: corFonte,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static final TextStyle subTitulo2 = GoogleFonts.poiretOne(
    color: corFonte,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 2,
  );

  static final TextStyle textoGeral = GoogleFonts.roboto(
    color: corFonteProgress,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline1: tituloTopo,
    headline2: tituloTopo2,
    subtitle1: subTitulo,
    subtitle2: subTitulo2,
    bodyText1: textoGeral,
  );

  static final ThemeData mikuTheme = ThemeData(
    scaffoldBackgroundColor: corScaffold,
    textTheme: lightTextTheme,
    errorColor: corFonte,
    canvasColor: corScaffold,
  );
}
