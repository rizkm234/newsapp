import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Constants/cache_helper.dart';
import 'package:newsapp/Constants/custom_screen.dart';
import 'package:newsapp/Screens/search_screen.dart';
import 'package:newsapp/Services/news_cubit.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>searchScreen(cubit: cubit,)));
              },
                  icon: const Icon(Icons.search)),
              IconButton(onPressed: (){
                cubit.changeTheme(fromShared: cubit.isDark);
              },
                  icon: const Icon(Icons.brightness_4_outlined)),

            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              // cubit.changeScreens(index);
              // cubit.changeBtnBarColor();
              cubit.changeCategories(index);
            },
            items:  const [
            BottomNavigationBarItem(
                icon: Icon(Icons.business), label: 'Business',),
            BottomNavigationBarItem(
                icon: Icon(Icons.science), label: 'Science'),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_baseball), label: 'Sports'),
          ]),
          body: customScreen(cubit: cubit)

          // cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
