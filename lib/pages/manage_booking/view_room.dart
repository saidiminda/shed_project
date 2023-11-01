import 'package:flutter/material.dart';

class ViewRoom extends StatefulWidget {
  const ViewRoom({super.key});

  @override
  State<ViewRoom> createState() => _ViewRoomState();
}

class _ViewRoomState extends State<ViewRoom> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
  // itemCount: transactionList.length,
  itemBuilder: (BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            // leading: CircleAvatar(
            //   backgroundImage: NetworkImage(transactionList[index].avatar),
            // ),
            // title: Text(transactionList[index].name),
            // subtitle: Text(transactionList[index].date),
            // trailing: Text(transactionList[index].amount),
          ),
        ],
      ),
    );
  },
)
;
  }
}