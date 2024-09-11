import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/cart/screens/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes_manager/route_generator.dart';
import 'features/di/di.dart';

/// Widget -> ViewModel - UseCase - Repo - DataSource
/// ViewModel(UseCase(Repo(DataSource))) -> DI
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  SharedPrefUtils sharedPrefUtils = getIt();
  bool isSignedIn = (await sharedPrefUtils.getUser()) != null;
  runApp(MainApp(isSignedIn));
}

class MainApp extends StatelessWidget {
  final bool isSignedIn;

  const MainApp(this.isSignedIn, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: isSignedIn ? Routes.mainRoute : Routes.signInRoute,
        ),
      ),
    );
  }
}
