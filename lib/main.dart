import 'package:flutter/material.dart';
import 'package:pet_care_connect/locator.dart';
import 'package:pet_care_connect/services/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen/login_screen.dart';
import 'utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Replace these values with your own Firebase project settings
  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: '',
    appId: '1:691930476460:android:56cd6024505ef4cbd89409',
    messagingSenderId: '691930476460',
    projectId: 'project-pet-care',
    storageBucket: 'project-pet-care.appspot.com',
  );

  await Firebase.initializeApp(options: firebaseOptions);

  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => locator.get<AuthProvider>(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kPrimaryColor,
              fontFamily: 'Montserrat',
            ),
      ),
      home: const LoginScreen(),
    );
  }
}
