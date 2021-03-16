//libraries
import 'package:anime_shows_android/screens/downloads.dart';
import 'package:flutter/material.dart';

//packages
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

//screens
import 'screens/details_screen/details_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_result.dart';
//providers
import 'provider/http_calls.dart';
import 'screens/test_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HttpCalls>(create: (context) => HttpCalls())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              accentColor: Colors.black, primarySwatch: Colors.blueGrey),
          routes: {
            Home.routeName: (context) => Home(),
            DetailsScreen.routeName: (context) => DetailsScreen(),
            SearchResult.routeName: (context) => SearchResult(),
            DownloadScreen.routeName: (context) => DownloadScreen()
          },
          home: HomeTest(),
        ));
  }
}
