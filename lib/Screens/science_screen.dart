import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constants/custom_screen.dart';
import '../JSON_Model/NewsModel.dart';
import '../Services/news_cubit.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        cubit.Category = 'science';
        return SingleChildScrollView(
          child: customScreen(cubit: cubit),

        );
      },
    );
  }
}
