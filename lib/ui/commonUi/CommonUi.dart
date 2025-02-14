import 'dart:io' show Platform;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jacpotline/Constant.dart';
import 'package:jacpotline/controllers/HomeController.dart';
import 'package:jacpotline/utils/common_color.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/MatchDetailController.dart';
import '../../theme/mythemcolor.dart';
import '../match_detail/MatchDetailsScreen.dart';

Container matchDateWiseFilter(BuildContext context, List matchData) {
  final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
  MatchDetailController matchDetailController =
      Provider.of(context, listen: false);
  double teamWidth = 35;
  return Container(
    child: Column(
      children: [
        ...matchData.asMap().entries.map((entry) {
          final index = entry.key;
          final pData = entry.value;
          List matchData = pData["data"];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Text(
                  pData["date_wise"] ?? "hi",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              ...matchData.map((e) {
                return InkWell(
                  onTap: () {
                    matchDetailController.matchInfo = e;
                    matchDetailController.matchListObjectInfo = e;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MatchDetailsScreen(
                                matchId: e["match_id"].toString(),
                                matchTab:
                                    e["match_status"] == "Live" ? 2 : 0)));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        boxShadow: [
                          BoxShadow(
                            color: isDarkTheme ? Colors.black54 : Colors.grey.shade300,
                            offset: const Offset(0, 2),
                            blurRadius: 1.0,
                          ),
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${e["matchs"]}, ${e["venue"]}" ?? "hi",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: e["match_status"] == "Live" ? 3 : 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: teamWidth,
                                        height: teamWidth,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                teamWidth / 2),
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 2)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              teamWidth / 2),
                                          child: CachedNetworkImage(
                                            imageUrl: e["team_a_img"] ??
                                                'https://www.google.com.au/image_url.png',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: teamWidth,
                                              width: teamWidth,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                "assets/images/logo.png",
                                                height: teamWidth,
                                                width: teamWidth,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              "assets/images/logo.png",
                                              height: teamWidth,
                                              width: teamWidth,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      e["match_status"] == "Live" || e["match_status"] == "Finished"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${e["team_a_short"]}" ??
                                                      "hi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "${e["team_a_scores"]}" ??
                                                      "hi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 2, 0, 0),
                                                  child: Text(
                                                    "${e["team_a_over"]}" ??
                                                        "hi",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            fontSize: 12,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              "${e["team_a_short"]}" ?? "hi",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: teamWidth,
                                        height: teamWidth,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                teamWidth / 2),
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 2)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: e["team_b_img"] ??
                                                'https://www.google.com.au/image_url.png',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: teamWidth,
                                              width: teamWidth,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                "assets/images/logo.png",
                                                height: teamWidth,
                                                width: teamWidth,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              "assets/images/logo.png",
                                              height: teamWidth,
                                              width: teamWidth,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      e["match_status"] == "Live" || e["match_status"] == "Finished"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${e["team_b_short"]}" ??
                                                      "hi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "${e["team_b_scores"]}" ??
                                                      "hi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 2, 0, 0),
                                                  child: Text(
                                                    "${e["team_b_over"]}" ??
                                                        "hi",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            fontSize: 12,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              "${e["team_b_short"]}" ?? "hi",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    width: 2,
                                  ),
                                  e["match_status"] == "Live"
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.circle,
                                                  size: 8,
                                                  color: myprimarycolor,
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  'Live',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                          fontSize: 15,
                                                          color:
                                                              myprimarycolor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : e["match_status"] == "Finished"
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Finished',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(fontSize: 13,
                                                      fontFamily: "b",
                                                      fontWeight: FontWeight.w800,
                                                      color: Color(CommonColor.liveColor)),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Start at:",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(fontSize: 10),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  e["match_date"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(fontSize: 13),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  e["match_time"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                ],
                              ),
                            )
                          ],
                        ),
                        if (e["match_status"] != "Finished")
                          const SizedBox(
                            height: 20,
                          ),
                        if (e["match_status"] != "Finished")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /*OutlinedButton(
                                onPressed: () {
                                  matchDetailController.matchInfo = e;
                                  matchDetailController.matchListObjectInfo = e;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MatchDetailsScreen(
                                                  matchId:
                                                      e["match_id"].toString(),
                                                  matchTab: 2)));
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  side: BorderSide(
                                      width: 1,
                                      color: Theme.of(context).hintColor),
                                ),
                                child: Text(
                                  "Click for prediction",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(),
                                ),
                              ),*/
                              if (e.containsKey("fav_team"))
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
                                /*Visibility(
                                  visible: e.containsKey("fav_team"),
                                  child: Visibility(
                                    visible: e["fav_team"] != "",
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              e["fav_team"] ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(fontSize: 12),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  e["min_rate"].toString() ??
                                                      "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(fontSize: 12),
                                                )),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.orange.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  e["max_rate"].toString() ??
                                                      "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(fontSize: 12),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )*/
                            ],
                          ),
                        if (e["match_status"] == "Finished")
                          const SizedBox(
                            height: 10,
                          ),
                        if (e["match_status"] == "Finished")
                          Text(
                            e['result'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                fontSize: 13,
                                fontFamily: "b",fontWeight: FontWeight.w800,color: Color(CommonColor.liveColor)),
                          )
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        }),
      ],
    ),
  );
}

List monthWiseListResponse(List responseJson) {
  // final response = jsonDecode(responseJson);
  final data = responseJson;

  // Create a set to store unique month_wise values
  final mSet = data.map((d) => d['month_wise']).toSet();

  // Create a result list with month_wise and corresponding data
  final result = mSet.map((d) {
    return {
      'month_wise': d,
      'data': data.where((o) => o['month_wise'] == d).toList(),
    };
  }).toList();
  return result;
  // Use the result as needed
  print("resultresult $result");
}

List dateWiseListResponse(List responseJson) {
  // Normalize the data by ensuring every element has a 'date_wise' key
  final normalizedData = responseJson.map((d) {
    if (!d.containsKey('date_wise') && d.containsKey('match_date')) {
      d['date_wise'] = d['match_date'];
    }
    return d;
  }).toList();

  // Create a set to store unique date_wise values
  final mSet = normalizedData.map((d) => d['date_wise']).toSet();

  // Create a result list with date_wise and corresponding data
  final result = mSet.map((d) {
    return {
      'date_wise': d,
      'data': normalizedData.where((o) => o['date_wise'] == d).toList(),
    };
  }).toList();

  // Use the result as needed
  print("resultresult $result");
  return result;
}

Widget emptyWidget(context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/no_data.png",
          height: 150,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "No data found",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(),
        ),
      ],
    ),
  );
}

Widget emptyWidgetWithExit(context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/no_data.png",
          height: 150,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "No data found",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Go back",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: myprimarycolor,
                  fontWeight: FontWeight.w900,
                  fontFamily: "b",
                  fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  );
}

bool isPlayingTeamA(String ballingTeam, String TeamAId) {
  bool isPlayingTeamA;
  if (ballingTeam == TeamAId) {
    isPlayingTeamA = true;
  } else {
    isPlayingTeamA = false;
  }
  return isPlayingTeamA;
}

String playerOnStrike(List batsman) {
  Map player1 = batsman[0];
  Map player2 = batsman[1];
  String onStrike;
  if (player1["strike_status"] == 1) {
    onStrike = "P1";
  } else {
    onStrike = "P2";
  }
  return onStrike;
}

void openWhatsApp(String whatsUrl) async {
  String url = whatsUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

bool validateEmailId(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

Future<void> onInviteFriends() async {
  String message = '''Hey! Check out Rudra CricLive App. 

It's a must-have application for any cricket fan as it covers all major tournaments & series with Live Scores in the most unique & entertaining way.

You will also be provided with entire information about a live match including Live ball by ball commentary, team squads, detailed scorecard with wicket elaboration and partnership stats, playing squads, insights from past clashes, recent forms of players, venue stats, and what not.

To download it, tap here for android app: ${Constant.PLAY_STORE_LINK}\n\n for iPhone tap here: ${Constant.APP_STORE_LINK}''';

  try {
    await Share.share(message);
  } catch (error) {
    if (kDebugMode) {
      print('Error: $error');
    }
    // Show error message to user if necessary
  }
}
// ${Platform.isAndroid ? Constant.PLAY_STORE_LINK : Constant.APP_STORE_LINK}

// isDateWise == ture (match will show date wise otherwise date will hide)
Widget matchItem(BuildContext context, Map<String, dynamic> pData,
    bool isDateWise, String titleType, bool isAdsShow) {
  MatchDetailController matchDetailController =
      Provider.of(context, listen: false);
  List matchData = pData["data"];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (isDateWise)
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Text(
            pData["date_wise"] ?? "hi",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      matchCard(context, matchData, titleType, isAdsShow)
    ],
  );
}

// titleType = 1 (Show only matchs name); titleType = 2 (Show matchs and venue names)
Widget matchCard(
    BuildContext context, List matchData, String titleType, bool isAdsShow) {
  MatchDetailController matchDetailController =
      Provider.of(context, listen: false);
  final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
  HomeController provider = Provider.of(context, listen: false);
  double teamWidth = 35;
  double adsWidth = MediaQuery.of(context).size.width;
  double teamHeight = 70;
  return Column(
    children: [
      ...matchData.asMap().entries.map((entry) {
        final index = entry.key;
        final e = entry.value;
        return Column(
          children: [
            InkWell(
              onTap: () {
                matchDetailController.matchInfo = e;
                matchDetailController.matchListObjectInfo = e;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MatchDetailsScreen(
                            matchId: e["match_id"].toString(),
                            matchTab: e["match_status"] == "Live" ? 2 : 0)));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    boxShadow: [
                      BoxShadow(
                        color: isDarkTheme ? Colors.black54 : Colors.grey.shade300,
                        offset: const Offset(0, 2),
                        blurRadius: 1.0,
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (titleType == "1")
                      Text(e["matchs"] ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith()),
                    if (titleType == "2")
                      Text("${e["matchs"]}, ${e["venue"]}" ?? "hi",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith()),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        (e["match_status"] == "Upcoming" ||
                                !e.containsKey("team_a_scores"))
                            ? Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    teamInfo(context, e["team_a_img"], e["team_a_short"], teamWidth),
                                    const SizedBox(height: 10),
                                    teamInfo(context, e["team_b_img"], e["team_b_short"], teamWidth),
                                  ],
                                ),
                              )
                            : Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: teamWidth,
                                          height: teamWidth,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      teamWidth / 2),
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 2)),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                teamWidth / 2),
                                            child: CachedNetworkImage(
                                              imageUrl: e["team_a_img"] ??
                                                  'https://www.google.com.au/image_url.png',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: teamWidth,
                                                width: teamWidth,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  "assets/images/logo.png",
                                                  height: teamWidth,
                                                  width: teamWidth,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "assets/images/logo.png",
                                                height: teamWidth,
                                                width: teamWidth,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Wrap(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${e["team_a_short"]}" ??
                                                      "hi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "${e["team_a_scores"]}" ??
                                                      "hi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 2, 0, 0),
                                                  child: Text(
                                                    "${e["team_a_over"]}" ??
                                                        "hi",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            fontSize: 12,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor),
                                                  ),
                                                ),
                                              ],
                                            )),
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: teamWidth,
                                          height: teamWidth,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      teamWidth / 2),
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 2)),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                teamWidth / 2),
                                            child: CachedNetworkImage(
                                              imageUrl: e["team_b_img"] ??
                                                  'https://www.google.com.au/image_url.png',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: teamWidth,
                                                width: teamWidth,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  "assets/images/logo.png",
                                                  height: teamWidth,
                                                  width: teamWidth,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "assets/images/logo.png",
                                                height: teamWidth,
                                                width: teamWidth,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Wrap(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${e["team_b_short"]}" ?? "hi",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "${e["team_b_scores"]}" ?? "hi",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 2, 0, 0),
                                                child: Text(
                                                  "${e["team_b_over"]}" ?? "hi",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor),
                                                ),
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
                          child: matchStatus(context, e),
                        ),
                      ],
                    ),
                    if (e["match_status"] != "Finished")
                      const SizedBox(height: 20),
                    if (e["match_status"] != "Finished")
                      matchActions(context, e),
                    // if (e["match_status"] == "Live" && e.containsKey("toss") && e["toss"] != null && e["toss"] != "") const SizedBox(height: 10,),
                    // if (e["match_status"] == "Live" && e.containsKey("toss") && e["toss"] != null && e["toss"] != "") Text(e['toss'], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12, color: Theme.of(context).hintColor),)
                  ],
                ),
              ),
            ),
            if (index % 2 == 0 && isAdsShow)
              if (provider.homeAdsData.containsKey("image") &&
                  provider.homeAdsData["status"] == 1 &&
                  provider.homeAdsData["image"] != "" &&
                  provider.homeAdsData["image"] != null)
                InkWell(
                  onTap: () {
                    openWhatsApp(provider.homeAdsData["url"]);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: CachedNetworkImage(
                      imageUrl: provider.homeAdsData["image"] ??
                          'https://www.google.com.au/image_url.png',
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
    ],
  );
}

Widget teamInfo(
    BuildContext context, String imgUrl, String teamShort, double teamWidth) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: teamWidth,
        height: teamWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(teamWidth / 2),
          border: Border.all(color: Colors.grey.shade300, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(teamWidth / 2),
          child: CachedNetworkImage(
            imageUrl: imgUrl ?? 'https://www.google.com.au/image_url.png',
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
      const SizedBox(width: 10),
      Text(teamShort ?? "hi",
          style: Theme.of(context).textTheme.titleMedium?.copyWith()),
    ],
  );
}

Widget matchStatus(BuildContext context, Map<String, dynamic> e) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        height: 40,
        color: Theme.of(context).colorScheme.secondaryContainer,
        width: 2,
      ),
      e["match_status"] == "Live"
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Lottie.asset(
                      'assets/images/liveIcon.json',
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      'Live',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: Color(CommonColor.liveColor),
                          fontFamily: "b"),
                    ),
                  ],
                ),
              ],
            )
          : e["match_status"] == "Finished"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Finished',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: "b",
                                fontWeight: FontWeight.w800,
                                color: Color(CommonColor.liveColor))),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Start at:",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 10)),
                    const SizedBox(height: 3),
                    Text(e["match_date"],
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 13)),
                    const SizedBox(height: 3),
                    Text(e["match_time"],
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 15)),
                  ],
                ),
    ],
  );
}

Widget matchActions(BuildContext context, Map<String, dynamic> e) {
  final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
  MatchDetailController matchDetailController =
      Provider.of(context, listen: false);
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /*OutlinedButton(
        onPressed: () {
          matchDetailController.matchInfo = e;
          matchDetailController.matchListObjectInfo = e;
          Navigator.push(context, MaterialPageRoute(builder: (context) => MatchDetailsScreen(matchId: e["match_id"].toString(),
              matchTab: 2)));
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: BorderSide(width: 1, color: Theme.of(context).hintColor),
        ),
        child: Text(
          "Click for prediction",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(),
        ),
      ),*/
      if (e["match_status"] == "Live" &&
          e.containsKey("toss") &&
          e["toss"] != null &&
          e["toss"] != "")
        Expanded(
            child: Text(
          e['toss'],
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 13,
              fontFamily: "b",
              fontWeight: FontWeight.w800,
              color: Color(CommonColor.liveColor)),
        )),
      if (e.containsKey("fav_team"))

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
  );
}
