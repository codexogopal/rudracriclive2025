import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jacpotline/controllers/LoginController.dart';
import 'package:jacpotline/theme/mythemcolor.dart';
import 'package:provider/provider.dart';


import '../../Constant.dart';
import '../../utils/AppBars.dart';
import '../../utils/styleUtil.dart';
import '../commonUi/CommonUi.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

bool _passwordVisible = false;

int _current = 0;
final CarouselSliderController _controller = CarouselSliderController();

final _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController mobileController = TextEditingController();

class RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      Provider.of<LoginController>(context, listen: false)
          .getLoginAdsData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer<LoginController>(builder: (context, loginData, _) {
      return Scaffold(
        appBar: myStatusBar(),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: ListView(
            children: [
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
                            Constant.appName,
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: InkWell(
                            child: SizedBox(
                              child: Text(
                                'Create Your Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.5,
                                  fontFamily: 'sb',
                                  color: Theme.of(context).indicatorColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                          child: SizedBox(
                            child: Text(
                              'Sign up into your account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'sb',
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            textInputAction: TextInputAction.next,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              contentPadding:
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              hintText: 'Full Name',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              counterText: "",
                              hintText: 'Mobile Number',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              contentPadding:
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                String userName =
                                nameController.text.trim().toString();
                                String userMobile =
                                mobileController.text.trim().toString();
                                if (userName.isEmpty) {
                                  showToast('Please enter your name');
                                  return;
                                }
                                if (userMobile.isEmpty) {
                                  showToast('Please enter your mobile no.');
                                  return;
                                }
                                if (userMobile.length != 10) {
                                  showToast('Please enter a valid mobile no.');
                                  return;
                                }
                                Map<String, String> userData = {
                                  'username': userName,
                                  'phone': userMobile,
                                };
                                // showToast(loginData.toString());
                                loginData.userSignUp(context, userData);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'sb',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  if (loginData.loginAdsDataList.isNotEmpty) sliderView()
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget sliderView() {
    LoginController provider = Provider.of(context, listen: false);
    double myHeight = MediaQuery.of(context).size.height / 2.5;
    late List<Widget> imageSliders = provider.loginAdsDataList
        .map((item) => InkWell(
      onTap: () {
        if (item["type"] == 4) {
          openWhatsApp(item["url"]);
        }else if(item["type"] == 3){
          // YouTubeVideoPlayer(videoId: item["url"],);
          showVideoPopup(context, convertUrlToId(item["url"])!);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => YouTubeVideoPlayer(videoId: convertUrlToId(item["url"])!)));
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: Colors.black
        ),
        height: myHeight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: CachedNetworkImage(
            imageUrl: item['image']!,
            imageBuilder: (context, imageProvider) => Container(
              height: myHeight,
              width: double.infinity,
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
                width: double.infinity,
                fit: BoxFit.fill,
              ), // you can add pre loader iamge as well to show loading.
            ), //show progress  while loading image
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/logo.png",
              height: myHeight,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            //show no image available image on error loading
          ),
        ),
      ),
    ))
        .toList();

    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: myHeight,
              viewportFraction: 0.93,
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
}

void showVideoPopup(BuildContext context, String videoId) {
  showDialog(
    context: context,
    builder: (BuildContext context)
    {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        insetPadding: EdgeInsets.zero,
        content: SizedBox(
          height: MediaQuery.of(context).size.height/3.84,
          width: MediaQuery.of(context).size.width-20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close',
              style: TextStyle(color: myprimarycolor, fontFamily: 'sb', fontSize: 16),),
          ),
        ],
      );
    }
  );
}

/*class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  Map<int, YoutubePlayerController> _videoControllers = {};

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      Provider.of<LoginController>(context, listen: false).getLoginAdsData(context);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    _videoControllers.forEach((key, controller) {
      controller.close();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer<LoginController>(builder: (context, loginData, _) {
      return Scaffold(
        appBar: myStatusBar(),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: ListView(
            children: [
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
                            Constant.appName,
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: InkWell(
                            child: SizedBox(
                              child: Text(
                                'Create Your Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.5,
                                  fontFamily: 'sb',
                                  color: Theme.of(context).indicatorColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                          child: SizedBox(
                            child: Text(
                              'Sign up into your account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'sb',
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            textInputAction: TextInputAction.next,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              contentPadding:
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              hintText: 'Full Name',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              counterText: "",
                              hintText: 'Mobile Number',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              contentPadding:
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                String userName =
                                nameController.text.trim().toString();
                                String userMobile =
                                mobileController.text.trim().toString();
                                if (userName.isEmpty) {
                                  showToast('Please enter your name');
                                  return;
                                }
                                if (userMobile.isEmpty) {
                                  showToast('Please enter your mobile no.');
                                  return;
                                }
                                if (userMobile.length != 10) {
                                  showToast('Please enter a valid mobile no.');
                                  return;
                                }
                                Map<String, String> userData = {
                                  'username': userName,
                                  'phone': userMobile,
                                };
                                // showToast(loginData.toString());
                                loginData.userSignUp(context, userData);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'sb',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  if (loginData.loginAdsDataList.isNotEmpty) sliderView()
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget sliderView() {
    LoginController provider = Provider.of(context, listen: false);
    double myHeight = MediaQuery.of(context).size.height / 2.5;
    List<Widget> imageSliders = provider.loginAdsDataList
        .asMap()
        .entries
        .map((entry) {
      int index = entry.key;
      var item = entry.value;
      return InkWell(
        onTap: () {
          if (item["type"] == 4) {
            openWhatsApp(item["url"]);
          }
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  color: Colors.green
              ),
              height: myHeight,
              child: Column(
                children: [
                  if(item["type"] == 4)
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: item['image']!,
                        imageBuilder: (context, imageProvider) => Container(
                          height: myHeight,
                          width: double.infinity,
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
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ), // you can add pre loader iamge as well to show loading.
                        ), //show progress  while loading image
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/logo.png",
                          height: myHeight,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        //show no image available image on error loading
                      ),
                    ),
                  if(item["type"] == 3)
                    youTubePlayer(item["url"], index)
                ],
              ),
            ),
          ],
        ),
      );
    })
        .toList();

    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: myHeight,
              viewportFraction: 0.93,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
                _pauseAllVideos();
                if (_videoControllers.containsKey(index)) {
                  _videoControllers[index]?.playVideo();
                }
              }),
        ),
      ],
    );
  }

  void _pauseAllVideos() {
    _videoControllers.forEach((key, controller) {
      controller.pauseVideo();
    });
  }

  Widget youTubePlayer(String videoUrl, int index) {
    String? videoId = convertUrlToId(videoUrl);
    if (videoId != null && !_videoControllers.containsKey(index)) {
      _videoControllers[index] = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        params: const YoutubePlayerParams(
          mute: false,
          showControls: true,
          showFullscreenButton: false,
        ),
      );
    }

    if (_videoControllers.containsKey(index)) {
      return Container(
        height: 100, // Ensure a fixed height for the player
        width: double.infinity,
        child: YoutubePlayer(
          controller: _videoControllers[index]!,
          aspectRatio: 16 / 9,
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  void deactivate() {
    _pauseAllVideos();
    super.deactivate();
  }
}*/


/*class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  Map<int, YoutubePlayerController> _videoControllers = {};

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      Provider.of<LoginController>(context, listen: false).getLoginAdsData(context);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    _videoControllers.forEach((key, controller) {
      controller.close();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer<LoginController>(builder: (context, loginData, _) {
      return Scaffold(
        appBar: myStatusBar(),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: ListView(
            children: [
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
                            Constant.appName,
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: InkWell(
                            child: SizedBox(
                              child: Text(
                                'Create Your Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.5,
                                  fontFamily: 'sb',
                                  color: Theme.of(context).indicatorColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                          child: SizedBox(
                            child: Text(
                              'Sign up into your account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'sb',
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            textInputAction: TextInputAction.next,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              contentPadding:
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              hintText: 'Full Name',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              counterText: "",
                              hintText: 'Mobile Number',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              contentPadding:
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                String userName =
                                nameController.text.trim().toString();
                                String userMobile =
                                mobileController.text.trim().toString();
                                if (userName.isEmpty) {
                                  showToast('Please enter your name');
                                  return;
                                }
                                if (userMobile.isEmpty) {
                                  showToast('Please enter your mobile no.');
                                  return;
                                }
                                if (userMobile.length != 10) {
                                  showToast('Please enter a valid mobile no.');
                                  return;
                                }
                                Map<String, String> userData = {
                                  'username': userName,
                                  'phone': userMobile,
                                };
                                // showToast(loginData.toString());
                                loginData.userSignUp(context, userData);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'sb',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        // Center(child: youTubePlayer("https://www.youtube.com/watch?v=lLsPMZHfp6w"))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  if (loginData.loginAdsDataList.isNotEmpty) sliderView()
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget sliderView() {
    LoginController provider = Provider.of(context, listen: false);
    double myHeight = MediaQuery.of(context).size.height / 2.5;
    List<Widget> imageSliders = provider.loginAdsDataList
        .asMap()
        .entries
        .map((entry) {
      int index = entry.key;
      var item = entry.value;
      return InkWell(
        onTap: () {
          if (item["type"] == 4) {
            openWhatsApp(item["url"]);
          }
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  color: Colors.green
              ),
              height: myHeight,
              child: Column(
                children: [
                  if(item["type"] == 4)
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: item['image']!,
                        imageBuilder: (context, imageProvider) => Container(
                          height: myHeight,
                          width: double.infinity,
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
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ), // you can add pre loader iamge as well to show loading.
                        ), //show progress  while loading image
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/logo.png",
                          height: myHeight,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        //show no image available image on error loading
                      ),
                    ),
                  if(item["type"] == 3)
                    youTubePlayer(item["url"], index)
                ],
              ),
            ),
          ],
        ),
      );
    })
        .toList();

    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: myHeight,
              viewportFraction: 0.93,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
                _pauseAllVideos();
                if (_videoControllers.containsKey(index)) {
                  _videoControllers[index]?.playVideo();
                }
              }),
        ),
      ],
    );
  }

  void _pauseAllVideos() {
    _videoControllers.forEach((key, controller) {
      controller.pauseVideo();
    });
  }

  Widget youTubePlayer(String videoUrl, int index) {
    String? videoId = convertUrlToId(videoUrl);
    if (videoId != null && !_videoControllers.containsKey(index)) {
      _videoControllers[index] = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        params: const YoutubePlayerParams(
          mute: false,
          showControls: true,
          showFullscreenButton: false,
        ),
      );
    }

    return YoutubePlayer(
      controller: _videoControllers[index]!,
      aspectRatio: 16 / 9,
    );
  }

  @override
  void deactivate() {
    _pauseAllVideos();
    super.deactivate();
  }
}*/


/*class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      Provider.of<LoginController>(context, listen: false).getLoginAdsData(context);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    // _controllerVideo.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer<LoginController>(builder: (context, loginData, _) {
      return Scaffold(
        appBar: myStatusBar(),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: ListView(
            children: [
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
                            Constant.appName,
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: InkWell(
                            child: SizedBox(
                              child: Text(
                                'Create Your Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.5,
                                  fontFamily: 'sb',
                                  color: Theme.of(context).indicatorColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                          child: SizedBox(
                            child: Text(
                              'Sign up into your account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'sb',
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            textInputAction: TextInputAction.next,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              contentPadding:
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              hintText: 'Full Name',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              counterText: "",
                              hintText: 'Mobile Number',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              contentPadding:
                              const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                String userName =
                                nameController.text.trim().toString();
                                String userMobile =
                                mobileController.text.trim().toString();
                                if (userName.isEmpty) {
                                  showToast('Please enter your name');
                                  return;
                                }
                                if (userMobile.isEmpty) {
                                  showToast('Please enter your mobile no.');
                                  return;
                                }
                                if (userMobile.length != 10) {
                                  showToast('Please enter a valid mobile no.');
                                  return;
                                }
                                Map<String, String> userData = {
                                  'username': userName,
                                  'phone': userMobile,
                                };
                                // showToast(loginData.toString());
                                loginData.userSignUp(context, userData);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'sb',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Center(child: youTubePlayer("https://www.youtube.com/watch?v=lLsPMZHfp6w"))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  if (loginData.loginAdsDataList.isNotEmpty) sliderView()
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget sliderView() {
    LoginController provider = Provider.of(context, listen: false);
    double myHeight = MediaQuery.of(context).size.height / 2.5;
    List<Widget> imageSliders = provider.loginAdsDataList
        .map((item) => InkWell(
      onTap: () {
        if (item["type"] == 4) {
          openWhatsApp(item["url"]);
        }
      },
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                color: Colors.green
            ),
            height: myHeight,
            child: Column(
              children: [
                if(item["type"] == 4)
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: item['image']!,
                      imageBuilder: (context, imageProvider) => Container(
                        height: myHeight,
                        width: double.infinity,
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
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ), // you can add pre loader iamge as well to show loading.
                      ), //show progress  while loading image
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/logo.png",
                        height: myHeight,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      //show no image available image on error loading
                    ),
                  ),
                if(item["type"] == 3)
                  youTubePlayer(item["url"])
              ],
            ),
          ),
        ],
      ),
    ))
        .toList();

    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: myHeight,
              viewportFraction: 0.93,
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

  Widget youTubePlayer(String videoUrl) {
    late YoutubePlayerController _controllerVideo;
    String? videoId = convertUrlToId(videoUrl);
    print("$videoId  $videoUrl");
    if (videoId != null) {
      _controllerVideo = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        params: const YoutubePlayerParams(
          mute: false,
          showControls: true,
          showFullscreenButton: false,
        ),
      );
    }

    return YoutubePlayer(
      controller: _controllerVideo,
      aspectRatio: 16 / 9,
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    // _controllerVideo.pauseVideo();
    super.deactivate();
  }
}*/



/*
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

bool _passwordVisible = false;

int _current = 0;
final CarouselController _controller = CarouselController();

final _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController mobileController = TextEditingController();

class RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      Provider.of<LoginController>(context, listen: false).getLoginAdsData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer<LoginController>(builder: (context, loginData, _) {
      return Scaffold(
        appBar: myStatusBar(),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SafeArea(
          child: ListView(
            children: [
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
                            Constant.appName,
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: InkWell(
                            child: SizedBox(
                              child: Text(
                                'Create Your Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.5,
                                  fontFamily: 'sb',
                                  color: Theme.of(context).indicatorColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                          child: SizedBox(
                            child: Text(
                              'Sign up into your account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'sb',
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            textInputAction: TextInputAction.next,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              hintText: 'Full Name',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            scrollPadding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              counterText: "",
                              hintText: 'Mobile Number',
                              hintStyle: const TextStyle(
                                fontFamily: 'sb',
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: const BorderSide(
                                  color: myprimarycolor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                String userName =
                                    nameController.text.trim().toString();
                                String userMobile =
                                    mobileController.text.trim().toString();
                                if (userName.isEmpty) {
                                  showToast('Please enter your name');
                                  return;
                                }
                                if (userMobile.isEmpty) {
                                  showToast('Please enter your mobile no.');
                                  return;
                                }
                                if (userMobile.length != 10) {
                                  showToast('Please enter a valid mobile no.');
                                  return;
                                }
                                Map<String, String> userData = {
                                  'username': userName,
                                  'phone': userMobile,
                                };
                                // showToast(loginData.toString());
                                loginData.userSignUp(context, userData);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'sb',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  if (loginData.loginAdsDataList.isNotEmpty) sliderView()
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget sliderView() {
    LoginController provider = Provider.of(context, listen: false);
    double myHeight = MediaQuery.of(context).size.height / 2.5;
    late List<Widget> imageSliders = provider.loginAdsDataList
        .map((item) => InkWell(
              onTap: () {
                if (item["type"] == 4) {
                  openWhatsApp(item["url"]);
                }
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                      color: Colors.black
                    ),
                    height: myHeight,
                    child: Column(
                      children: [
                        if(item["type"] == 4)
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: item['image']!,
                            imageBuilder: (context, imageProvider) => Container(
                              height: myHeight,
                              width: double.infinity,
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
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ), // you can add pre loader iamge as well to show loading.
                            ), //show progress  while loading image
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/logo.png",
                              height: myHeight,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            //show no image available image on error loading
                          ),
                        ),
                        if(item["type"] == 3)
                          Center(child: youTubePlayer(item["url"]))
                      ],
                    ),
                  ),
                ],
              ),
            ))
        .toList();

    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: myHeight,
              viewportFraction: 0.93,
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
  late YoutubePlayerController _controllerVideo = YoutubePlayerController();
  Widget youTubePlayer(String videoUrl){
    String? videoId = convertUrlToId(videoUrl);
    _controllerVideo = YoutubePlayerController.fromVideoId(
      videoId: videoId!,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: false,
      ),
    );
    return YoutubePlayer(
      controller: _controllerVideo,
      aspectRatio: 16 / 9,
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controllerVideo.pauseVideo();
    super.deactivate();
  }

  @override
  void dispose() {
    _controllerVideo.close();
    super.dispose();
  }

}*/
