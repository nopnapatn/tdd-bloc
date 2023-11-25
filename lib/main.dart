import 'package:flutter/material.dart';
import 'package:tdd_bloc/core/constants/app_colors.dart';
import 'package:tdd_bloc/core/services/injection_container.dart';
import 'package:tdd_bloc/core/services/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc',
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.kColorWhite,
        ),
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
