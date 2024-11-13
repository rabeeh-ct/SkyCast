import 'package:sky_cast/presentation/screens/five_weather_screen/five_weather_screen_controller.dart';
import 'package:sky_cast/presentation/screens/home_screen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/routes/route_constants.dart';
import 'presentation/routes/routes.dart';
import 'utils/setup_app.dart';

void main() async {
  await setupApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenController()),
        ChangeNotifierProvider(create: (context) => FiveWeatherScreenController()),
      ],
      child: MaterialApp(
        title: 'SkyCast',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteList.initial,
        routes: Routes.routes,
      ),
    );
  }
}
