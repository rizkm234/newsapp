import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/JSON_Model/NewsModel.dart';
import 'package:newsapp/Services/news_cubit.dart';

class searchScreen extends StatelessWidget {
  searchScreen({Key? key, required this.cubit}) : super(key: key);
  var searchController = TextEditingController();
  final NewsCubit cubit ;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    onChanged: (value) {
                      cubit.searchData(value);
                    },
                    decoration: const InputDecoration(
                      label: Text('Search'),
                      prefixIcon: Icon(Icons.search),),
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (String ?value) {
                      if (value!.isEmpty) {
                        return 'Please enter something to search';
                      }
                      return null;
                    },
                  ),
                ),
                FutureBuilder(
                  future: cubit.searchData(searchController.text),
                    builder: (context , snapshot){
                      if (snapshot.hasData) {
                        NewsModel data = snapshot.data;
                        return ListView.builder(
                            itemCount: data.articles!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(
                                    '${data.articles![index].title}',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),SizedBox(
                                      width: 350,
                                      height: 70,
                                      child: Text(
                                        '${data.articles![index].description}',
                                        style: Theme.of(context).textTheme.bodyText1,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      )),
                                ],
                              );

                            });
                      } else {
                        return const SizedBox();
                      }
                    })
                

              ],
            ),
          );
        },
      ),
    );
  }
}
