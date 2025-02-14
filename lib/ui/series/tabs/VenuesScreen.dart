import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jacpotline/controllers/SeriesController.dart';
import 'package:jacpotline/ui/news/NewsDetailScreen.dart';
import 'package:jacpotline/utils/AppBars.dart';
import 'package:provider/provider.dart';

import '../../commonUi/CommonUi.dart';


class VenuesScreen extends StatefulWidget {
  const VenuesScreen({super.key});

  @override
  State<StatefulWidget> createState() => VenuesScreenState();
}

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
int selectedPosition = 0;
Map selectedSeriesData = {};
bool haveVenuesReload = false;
List<Widget> listBottomWidget = [];

class VenuesScreenState extends State<VenuesScreen> {
  @override
  void initState() {
    super.initState();
    selectedSeriesData = Provider.of<SeriesController>(context, listen: false).selectedSeriesData;
    haveVenuesReload = Provider.of<SeriesController>(context, listen: false).haveVenuesReload;
    Map<String, String> fixturesDate = {
      "series_id": selectedSeriesData["series_id"].toString()
    };
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      if(haveVenuesReload){
        Provider.of<SeriesController>(context, listen: false).getVenuesList(context, fixturesDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SeriesController provider = Provider.of(context, listen: false);
    provider.haveVenuesReload ? provider.venuesLoading = true : provider.venuesLoading = false;
    return Consumer<SeriesController>(builder: (context, myData, _) {
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

  Widget addBody() {
    double myWidth = MediaQuery.of(context).size.width-30;
    double myHeight = 150;
    SeriesController provider = Provider.of(context, listen: false);
    return provider.venuesLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
      child: provider.venuesList.isEmpty
          ? emptyWidget(context)
          : ListView(
        children: [
          ...provider.venuesList.map((e) {
            return InkWell(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(newsData: e)));
                Map<String, String> seriesData = {
                    "venue_id" : e["id"].toString()
                };
                provider.getVenueDataById(context, seriesData);
              },
              child: Column(
                children: [
                  const SizedBox(height: 15,),
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
                                e["name"] ?? "",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                                // maxLines: 1,
                                // overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    e["place"] ?? "",
                                    style: Theme.of(context).textTheme.bodyMedium,
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
