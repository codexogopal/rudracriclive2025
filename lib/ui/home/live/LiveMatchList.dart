
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jacpotline/controllers/HomeController.dart';
import 'package:jacpotline/theme/mythemcolor.dart';
import 'package:jacpotline/utils/common_color.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../controllers/MatchDetailController.dart';
import '../../commonUi/CommonUi.dart';
import '../../match_detail/MatchDetailsScreen.dart';

class LiveMatchList extends StatefulWidget{
  const LiveMatchList({super.key});
  @override
  State<StatefulWidget> createState() => LiveMatchListState();
}
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LiveMatchListState extends State<LiveMatchList>{

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      Provider.of<HomeController>(context, listen: false).getLiveMatchList(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeController>(context, listen: false).liveMatch = false;
    return Consumer<HomeController>(builder: (context, myData, _){
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: addBody()),
            ],
          ),
        ),
      );
    });
  }

  Widget addBody(){
    MatchDetailController matchDetailController = Provider.of(context, listen: false);
    double teamWidth = 35;
    HomeController provider = Provider.of(context, listen: false);
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    double adsWidth = MediaQuery.of(context).size.width;
    double teamHeight = 70;
    return !provider.liveMatch ? const Center(child: CircularProgressIndicator(),) : SizedBox(
      child: provider.liveDataList.isEmpty ? emptyWidget(context) : ListView(
        children: [
          ...provider.liveDataList.map((e) {
            return Column(
              children: [
                InkWell(
                  onTap: (){
                    matchDetailController.matchInfo = e;
                    matchDetailController.matchListObjectInfo = e;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MatchDetailsScreen(matchId: e["match_id"].toString(), matchTab: 2,)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 15, 15, 0),
                        child: Text(
                          e["series"] ?? "hi",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primaryContainer,
                            boxShadow: [BoxShadow(
                              color: isDarkTheme ? Colors.black54 : Colors.grey.shade300,
                              offset: Offset(0, 2),
                              blurRadius: 1.0,
                            ),]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${e["matchs"]}, ${e["venue"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: teamWidth,
                                            height: teamWidth,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(teamWidth/2),
                                                border: Border.all(color: Colors.grey.shade300,width: 2)
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(teamWidth/2),
                                              child: CachedNetworkImage(
                                                imageUrl: e["team_a_img"] ??'https://www.google.com.au/image_url.png',
                                                imageBuilder: (context, imageProvider) => Container(
                                                  height: teamWidth,
                                                  width: teamWidth,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) => Container(
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    "assets/images/logo.png",
                                                    height: teamWidth,
                                                    width: teamWidth,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => Image.asset(
                                                  "assets/images/logo.png",
                                                  height: teamWidth,
                                                  width: teamWidth,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/2,
                                            child: Wrap(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("${e["team_a_short"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
                                              const SizedBox(width: 8,),
                                              Text("${e["team_a_scores"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
                                              const SizedBox(width: 5,),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                                child: Text("${e["team_a_over"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12, color: Theme.of(context).hintColor),),
                                              ),
                                            ],
                                          )
                                          ),
                                          /*Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 10,),
                                              Text("${e["team_a_short"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
                                              const SizedBox(width: 8,),
                                              Text("${e["team_a_scores"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
                                              const SizedBox(width: 5,),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                                child: Text("${e["team_a_over"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12, color: Theme.of(context).hintColor),),
                                              ),
                                            ],
                                          )*/
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: teamWidth,
                                            height: teamWidth,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(teamWidth/2),
                                                border: Border.all(color: Colors.grey.shade300,width: 2)
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(teamWidth/2),
                                              child: CachedNetworkImage(
                                                imageUrl: e["team_b_img"] ??'https://www.google.com.au/image_url.png',
                                                imageBuilder: (context, imageProvider) => Container(
                                                  height: teamWidth,
                                                  width: teamWidth,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) => Container(
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    "assets/images/logo.png",
                                                    height: teamWidth,
                                                    width: teamWidth,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => Image.asset(
                                                  "assets/images/logo.png",
                                                  height: teamWidth,
                                                  width: teamWidth,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/2,
                                            child: Wrap(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("${e["team_b_short"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
                                                const SizedBox(width: 8,),
                                                Text("${e["team_b_scores"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
                                                const SizedBox(width: 5,),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                                  child: Text("${e["team_b_over"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12, color: Theme.of(context).hintColor),),
                                                ),
                                              ],
                                            ),
                                          )
                                          /*Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 10,),
                                              Text("${e["team_b_short"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
                                              const SizedBox(width: 8,),
                                              Text("${e["team_b_scores"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
                                              const SizedBox(width: 5,),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                                child: Text("${e["team_b_over"]}" ?? "hi", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12, color: Theme.of(context).hintColor),),
                                              ),
                                            ],
                                          )*/
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 40,
                                        color: Theme.of(context).colorScheme.secondaryContainer,
                                        width: 2,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Lottie.asset(
                                                'assets/images/liveIcon.json',
                                                width: 30,
                                                height: 30,
                                              ),
                                              Text('Live', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15, color: Color(CommonColor.liveColor), fontFamily: "b"),),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /*OutlinedButton(
                                  onPressed: (){
                                    matchDetailController.matchInfo = e;
                                    matchDetailController.matchListObjectInfo = e;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MatchDetailsScreen(matchId: e["match_id"].toString(), matchTab: 2,)));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    side: BorderSide(width: 1, color: Theme.of(context).hintColor),
                                  ),
                                  child: Text(
                                    "Click for prediction",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13),
                                  ),
                                ),*/
                                  Expanded(child: Text(e['toss'], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13,
                                      fontFamily: "b",fontWeight: FontWeight.w800,color: Color(CommonColor.liveColor)
                                  ),
                                  )
                                  ),
                                if(e.containsKey("fav_team"))
                                  Visibility(
                                    visible: e["fav_team"] != "",
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(e["fav_team"] ?? "", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13,
                                                fontFamily: "b",fontWeight: FontWeight.w800,color: Color(isDarkTheme ? CommonColor.darkFavTColor : CommonColor.favTColor))),
                                            const SizedBox(width: 8),
                                            Container(
                                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                                decoration: BoxDecoration(
                                                  color: Color(isDarkTheme ? CommonColor.darkFav1BColor : CommonColor.fav1BColor),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Text(e["min_rate"].toString() ?? "", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                    fontSize: 13,
                                                    fontFamily: "b",fontWeight: FontWeight.w800,color: Color(isDarkTheme ? CommonColor.darkFavTColor : CommonColor.fav1Color))
                                                )),
                                            const SizedBox(width: 8),
                                            Container(
                                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                                decoration: BoxDecoration(
                                                  color: Color(isDarkTheme ? CommonColor.darkFav2BColor : CommonColor.fav2BColor),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Text(e["max_rate"].toString() ?? "", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                    fontSize: 13,
                                                    fontFamily: "b",fontWeight: FontWeight.w800,color: Color(isDarkTheme ? CommonColor.darkFavTColor : CommonColor.fav2Color))
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                              // const SizedBox(height: 10,),
                              // Text(e['toss'], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12, color: Theme.of(context).hintColor),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if(provider.homeAdsData.containsKey("image") && provider.homeAdsData["status"] == 1 && provider.homeAdsData["image"] != "" && provider.homeAdsData["image"] != null)
                InkWell(
                  onTap: (){
                    openWhatsApp(provider.homeAdsData["url"]);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.onPrimary
                    ),
                    child: CachedNetworkImage(
                      imageUrl: provider.homeAdsData["image"] ??'https://www.google.com.au/image_url.png',
                      imageBuilder: (context, imageProvider) => Container(
                        height: teamHeight,
                        width: adsWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: teamHeight,
                          width: adsWidth,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/logo.png",
                        height: teamHeight,
                        width: adsWidth,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }


}