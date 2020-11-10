import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/helpers/Constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AllProjects {
  List<Byme> byme;
  List<ByThem> bythem;

  AllProjects({this.byme, this.bythem});

  AllProjects.fromJson(Map<String, dynamic> json) {
    if (json['byme'] != null) {
      byme = new List<Byme>();
      json['byme'].forEach((v) {
        byme.add(new Byme.fromJson(v));
      });
    }
    if (json['bythem'] != null) {
      bythem = new List<ByThem>();
      json['bythem'].forEach((v) {
        bythem.add(new ByThem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.byme != null) {
      data['byme'] = this.byme.map((v) => v.toJson()).toList();
    }
    if (this.bythem != null) {
      data['bythem'] = this.bythem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Byme {
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

  Byme(
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

  Byme.fromJson(Map<String, dynamic> json) {
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

class ByThem {
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

  ByThem(
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

  ByThem.fromJson(Map<String, dynamic> json) {
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

class ProjectProvider with ChangeNotifier {
  List<Byme> _projectListByMe = [];

  List<Byme> get projectListByMe {
    return [..._projectListByMe];
  }

  List<ByThem> _projectListByThem = [];

  List<ByThem> get projectListByThem {
    return [..._projectListByThem];
  }

  Future<void> loadAllProject() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    print(userId);
    final response = await http.post(
      '${apiLink}assignProjectList',
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
        final projectModal = AllProjects.fromJson(map['data']);
        _projectListByMe = projectModal.byme;
        _projectListByThem = projectModal.bythem;
        notifyListeners();
        print(projectModal.byme.length);
      } else {
        throw "Fail to load";
      }
    }
  }

  Future<void> addProject({
    String what,
    String where,
    String projectName,
    String startDate,
    String endDate,
    String rate,
    List<String> taskList,
    List<Map> memberList,
    String address,
    String link,
    String usages,
    String notes,
  }) async {
    print(what);
    print(where);
    print(startDate);
    print(rate);
    print(address);
    print(link);
    print(usages);
    print(notes);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    print(userId);
    final response = await http.post(
      '${apiLink}addproject',
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "userid": userId,
        "name": projectName,
        "what": what,
        "where": where,
        "start_date": startDate,
        "end_date": endDate,
        "address": address,
        "price": rate,
        "members": memberList,
        "tasks": taskList,
        "link": link,
        "usages": usages,
        "notes": notes,
        "status": 1
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
      } else {
        throw "Fail to load";
      }
    }
  }

  Future<void> acceptProjectRequest({String projId, int status}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    print(userId);
    final response = await http.post(
      '${apiLink}contractStatus',
      headers: {"Content-Type": "application/json"},
      body:
          json.encode({"userid": userId, "projectid": projId, "type": status}),
    );
    Map<dynamic, dynamic> map = json.decode(response.body);
    // print(map);
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
