import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/helpers/Constant/constant.dart' as Constant;

class ProfileModal {
  String id;
  String name;
  String profileimg;
  String youtube;
  String linkdin;
  String location;
  String creditcard;
  String cardcvv;
  String cardpin;
  String cardexpirydate;
  String dailycharge;
  String occupation;
  String serviceproviderid;
  String aboutus;
  String workinghistory;
  List<dynamic> otherlink;
  String companyname;

  ProfileModal({
    this.id,
    this.name,
    this.profileimg,
    this.youtube,
    this.linkdin,
    this.location,
    this.creditcard,
    this.cardcvv,
    this.cardpin,
    this.cardexpirydate,
    this.dailycharge,
    this.occupation,
    this.serviceproviderid,
    this.aboutus,
    this.companyname,
    this.otherlink,
    this.workinghistory,
  });

  ProfileModal.fromJson(Map<String, dynamic> json) {
    print("jason" + json.toString());
    id = json['_id'];
    name = json['name'];
    profileimg = json['profileimg'];
    youtube = json['youtube'] == '' ? 'WWW.YOUTUBE.COM' : json['youtube'];
    linkdin = json['linkdin'] == '' ? 'WWW.LINKEDIN.COM' : json['linkdin'];
    location = json['location'];
    creditcard = json['creditcard'];
    cardcvv = json['cardcvv'];
    cardpin = json['cardpin'];
    cardexpirydate = json['cardexpirydate'];
    dailycharge = json['dailycharge'];
    occupation = json['occupation'] == null ? '' : json['occupation'];
    serviceproviderid = json['serviceproviderid'];
    aboutus = json['aboutus'] == null ? '' : json['aboutus'];
    workinghistory =
        json['workinghistory'] == null ? '' : json['workinghistory'];
    companyname = json['companyname'] == null ? '' : json['companyname'];
    otherlink = json['otherlink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['_id'] = this.id;
    json['name'] = this.name;
    json['profileimg'] = this.profileimg;
    json['youtube'] = this.youtube;
    json['linkdin'] = this.linkdin;
    json['location'] = this.location;
    json['creditcard'] = this.creditcard;
    json['cardcvv'] = this.cardcvv;
    json['cardpin'] = this.cardpin;
    json['cardexpirydate'] = this.cardexpirydate;
    json['dailycharge'] = this.dailycharge;
    json['occupation'] = this.occupation;
    json['serviceproviderid'] = this.serviceproviderid;
    json['otherlink'] = this.otherlink;
    return json;
  }
}

class ProfileApi with ChangeNotifier {
  Future<ProfileModal> getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    final response = await http.post('${Constant.apiLink}getprofile',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "userid": userId,
        }));
    Map<dynamic, dynamic> mapProfile = json.decode(response.body);
    print(mapProfile);
    final objProfileModal = ProfileModal.fromJson(mapProfile['data']);
    print("Profile NAme" + objProfileModal.name);
    if (mapProfile.containsKey('err')) {
      print(mapProfile['err']);
      throw mapProfile['err'];
    } else {
      if (response.statusCode == 200) {
        print(mapProfile['data']);
        return objProfileModal;
      } else {
        throw "Fail To Load";
      }
    }
  }

  // Future<void> updateProWithimg({
  //   String name,
  //   String ytLink,
  //   String lkdinLink,
  //   String location,
  //   File image,
  //   String creditcard,
  //   String occupation,
  //   String cvv,
  //   String pin,
  //   String date,
  //   String dailyCharge,
  //   String aboutUs,
  //   String workingHistory,
  //   List<dynamic> otherLink,
  // }) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final userId = sharedPreferences.getString('userid');
  //   final bytes = File(image.path).readAsBytesSync();
  //   String img64 = base64Encode(bytes);
  //   print(img64);
  //   final response = await http.post(
  //     '${Constant.apiLink}updateprofile',
  //     headers: {"Content-Type": "application/x-www-form-urlencoded"},
  //     body: {
  //       "userid": userId,
  //       "profileimg": img64,
  //       "name": name,
  //       "youtube": ytLink,
  //       "linkdin": lkdinLink,
  //       "location": location,
  //       "creditcard": creditcard,
  //       "occupation": occupation,
  //       "cardcvv": cvv,
  //       "cardpin": pin,
  //       "cardexpirydate": date,
  //       "dailycharge": dailyCharge,
  //       "aboutus": aboutUs,
  //       "workinghistory": workingHistory,
  //       "otherlink": otherLink,
  //     },
  //   );
  //   Map<dynamic, dynamic> map = json.decode(response.body);
  //   print(map);
  //   if (map.containsKey('err')) {
  //     print("Error Occured");
  //     print(map['err']);
  //     throw map['err'];
  //   } else {
  //     if (response.statusCode == 200) {
  //       print(map['data']);
  //     } else {
  //       throw "Fail to load";
  //     }
  //   }
  // }

  Future<void> updatePro({
    String name,
    String ytLink,
    String lkdinLink,
    String location,
    String creditcard,
    String occupation,
    String cvv,
    String pin,
    String date,
    String image,
    String dailyCharge,
    String aboutUs,
    String workingHistory,
    List<dynamic> otherLink,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    print(name);
    print(ytLink);
    print(lkdinLink);
    print(location);
    print(creditcard);
    print(occupation);
    print(cvv);
    print(pin);
    print(date);
    print(dailyCharge);

    final response = await http.post(
      '${Constant.apiLink}updateprofile',
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "userid": userId,
        "name": name,
        "profileimg": image,
        "youtube": ytLink,
        "linkdin": lkdinLink,
        "location": location,
        "creditcard": creditcard,
        "occupation": occupation,
        "cardcvv": cvv,
        "cardpin": pin,
        "cardexpirydate": date,
        "dailycharge": dailyCharge,
        "aboutus": aboutUs,
        "workinghistory": workingHistory,
        "otherlink": otherLink,
      }),
    );
    Map<dynamic, dynamic> map = json.decode(response.body);
    print(map);
    if (map.containsKey('err')) {
      print("Error Occured");
      print(map['err']);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        print(map['data']);
        sharedPreferences.setString('name', name);
      } else {
        throw "Fail to load";
      }
    }
  }
}
