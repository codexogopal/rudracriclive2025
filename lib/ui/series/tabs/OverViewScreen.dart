
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jacpotline/controllers/SeriesController.dart';
import 'package:jacpotline/utils/styleUtil.dart';
import 'package:provider/provider.dart';

class OverViewScreen extends StatefulWidget{
  const OverViewScreen({super.key});
  @override
  State<StatefulWidget> createState() => OverViewScreenState();
}
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
int selectedPosition = 0;
List<Widget> listBottomWidget = [];

class OverViewScreenState extends State<OverViewScreen>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SeriesController>(builder: (context, listData, _){
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: ListView(
            children: [
              addBody(),
            ],
          ),
        ),
      );
    });
  }
  
  Widget addBody(){
    double teamWidth = 20;
    SeriesController provider = Provider.of(context, listen: false);
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Series", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, fontFamily: "m"),),
                Text(provider.selectedSeriesData["series"] ?? "", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12, fontFamily: "m"),),
              ],
            ),
          ),
          hrLightWidget(context),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Duration", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, fontFamily: "m"),),
                Text(provider.selectedSeriesData["series_date"] ?? "", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12, fontFamily: "m"),),
              ],
            ),
          ),
          hrLightWidget(context),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total matches", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, fontFamily: "m"),),
                Text(provider.selectedSeriesData["total_matches"].toString() ?? "", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12, fontFamily: "m"),),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}
