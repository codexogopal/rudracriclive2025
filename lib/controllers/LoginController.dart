
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jacpotline/controllers/MatchDetailController.dart';
import 'package:jacpotline/session/SessionManager.dart';
import 'package:jacpotline/ui/login/OtpScreen.dart';
import 'package:jacpotline/ui/plans/ChoosePlan.dart';
import 'package:provider/provider.dart';

import '../Constant.dart';
import '../utils/common_dialog.dart';
import '../utils/styleUtil.dart';
import "package:http/http.dart" as http;

class LoginController extends ChangeNotifier {

  List loginAdsDataList = [];
  Future<void> getLoginAdsData(context) async {
    CommanDialog.showLoading(context);
    var request = http.MultipartRequest('GET', Uri.parse(Constant.signupAds));
    /*request.fields.addAll({
      "match_id" :matchId.toString()
    });*/
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(await response.stream.bytesToString());
        loginAdsDataList = [];
        notifyListeners();
        if (data['status'] == true) {
          CommanDialog.hideLoading();
          loginAdsDataList = data["data"];
          Timer(const Duration(milliseconds: 50), () {
            notifyListeners();
          });
        } else {
          showToast(data['msg']);
          CommanDialog.hideLoading();
          notifyListeners();
        }
      } else {
        CommanDialog.hideLoading();
        notifyListeners();
      }
    } catch (error) {
      CommanDialog.hideLoading();
      notifyListeners();
      print("Error $error");
    }
  }


  Future<void> userSignUp(context, Map<String , String> userData) async {
    CommanDialog.showLoading(context);
    var request = http.MultipartRequest('POST', Uri.parse(Constant.signup));
    request.fields.addAll(userData);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(await response.stream.bytesToString());
        if (kDebugMode) {
          print(data.toString());
        }
        notifyListeners();
        if (data['status'] == true) {
          CommanDialog.hideLoading();
          showToast(data['message']);
          if (kDebugMode) {
            print(data["data"].toString());
          }
          Timer(const Duration(milliseconds: 50), () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  OtpScreen(userLoginData: data["data"])));
            notifyListeners();
          });
        } else {
          showToast(data['message']);
          CommanDialog.hideLoading();
          notifyListeners();
        }
      } else {
        CommanDialog.hideLoading();
        notifyListeners();
      }
    } catch (error) {
      CommanDialog.hideLoading();
      notifyListeners();
      if (kDebugMode) {
        print("Error $error");
      }
    }
  }

  Future<void> userOtpVerify(context, Map<String , String> userData, Map userLoginData) async {
    // FocusScope.of(context).unfocus();
    MatchDetailController mdProvider = Provider.of(context, listen: false);
    CommanDialog.showLoading(context);
    var request = http.MultipartRequest('POST', Uri.parse(Constant.verify));
    request.fields.addAll(userData);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(await response.stream.bytesToString());
        if (kDebugMode) {
          print(data.toString());
        }
        notifyListeners();
        if (data['status'] == true) {
          CommanDialog.hideLoading();
          showToast(data['message']);
          if (kDebugMode) {
            print(data["data"].toString());
          }
          SessionManager().saveUserData(userLoginData);
          Timer(const Duration(milliseconds: 50), () {
            mdProvider.checkPrediction(context);
            notifyListeners();
          });
          Timer(const Duration(milliseconds: 150), () {
            Navigator.pop(context);
            notifyListeners();
          });
        } else {
          showToast(data['message']);
          CommanDialog.hideLoading();
          Timer(const Duration(milliseconds: 50), () {
            notifyListeners();
          });
        }
      } else {
        CommanDialog.hideLoading();
        Timer(const Duration(milliseconds: 50), () {
          notifyListeners();
        });
      }
    } catch (error) {
      CommanDialog.hideLoading();
      Timer(const Duration(milliseconds: 50), () {
        notifyListeners();
      });
      print("Error $error");
    }
  }



}