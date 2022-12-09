import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/JSON_Model/NewsModel.dart';
import 'package:newsapp/Services/news_cubit.dart';

import '../Constants/custom_screen.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        cubit.Category = 'sports';
        return SingleChildScrollView(
          child: customScreen(cubit: cubit),

        );
      },
    );
  }
}
