import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jacpotline/controllers/LoginController.dart';
import 'package:jacpotline/theme/mythemcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../Constant.dart';
import '../../utils/AppBars.dart';

class OtpScreen extends StatefulWidget {
  final Map userLoginData;

  const OtpScreen({super.key, required this.userLoginData});


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool enableResend = false;
  TextEditingController textEditingController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
  }




  void _resendCode() {
    //other code here
    setState(() {
      enableResend = false;
    });
  }

  String enteredOtp = "";

  @override
  Widget build(BuildContext context) {
    LoginController provider = Provider.of(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: false,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: myStatusBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(CommonAppTheme.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Verify your mobile number',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'sb'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Enter the OTP sent to ${widget.userLoginData["phone"]}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'sb',
                          fontWeight: FontWeight.normal,
                          height: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/1.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 0.0),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    // obscureText: true,
                    // obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,

                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      fieldOuterPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                      borderRadius: BorderRadius.circular(5),
                      borderWidth: 1,
                      fieldHeight: 45,
                      fieldWidth: 45,
                      errorBorderColor: Colors.red,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Theme.of(context).colorScheme.secondaryContainer,
                      inactiveColor: Theme.of(context).hintColor.withOpacity(0.2),
                      activeColor: Colors.green.shade50,
                      selectedColor: myprimarycolor,
                      selectedFillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    controller: textEditingController,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 0.5),
                        color: Colors.black12,
                        blurRadius: 0,
                      )
                    ],
                    onCompleted: (v) {
                      // debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      enteredOtp = value;
                      setState(() {
                        if (enteredOtp.length == 4) {
                          Map<String, String> loginData = {
                            'otp': enteredOtp,
                          };
                        }
                      });
                    },
                    beforeTextPaste: (text) {
                      // debugPrint("Allowing to paste $text");
                      return true;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      if (enteredOtp.length == 4) {
                        Map<String, String> loginData = {
                          'user_id' : widget.userLoginData["id"].toString(),
                          'otp': enteredOtp.toString(),
                        };
                        provider.userOtpVerify(context, loginData, widget.userLoginData,);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please Enter Valid OTP')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myprimarycolor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ) /* add child content here */,
        ),
      ),
    );
  }


  Future<bool?> showVerificationDialog(context, msg){
    return showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: const Text('Check your mail for otp',style: TextStyle(
                color: Colors.black
            ),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(msg
                  ,style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: "ssr"
                  ),),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('',
                  style: TextStyle(color: myprimarycolor, fontFamily: 'ssb', fontSize: 16),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK',
                  style: TextStyle(color: myprimarycolor, fontFamily: 'ssb', fontSize: 16),),
              ),
            ],
          );
        }
    );
  }
}