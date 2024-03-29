import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suzi_app/authentication/repository/auth_repository.dart';
import 'package:suzi_app/firebase_options.dart';
import 'package:suzi_app/home/presentation/pages/root_view.dart';
import 'package:suzi_app/shared/presentation/splash_page.dart';
import 'package:suzi_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStatusChangesProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SUZI',
      theme: theme,
      darkTheme: theme,
      home: user.when(
        data: (user) {
          if (user == null) {
            return const SplashPage();
          } else {
            return const RootView();
          }
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stackTrace) => const Scaffold(
          body: Center(
            child: Text("Error"),
          ),
        ),
      ),
    );
  }
}
