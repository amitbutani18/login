import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:login/helpers/Constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:login/helpers/Providers/projectProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Member {
  List<Otherlink> otherlink;
  String id;
  String name;
  String email;
  String profileimg;
  String youtube;
  String linkdin;
  String location;
  String dailycharge;
  String occupation;
  String aboutus;
  String workinghistory;

  Member(
      {this.otherlink,
      this.id,
      this.name,
      this.email,
      this.profileimg,
      this.youtube,
      this.linkdin,
      this.location,
      this.dailycharge,
      this.occupation,
      this.aboutus,
      this.workinghistory});

  Member.fromJson(Map<String, dynamic> json) {
    if (json['otherlink'] != null) {
      otherlink = new List<Otherlink>();
      json['otherlink'].forEach((v) {
        otherlink.add(new Otherlink.fromJson(v));
      });
    }
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    profileimg = json['profileimg'];
    youtube = json['youtube'];
    linkdin = json['linkdin'];
    location = json['location'];
    dailycharge = json['dailycharge'];
    occupation = json['occupation'];
    aboutus = json['aboutus'];
    workinghistory = json['workinghistory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.otherlink != null) {
      data['otherlink'] = this.otherlink.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profileimg'] = this.profileimg;
    data['youtube'] = this.youtube;
    data['linkdin'] = this.linkdin;
    data['location'] = this.location;
    data['dailycharge'] = this.dailycharge;
    data['occupation'] = this.occupation;
    data['aboutus'] = this.aboutus;
    data['workinghistory'] = this.workinghistory;
    return data;
  }
}

class Otherlink {
  String title;
  String link;
  bool init;

  Otherlink({this.title, this.link, this.init});

  Otherlink.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    init = json['init'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    data['init'] = this.init;
    return data;
  }
}

class MembersProvider with ChangeNotifier {
  List<Member> _items = [];

  List<Member> _selectedMembers = [];

  List<Member> _searchedMembers = [];

  List<Member> _memberForProjectDetailScreen = [];

  List<Map<dynamic, dynamic>> _oldMemberList = [];

  List<Map<dynamic, dynamic>> get oldMemberList {
    return [..._oldMemberList];
  }

  List<Member> get memberForProjectDetailScreen {
    return [..._memberForProjectDetailScreen];
  }

  List<Member> get searchedMembers {
    return [..._searchedMembers];
  }

  List<Member> get selectedMembers {
    return [..._selectedMembers];
  }

  List<Member> get items {
    return [..._items];
  }

  Future<void> searchMember({
    String what,
    String where,
    String searchString = "",
    List<Members> members,
  }) async {
    final response = await http.post(
      '${apiLink}searchmember',
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "what": what,
        "where": where,
        "search": searchString,
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
        // print(map['data']);
        List<dynamic> list = map['data'];
        // print(list.length);
        List<Member> memberList = [];
        if (list.length != 0) {
          for (var i = 0; i < list.length; i++) {
            memberList.add(Member.fromJson(list[i]));
          }
          print(memberList[0].name);
        }
        _items = memberList;

        if (members.length != 0) {
          for (var i = 0; i < _items.length; i++) {
            for (var j = 0; j < members.length; j++) {
              //   print("Amit");
              if (_items[i].id == members[j].userid) {
                print("Match in projects " + members[j].userid);
                _selectedMembers.add(_items[i]);
              } else {
                print("not Match in projects" + members[j].userid);
              }
            }
          }
        }

        for (var i = 0; i < _selectedMembers.length; i++) {
          for (var j = 0; j < memberList.length; j++) {
            //   print("Amit");
            if (memberList[j].id == _selectedMembers[i].id) {
              print("Match" + memberList[j].id);
              memberList.remove(memberList[j]);
            } else {
              print("not Match" + memberList[j].id);
            }
          }
        }
        _searchedMembers = memberList;
        notifyListeners();
      } else {
        throw "Fail to load";
      }
    }
  }

  Future<void> addNewMemberInProject(String projId) async {
    print(_oldMemberList);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('userid');
    print(userId);
    final response = await http.post(
      '${apiLink}addProjectMembers',
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "userid": userId,
        "members": _oldMemberList,
        "projectid": projId,
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
        print(map['data']);
        // // final projectModal = AllProjects.fromJson(map['data']);
        // notifyListeners();
        // print(projectModal.byme.length);
      } else {
        throw "Fail to load";
      }
    }
  }

  searchMemberFromList(String name) {
    if (name == '') {
      _searchedMembers = _items;
    } else {
      final list = _items
          .where((member) =>
              member.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
      _searchedMembers = list;
      notifyListeners();
      print(list);
    }
  }

  selectMember(Member selectedMember) {
    _searchedMembers.removeWhere((member) => member == selectedMember);
    _items.removeWhere((member) => member == selectedMember);
    _selectedMembers.add(selectedMember);
    print(_selectedMembers.length);
    notifyListeners();
  }

  deleteMemberFromselectedMember(Member deletedMember) {
    _selectedMembers.removeWhere((member) => member == deletedMember);
    _items.add(deletedMember);
    _searchedMembers = _items;
    print(_selectedMembers.length);

    // _searchedMembers.add(deletedMember);
    notifyListeners();
  }

  addMembersForoProjectDetail(List<Members> members) {
    print(members.length);
    if (members.length != 0) {
      _memberForProjectDetailScreen = _selectedMembers;
    }
    // print(_memberForProjectDetailScreen.length);
    notifyListeners();
  }

  clearSelectedMember() {
    _selectedMembers.clear();
    _memberForProjectDetailScreen.clear();
    notifyListeners();
  }

  clearAddedMemberList() {
    _oldMemberList.clear();
    notifyListeners();
  }

  getNewMember(List<Members> members) {
    for (var i = 0; i < _memberForProjectDetailScreen.length; i++) {
      for (var j = 0; j < members.length; j++) {
        //   print("Amit");
        if (_memberForProjectDetailScreen[i].id == members[j].userid) {
          // print("Match in old member " + members[j].userid);
          _oldMemberList.add(
              {"userid": _memberForProjectDetailScreen[i].id, "status": 1});
          _memberForProjectDetailScreen
              .remove(_memberForProjectDetailScreen[i]);
        } else {
          // _oldMemberList.add(
          //     {"userid": _memberForProjectDetailScreen[i].id, "status": 0});
          print("not Match in projects" + members[j].userid);
        }
      }
    }
    for (var i = 0; i < _memberForProjectDetailScreen.length; i++) {
      _oldMemberList
          .add({"userid": _memberForProjectDetailScreen[i].id, "status": 0});
    }
    print(_memberForProjectDetailScreen);
    print(_oldMemberList);
    notifyListeners();
  }

  int get getSerchMemberListLenght {
    return _selectedMembers.length;
  }
}
