import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/helpers/constant.dart' as Constant;

class ServiceModel {
  String id;
  String self;
  String website;
  String where;
  String vatnumber;
  String registrationnumber;
  String respersonname;
  String respersonemail;
  String affiliatedprog;
  String tags;
  String teamid;
  String membership;
  String address;
  String aboutus;
  String ads;
  String billings;
  String discountdetails;
  String couponcode;
  String image1;
  String image2;
  String image3;
  String logo;
  String policystatus;

  ServiceModel({
    this.id,
    this.self,
    this.website,
    this.where,
    this.vatnumber,
    this.registrationnumber,
    this.respersonname,
    this.respersonemail,
    this.affiliatedprog,
    this.tags,
    this.teamid,
    this.membership,
    this.address,
    this.aboutus,
    this.ads,
    this.billings,
    this.discountdetails,
    this.couponcode,
    this.image1,
    this.image2,
    this.image3,
    this.logo,
    this.policystatus,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    print("jason" + json.toString());
    id = json['_id'];
    self = json['self'];
    website = json['website'];
    where = json['where'];
    vatnumber = json['vatnumber'];
    registrationnumber = json['registrationnumber'];
    respersonname = json['respersonname'];
    respersonemail = json['respersonemail'];
    affiliatedprog = json['affiliatedprog'];
    tags = json['tags'];
    teamid = json['teamid'].toString();
    membership = json['membership'];
    address = json['address'];
    aboutus = json['aboutus'];
    ads = json['ads'];
    billings = json['billings'];
    discountdetails = json['discountdetails'];
    couponcode = json['couponcode'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    logo = json['logo'];
    policystatus = json['policystatus'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['_id'] = this.self;
    json['self'] = this.self;
    json['website'] = this.website;
    json['where'] = this.where;
    json['vatnumber'] = this.vatnumber;
    json['registrationnumber'] = this.registrationnumber;
    json['respersonname'] = this.respersonname;
    json['respersonemail'] = this.respersonemail;
    json['affiliatedprog'] = this.affiliatedprog;
    json['tags'] = this.tags;
    json['teamid'] = this.teamid;
    json['membership'] = this.membership;
    json['address'] = this.address;
    json['aboutus'] = this.aboutus;
    json['ads'] = this.ads;
    json['billings'] = this.billings;
    json['discountdetails'] = this.discountdetails;
    json['couponcode'] = this.couponcode;
    json['image1'] = this.image1;
    json['image2'] = this.image2;
    json['image3'] = this.image3;
    json['logo'] = this.logo;
    json['policystatus'] = this.policystatus;
    return json;
  }
}

class ServiceProviderApi with ChangeNotifier {
  Future<List<dynamic>> getServiceProvider() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    final response = await http.post('${Constant.apiLink}getserviceprovider',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "userid": userId,
        }));
    Map<dynamic, dynamic> map = json.decode(response.body);
    print(map);
    final objModel = ServiceModel.fromJson(map['data']);
    if (map.containsKey('err')) {
      print(map['err']);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        print(map['data']);
      } else {
        throw Exception("Fail To Load");
      }
    }
    return [response.statusCode, objModel];
  }

  Future<void> updateServiceProvider({
    String id,
    String self,
    String website,
    String where,
    String vatnumber,
    String registrationnumber,
    String respersonname,
    String respersonemail,
    String affiliatedprog,
    String tags,
    String teamid,
    String membership,
    String address,
    String aboutus,
    String ads,
    String billings,
    String discountdetails,
    String couponcode,
    String image1,
    String image2,
    String image3,
    String logo,
    bool check,
  }) async {
    print(self);
    print(website);
    print(where);
    print(vatnumber);
    print(registrationnumber);
    print(respersonname);
    print(respersonemail);
    print(affiliatedprog);
    print(tags);
    print(teamid);
    print(membership);
    print(address);
    print(aboutus);
    print(ads);
    print(billings);
    print(discountdetails);
    print(couponcode);

    print("logo" + logo);
    print(image1);
    print(image2);
    print(image3);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    final response = await http.post(
      '${Constant.apiLink}updateserviceprovider',
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "userid": userId,
        "serviceproviderid": id,
        "website": website,
        "where": where,
        "vatnumber": vatnumber,
        "registrationnumber": registrationnumber,
        "respersonname": respersonname,
        "respersonemail": respersonemail,
        "affiliatedprog": affiliatedprog,
        "tags": tags,
        "teamid": teamid,
        "membership": membership,
        "address": address,
        "aboutus": aboutus,
        "ads": ads,
        "billings": billings,
        "discountdetails": discountdetails,
        "couponcode": couponcode,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "logo": logo,
        "policystatus": check ? "1" : "0"
      },
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
      } else {
        throw "Fail to load";
      }
    }
  }
}
