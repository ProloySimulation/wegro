import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wegro/providers/database_provider.dart';
import 'package:wegro/providers/product_provider.dart';
import 'package:wegro/providers/signup_provider.dart';
import 'package:wegro/providers/single_product_provider.dart';
import 'package:wegro/screens/auth_checker.dart';
import 'package:wegro/screens/home_page.dart';
import 'package:wegro/screens/saved_products_page.dart';
import 'package:wegro/screens/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    runApp(const MyApp());
  } catch (error) {
    print("Error initializing Firebase: $error");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => SingleProductProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthChecker(),
      ),
    );
  }
}
