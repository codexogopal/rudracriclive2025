
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jacpotline/controllers/SeriesController.dart';
import 'package:jacpotline/ui/match_detail/MatchDetailsScreen.dart';
import 'package:provider/provider.dart';

import '../../../controllers/SeriesController.dart';
import '../../commonUi/CommonUi.dart';
import '../../series/SeriesScreen.dart';

class FixturesSeriesScreen extends StatefulWidget{
  const FixturesSeriesScreen({super.key});
  @override
  State<StatefulWidget> createState() => FixturesSeriesScreenState();
}
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
ScrollController _scrollController = ScrollController();
bool _isLoadingMore = false;

class FixturesSeriesScreenState extends State<FixturesSeriesScreen>{

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      Provider.of<SeriesController>(context, listen: false).getSeriesForFixturesList(context);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoadingMore) {
        _loadMoreData();
      }
    });
    super.initState();
  }

  Future<void> _loadMoreData() async {
    // setState(() {
    //   _isLoadingMore = true;
    // });

    // await Provider.of<SeriesController>(context, listen: false).getSeriesForFixturesList(context);

    // setState(() {
    //   _isLoadingMore = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SeriesController>(context, listen: false).seriesForFixtLoading = true;
    return Consumer<SeriesController>(builder: (context, myData, _){
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
    SeriesController provider = Provider.of(context, listen: false);
    return provider.seriesForFixtLoading
        ? const Center(child: CircularProgressIndicator())
        : provider.seriesForFixturesListData.isEmpty
        ? Center(child: emptyWidget(context))
        : ListView.builder(
      // controller: _scrollController,
      itemCount: provider.seriesForFixturesListData.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == provider.seriesForFixturesListData.length) {
          return Center(child: CircularProgressIndicator());
        }
        return matchItem(context, provider.seriesForFixturesListData[index]);
      },
    );
  }

  // isDateWise == ture (match will show date wise otherwise date will hide)
  Widget matchItem(BuildContext context, Map<String, dynamic> pData) {
    SeriesController provider = Provider.of(context, listen: false);
    List matchData = pData["data"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Text(
              pData["month_wise"] ?? "----",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        matchCard(context, matchData)
      ],
    );
  }


  Widget matchCard(BuildContext context, List matchData){
    SeriesController provider = Provider.of(context, listen: false);
    double teamWidth = 35;
    return Column(
      children: [
        ...matchData.map((e) {
          return InkWell(
            onTap: (){
              // provider.selectedSeriesData = e;
              provider.selectedIndex = e["series_id"];
              provider.selectItem(0, e);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SeriesScreen()));
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width-100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(e["series"] ?? "----", style: Theme.of(context).textTheme.titleMedium?.copyWith(), overflow: TextOverflow.ellipsis,),
                          Text("${"${e["total_matches"]} Matches" ?? "----"},${e["series_date"] ?? "----"}", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13, color: Theme.of(context).hintColor)),
                      ],
                    ),
                  ),
                  Icon(Icons.navigate_next, size: 20, color: Theme.of(context).hintColor,)
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}