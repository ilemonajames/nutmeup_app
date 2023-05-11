import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutmeup/firebase_options.dart';
import 'package:nutmeup/pages/SplashScreen.dart';
import 'package:nutmeup/providers/MechanicProvider.dart';
import 'package:nutmeup/providers/MyLocationProvider.dart';
import 'package:nutmeup/providers/MyProductProcvider.dart';
import 'package:nutmeup/providers/StoreProvider.dart';
import 'package:nutmeup/providers/UsersProvider.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => StoreProvider()),
      ChangeNotifierProvider(create: (context) => MyLocationProvider()),
      ChangeNotifierProvider(create: (context) => MechanicProvider()),
      ChangeNotifierProvider(create: (context) => MyProductsProvider())
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutMeUp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          fontFamily: 'Nunito'),
      home: const SplashScreen(),
    );
  }
}
