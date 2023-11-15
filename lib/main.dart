import 'package:eden_demo/core/domains/user_domain.dart';
import 'package:eden_demo/presentation/views/views.dart';
import 'package:eden_demo/router/router.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
// ...
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Eden Assessment",
      theme: AppTheme.getTheme(),
      // initialRoute: RoutePaths.splashScreenView,
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      home: const AppWrapper(),
    );
  }
}

// flutterfire configure --project=eden-assessment

class AppWrapper extends ConsumerWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userDomain = ref.watch(userDomainProvider);
    return ValueListenableBuilder(
      valueListenable: userDomain.currentUser,
      builder: (context, value, child) {
        print("Current Value from wrapper ::: ${value?.email}");
        if (value == null) {
          return const AuthView();
        } else {
          return const HomeView();
        }
      },
    );
  }
}
