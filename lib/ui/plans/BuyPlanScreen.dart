import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:jacpotline/controllers/MatchDetailController.dart';
import 'package:jacpotline/controllers/MatchDetailController.dart';
import 'package:jacpotline/theme/mythemcolor.dart';
import 'package:provider/provider.dart';

import '../../Constant.dart';
import '../../utils/AppBars.dart';
import '../../utils/styleUtil.dart';
import '../commonUi/CommonUi.dart';

class BuyPlanScreen extends StatefulWidget {
  final String planType;
  final String planAmount;
  const BuyPlanScreen({super.key, required this.planType, required this.planAmount});

  @override
  State<StatefulWidget> createState() => BuyPlanScreenState();
}
int _current = 0;
final CarouselSliderController _controller = CarouselSliderController();


class BuyPlanScreenState extends State<BuyPlanScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      Provider.of<MatchDetailController>(context, listen: false).getBuyAPlanUpiData(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double teamWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Consumer<MatchDetailController>(builder: (context, loginData, _) {
      return Scaffold(
        appBar: myStatusBar(),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: loginData.upiData.isNotEmpty ?
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: loginData.upiData["qr_code"] ?? 'https://www.google.com.au/image_url.png',
                          imageBuilder: (context, imageProvider) => Container(
                            height: teamWidth/1.5,
                            width: teamWidth/1.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/logo.png",
                              height: teamWidth/1.5,
                              width: teamWidth/1.5,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/logo.png",
                            height: teamWidth/1.5,
                            width: teamWidth/1.5,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.black54
                            ),
                            child: const Text(" "),
                          ),
                          Text("  OR  ", style: Theme.of(context).textTheme.titleMedium,),
                          Container(
                            width: 80,
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.black54
                            ),
                            child: const Text(" "),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Clipboard.setData(ClipboardData(text: loginData.upiData["upi_id"]));
                              showToast("Copied UPI ID to clipboard ${loginData.upiData["upi_id"]}");
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 50),
                              height: 50,
                              width: teamWidth/1.5,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text("UPI ID: ${loginData.upiData["upi_id"]}", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontFamily: "sb"),)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      OutlinedButton(
                        onPressed: (){
                          loginData.pickImage(context, widget.planType, widget.planAmount);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          side: const BorderSide(width: 2, color: myprimarycolor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                          child: Text(
                            "Submit Screenshot",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: myprimarycolor, fontFamily: "sb", fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ) :
          Center(child: emptyWidget(context),),
        ),
      );
    });
  }
}
