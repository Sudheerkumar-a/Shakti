import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shakti/approutes/app_routes.dart';
import 'package:shakti/data/datasource/local_data_source.dart';
import 'core/themes.dart';
import 'core/utils/pref_utils.dart';
import 'package:provider/provider.dart';

import 'domain/repositories/api_repository_impl.dart';

Future<void> main() async {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
  //  (value) {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils().init();
  //await di.init();
  runApp(const MyApp());
  // },
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final kColorScheme = ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 244, 100, 181));
    final kDarkColorScheme = ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color.fromARGB(255, 5, 99, 125));
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 245, 245, 245),
        statusBarIconBrightness: Brightness.dark));
    return MultiProvider(
      providers: [
        Provider<ApisRepositoryImpl>(
            create: (context) =>
                ApisRepositoryImpl(localDataSource: LocalDataStoreImpl())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shakti',
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme()
              .copyWith(color: kDarkColorScheme.secondaryContainer),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          ),
          textTheme: TextTheme(
            displayLarge: GoogleFonts.lato(
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            displayMedium: GoogleFonts.lato(
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            bodyLarge: GoogleFonts.lato(
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 16,
                fontWeight: FontWeight.normal),
            bodyMedium: GoogleFonts.lato(
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
        ),
        theme: myTheme.copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme()
              .copyWith(color: kColorScheme.secondaryContainer),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: TextTheme(
            displayLarge: GoogleFonts.lato(
                color: kColorScheme.onSecondaryContainer,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            displayMedium: GoogleFonts.lato(
                color: kColorScheme.onSecondaryContainer,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            displaySmall: GoogleFonts.lato(
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            bodyLarge: GoogleFonts.lato(
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
                fontWeight: FontWeight.normal),
            bodyMedium: GoogleFonts.lato(
                color: kColorScheme.onSecondaryContainer,
                fontSize: 12,
                fontWeight: FontWeight.normal),
            bodySmall: GoogleFonts.lato(
                color: kColorScheme.onSecondaryContainer,
                fontSize: 10,
                fontWeight: FontWeight.normal),
          ),
        ),
        //home: ZonesScreen(),
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
