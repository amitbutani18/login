import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/helpers/Constant/constant.dart';
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AllRequests {
  List<Byme> sendrequest;
  List<Receiverequest> receiverequest;

  AllRequests({this.sendrequest, this.receiverequest});

  AllRequests.fromJson(Map<String, dynamic> json) {
    if (json['sendrequest'] != null) {
      sendrequest = new List<Byme>();
      json['sendrequest'].forEach((v) {
        sendrequest.add(new Byme.fromJson(v));
      });
    }
    if (json['receiverequest'] != null) {
      receiverequest = new List<Receiverequest>();
      json['receiverequest'].forEach((v) {
        receiverequest.add(new Receiverequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sendrequest != null) {
      data['sendrequest'] = this.sendrequest.map((v) => v.toJson()).toList();
    }
    if (this.receiverequest != null) {
      data['receiverequest'] =
          this.receiverequest.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Receiverequest {
  List<String> tasks;
  String sId;
  String userid;
  String name;
  String what;
  String where;
  String startDate;
  String endDate;
  String address;
  int price;
  List<Members> members;
  String link;
  String usages;
  String notes;
  int status;
  String updatedat;
  String createdat;
  int iV;

  Receiverequest(
      {this.tasks,
      this.sId,
      this.userid,
      this.name,
      this.what,
      this.where,
      this.startDate,
      this.endDate,
      this.address,
      this.price,
      this.members,
      this.link,
      this.usages,
      this.notes,
      this.status,
      this.updatedat,
      this.createdat,
      this.iV});

  Receiverequest.fromJson(Map<String, dynamic> json) {
    tasks = json['tasks'].cast<String>();
    sId = json['_id'];
    userid = json['userid'];
    name = json['name'];
    what = json['what'];
    where = json['where'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    address = json['address'];
    price = json['price'];
    if (json['members'] != null) {
      members = new List<Members>();
      json['members'].forEach((v) {
        members.add(new Members.fromJson(v));
      });
    }
    link = json['link'];
    usages = json['usages'];
    notes = json['notes'];
    status = json['status'];
    updatedat = json['updatedat'];
    createdat = json['createdat'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tasks'] = this.tasks;
    data['_id'] = this.sId;
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['what'] = this.what;
    data['where'] = this.where;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['address'] = this.address;
    data['price'] = this.price;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    data['link'] = this.link;
    data['usages'] = this.usages;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['updatedat'] = this.updatedat;
    data['createdat'] = this.createdat;
    data['__v'] = this.iV;
    return data;
  }
}

// class Byme {
//   List<String> tasks;
//   String sId;
//   String userid;
//   String name;
//   String what;
//   String where;
//   String startDate;
//   String endDate;
//   String address;
//   int price;
//   List<Members> members;
//   String link;
//   String usages;
//   String notes;
//   int status;
//   String updatedat;
//   String createdat;
//   int iV;

//   Byme(
//       {this.tasks,
//       this.sId,
//       this.userid,
//       this.name,
//       this.what,
//       this.where,
//       this.startDate,
//       this.endDate,
//       this.address,
//       this.price,
//       this.members,
//       this.link,
//       this.usages,
//       this.notes,
//       this.status,
//       this.updatedat,
//       this.createdat,
//       this.iV});

//   Byme.fromJson(Map<String, dynamic> json) {
//     tasks = json['tasks'].cast<String>();
//     sId = json['_id'];
//     userid = json['userid'];
//     name = json['name'];
//     what = json['what'];
//     where = json['where'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     address = json['address'];
//     price = json['price'];
//     if (json['members'] != null) {
//       members = new List<Members>();
//       json['members'].forEach((v) {
//         members.add(new Members.fromJson(v));
//       });
//     }
//     link = json['link'];
//     usages = json['usages'];
//     notes = json['notes'];
//     status = json['status'];
//     updatedat = json['updatedat'];
//     createdat = json['createdat'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['tasks'] = this.tasks;
//     data['_id'] = this.sId;
//     data['userid'] = this.userid;
//     data['name'] = this.name;
//     data['what'] = this.what;
//     data['where'] = this.where;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['address'] = this.address;
//     data['price'] = this.price;
//     if (this.members != null) {
//       data['members'] = this.members.map((v) => v.toJson()).toList();
//     }
//     data['link'] = this.link;
//     data['usages'] = this.usages;
//     data['notes'] = this.notes;
//     data['status'] = this.status;
//     data['updatedat'] = this.updatedat;
//     data['createdat'] = this.createdat;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

class Members {
  String sId;
  String userid;
  int status;

  Members({this.sId, this.userid, this.status});

  Members.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userid = json['userid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userid'] = this.userid;
    data['status'] = this.status;
    return data;
  }
}

class RequestProvider with ChangeNotifier {
  List<Byme> _sendRequestList = [];

  List<Byme> get sendRequest {
    return [..._sendRequestList];
  }

  List<Receiverequest> _reciveRequestList = [];

  List<Receiverequest> get reciveRequest {
    return [..._reciveRequestList];
  }

  Future<void> loadAllProjectRequests() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    print(userId);
    final response = await http.post(
      '${apiLink}assignProjectRequest',
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "userid": userId,
      }),
    );
    Map<dynamic, dynamic> map = json.decode(response.body);
    // print(map);
    if (map.containsKey('err')) {
      print("Error Occured");
      print(map['err']);
      throw map['err'];
    } else {
      if (response.statusCode == 200) {
        // print(map['data']);
        final projectModal = AllRequests.fromJson(map['data']);
        _sendRequestList = projectModal.sendrequest;
        _reciveRequestList = projectModal.receiverequest;
        notifyListeners();
        print(projectModal.receiverequest.length);
      } else {
        throw "Fail to load";
      }
    }
  }
}
