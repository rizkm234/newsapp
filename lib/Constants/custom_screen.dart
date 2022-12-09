import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/web%20view/web_view.dart';

import '../JSON_Model/NewsModel.dart';
import '../Services/news_cubit.dart';

class customScreen extends StatelessWidget {
  const customScreen({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final NewsCubit cubit;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cubit.getData(),
        builder: (context,  snapshot) {
          if (snapshot.hasData) {
            NewsModel data = snapshot.data;
            return ListView.builder(
                itemCount: data.articles!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var imageUrl = data.articles![index].urlToImage;
                  var description = data.articles![index].description;
                  imageUrl ??= 'https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg';
                  description ??= 'No Description is available';
                  Color cardColor ;
                  if (cubit.isDark == true){
                    cardColor = Colors.black;
                  }else {
                    cardColor = Colors.white;
                  }
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>
                              webViewScreen(url: data.articles![index].url)));
                    },
                    child: Card(
                      color: cardColor,
                      elevation: 5,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(image: NetworkImage(imageUrl)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.articles![index].title}',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(
                                    width: 350,
                                    height: 70,
                                    child: Text(
                                      description,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: Text('Loading......'),);
          }
        }
    );
  }
}
