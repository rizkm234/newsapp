import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Constants/cache_helper.dart';
import 'package:newsapp/Screens/news_screen.dart';
import 'package:newsapp/Services/news_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cacheHelper.init();

  bool? isdark = cacheHelper.getData(key: 'isDark');
  runApp( MyApp(isdark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
   MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..changeTheme(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return MaterialApp(
            theme: ThemeData(
              backgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(color: Colors.black,
                    fontSize: 20, fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.black),

              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 20,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black,

              ),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(fontSize: 18, color: Colors.black),
                  headline5: TextStyle(fontSize: 25, color: Colors.black)
              ),
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black26,
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black26,
                    statusBarIconBrightness: Brightness.light),
                backgroundColor: Colors.black26,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20, fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 20,
                backgroundColor: Colors.black26,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.white,

              ),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(fontSize: 18, color: Colors.white),
                  headline5: TextStyle(fontSize: 25, color: Colors.white)
              ),

            ),
            themeMode: cubit.isDark ? ThemeMode.dark: ThemeMode.light,
            home: const NewsScreen(),
          );
        },
      ),
    );
  }
}

