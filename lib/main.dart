import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/base/data/utils/shared_pref_utls.dart';
import 'package:ecommerce_app/features/cart/screens/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes_manager/route_generator.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  SharedPrefUtils sharedPrefUtils = getIt();
  bool isLoggedIn = (await sharedPrefUtils.getToken()) != null;
  runApp(MainApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => BlocProvider(
        create: (_) => getIt<CartCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: isLoggedIn ? Routes.mainRoute : Routes.signInRoute,
        ),
      ),
    );
  }
}
