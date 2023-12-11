import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_bloc/core/common/providers/user_provider.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';
import 'package:tdd_bloc/core/services/injection_container.dart';
import 'package:tdd_bloc/core/services/routers.dart';
import 'package:tdd_bloc/firebase_options.dart';
import 'package:tdd_bloc/src/dashboard/presentation/providers/dashboard_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
      ],
      child: MaterialApp(
        title: 'BLoC',
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
      ),
    );
  }
}
