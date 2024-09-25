import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lingoassignment/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/pages/login_screen.dart';
import 'screens/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: const AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.isAuthenticated) {
          return const HomeScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
