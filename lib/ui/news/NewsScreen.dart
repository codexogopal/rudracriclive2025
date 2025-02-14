import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jacpotline/ui/news/NewsDetailScreen.dart';
import 'package:jacpotline/utils/AppBars.dart';
import 'package:provider/provider.dart';

import '../../controllers/LiveMatchControllers.dart';
import '../../controllers/NewsController.dart';
import '../../utils/styleUtil.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<StatefulWidget> createState() => NewsScreenState();
}

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
int selectedPosition = 0;
List<Widget> listBottomWidget = [];

class NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      Provider.of<NewsController>(context, listen: false).getNewsList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    NewsController provider = Provider.of(context, listen: false);
    LiveMatchController liveMatchController = Provider.of(context, listen: false);
    liveMatchController.stopFetchingMatchInfo();
    provider.newsLoading = true;
    return Consumer<NewsController>(builder: (context, myData, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        appBar: AppBars.myAppBar("Latest News", context, false),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: addBody()),
              instagramFollowAds(context)
            ],
          ),
        ),
      );
    });
  }

  Widget addBody() {
    double myWidth = MediaQuery.of(context).size.width-30;
    double myHeight = 150;
    NewsController provider = Provider.of(context, listen: false);
    return provider.newsLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
      child: provider.newsData.isEmpty
          ? const SizedBox(child: Text("No Data Found"))
          : ListView(
              children: [
                ...provider.newsData.map((e) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(newsData: e)));
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            e["title"] ?? "",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.primaryContainer),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl: e["image"] ??'https://www.daadiskitchen.com.au/image_url.png',
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: myHeight,
                                    width: myWidth,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        //image size fill
                                        image: imageProvider,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/logo.png",
                                      height: myHeight,
                                      width: myWidth,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    "assets/images/logo.png",
                                    height: myHeight,
                                    width: myWidth,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e["description"] ?? "",
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          e["pub_date"] ?? "",
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 15,)
              ],
            ),
    );
  }
}
