//libraries
import 'package:flutter/material.dart';

//packages
import 'package:provider/provider.dart';

//screens
import 'screens/details_screen/details_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_result.dart';
//providers
import 'provider/http_calls.dart';

void main() {
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
          routes: {
            Home.routeName: (context) => Home(),
            DetailsScreen.routeName: (context) => DetailsScreen(),
            SearchResult.routeName: (context) => SearchResult()
          },
          home: Home(),
        ));
  }
}
