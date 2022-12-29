import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/Constants/cache_helper.dart';
import 'package:newsapp/JSON_Model/NewsModel.dart';
import 'dart:convert' as convert;
import 'package:newsapp/Screens/business_screen.dart';
import 'package:newsapp/Screens/science_screen.dart';
import 'package:newsapp/Screens/setting_screen.dart';
import 'package:newsapp/Screens/sports_screen.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  static NewsCubit get (context) => BlocProvider.of(context);

  int currentIndex = 0;
  List <Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportScreen(),
    SettingScreen(),
  ];

  String Category = 'business';

  List categories = ['business' , 'science' , 'sports'];

  void changeCategories(int index){
    Category = categories[index];
    emit(changeCategoriesState());
  }


  void changeScreens (int index){
    currentIndex = index ;
    emit(changedScreen());
  }

  Future getData() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=eg&category=${Category}&apiKey=ac4c6322604544868e41c08ae1b13087'));
    if (response.statusCode == 200){
      print (response.body);
      try {
         return NewsModel.fromJson(jsonDecode(response.body));

      }catch(e){
          print(e.toString());
      }
    }
  }


  bool isDark = false;

  void changeTheme({required bool? fromShared}){
      if (fromShared != null){
        isDark = fromShared;
      }else{
        isDark = !isDark ;
      }

      cacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(changeThemeState());
        isDark = !isDark;
      });
  }

  Future searchData(String value)async{
      final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=${value}&apiKey=ac4c6322604544868e41c08ae1b13087'));
      if (response.statusCode == 200){
        print (response.body);
        try {
          return NewsModel.fromJson(jsonDecode(response.body));

        }catch(e){
          print(e.toString());
        }
      }
  }



}
