import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doctor_appointment/helper/navigation.dart';
import 'package:flutter_doctor_appointment/helper/routes.dart';
import 'package:flutter_doctor_appointment/provider/doctor_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<DoctorProvider>(create: (_) => DoctorProvider()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, __) {
            return MaterialApp(
              title: 'Doctor Appointment',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              navigatorKey: NavigationService.navigatorKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              home: SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
