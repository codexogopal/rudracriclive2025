import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jacpotline/controllers/MatchDetailController.dart';
import 'package:jacpotline/controllers/MatchDetailController.dart';
import 'package:jacpotline/theme/mythemcolor.dart';
import 'package:jacpotline/ui/plans/BuyPlanScreen.dart';
import 'package:provider/provider.dart';

import '../../Constant.dart';
import '../../utils/AppBars.dart';
import '../../utils/styleUtil.dart';
import '../commonUi/CommonUi.dart';

class ChoosePlan extends StatefulWidget {
  const ChoosePlan({super.key});

  @override
  State<StatefulWidget> createState() => ChoosePlanState();
}
int _current = 0;
final CarouselSliderController _controller = CarouselSliderController();


class ChoosePlanState extends State<ChoosePlan> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      Provider.of<MatchDetailController>(context, listen: false).getPlanList(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer<MatchDetailController>(builder: (context, loginData, _) {
      return Scaffold(
        appBar: myStatusBar(),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: ListView(
            children: [
              if(loginData.plansList.isNotEmpty)
              Column(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 3, 15),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Buy Plan",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontFamily: "sb",
                                fontSize: 18),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    "Choose Plan",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontFamily: "sb",
                        fontSize: 20),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20,),
                  sliderView()
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget sliderView() {
    MatchDetailController provider = Provider.of(context, listen: false);
    double myHeight = MediaQuery.of(context).size.height / 1.93;
    late List<Widget> imageSliders = provider.plansList.asMap().entries.map((entry){
      final index = entry.key;
      final item = entry.value;
      List content = item["content"];
      return InkWell(
        onTap: () {

        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    // borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                    borderRadius: const BorderRadius.all(Radius.circular(10) ,
                    ),
                    // color: item["index"] == 1 ? myprimarycolor.shade400 :
                    // item["index"] == 2 ? Colors.blue.shade400 :
                    // Colors.green.shade400,
                    gradient:  item["index"] == 1 ? linearGradient(Color(0xFFf99638), Color(0xfff46344)) :
                    item["index"] == 2 ? linearGradient(Color(0xFF45bfca), Color(0xff3aa5c5)) :
                    linearGradient(Color(0xFF79ae2a), Color(0xffb3be18)),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5.0,
                    ),]
                ),
                height: myHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Padding(
                     padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             Text(item["title"], style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 16),),
                             const SizedBox(width: 20,),
                             Container(
                                 height: 30,
                                 padding: const EdgeInsets.symmetric(horizontal: 15),
                                 decoration: BoxDecoration(
                                     borderRadius: const BorderRadius.all(
                                       Radius.circular(10.0),
                                     ),
                                     color: myprimarycolor.shade50
                                 ),
                                 child: Center(child: Text(item["plan"], style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54, fontSize: 16),))
                             ),
                           ],
                         ),
                         const SizedBox(height: 30,),
                         Column(
                           children: [
                             ...content.map((e){
                               return Column(
                                 children: [
                                   Row(
                                     children: [
                                       const Icon(Icons.check, size: 20, color: Colors.white,),
                                       const SizedBox(width: 10,),
                                       Expanded(child: Text(e.toString(), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 13),))
                                     ],
                                   ),
                                   const SizedBox(height: 20,),
                                 ],
                               );
                             })
                           ],
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Text("₹${item["amount"]}", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 35, fontFamily: "b"),),
                           ],
                         ),
                       ],
                     ),
                   ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (content) => BuyPlanScreen(planType: item["index"].toString(), planAmount: item["amount"].toString())));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.all(Radius.circular(10.0),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)
                            ),
                            color: Colors.white
                        ),
                        child: Center(child: Text("BUY NOW", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18, fontFamily: "b", color: Colors.black),)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();

    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: myHeight+50,
              viewportFraction: 0.8,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ],
    );
  }
  LinearGradient linearGradient(Color color1, Color color2){
    return LinearGradient(colors: [color1, color2],  begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter,);
  }
}
