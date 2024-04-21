import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';

class RosterScreen extends StatelessWidget {
  final List<Member> members;

  const RosterScreen({
    super.key,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Roster (${members.length} Participants)"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return ListTile(
                title: Text('${member.firstName} ${member.lastName}'),
                subtitle: Text(member.email),
                leading: CircleAvatar(
                  child: Text(member.firstName[0]),
                ),
                trailing: Text('Age: ${member.age}'),
              );
            },
          ),
        ),
      ),
    );
  }
}