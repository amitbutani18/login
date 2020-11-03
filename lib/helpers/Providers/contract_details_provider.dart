import 'package:flutter/cupertino.dart';
import 'package:login/screens/contract.dart';

class ContractD {
  final String id;
  final String projectDetail;
  final String location;
  final List<String> teamMembers;
  final List<Map> taskList;
  final String amount;
  final String date;

  ContractD(
      {this.id,
      this.projectDetail,
      this.amount,
      this.date,
      this.location,
      this.taskList,
      this.teamMembers});
}

class ContractDetailProvider with ChangeNotifier {
  ContractD _contract = ContractD(
    id: 'a',
    amount: '50',
    date: '1/22/1111',
    location: 'Surat',
    projectDetail: 'Lorem ipsum ni nnfj nfkdms knvjd',
    taskList: [
      {'init': false, 'content': 'Lorem ipsum ni nnfj nfkdms knvjd'},
      {
        'init': false,
        'content': ' Amit Butani Lorem ipsum ni nnfj nfkdms knvjd'
      },
      {
        'init': false,
        'content': 'Hllo nsfbdsj Lorem ipsum ni nnfj nfkdms knvjd'
      },
    ],
    teamMembers: [
      'Akash Gajera',
      'Akash Gajera',
      'Akash Gajera',
    ],
  );
  ContractD get contract {
    return _contract;
  }
}
