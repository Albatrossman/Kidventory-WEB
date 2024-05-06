import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';

class RosterScreen extends StatelessWidget {
  final List<Member> members;

  const RosterScreen({
    super.key,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          SheetHeader(title: Text("Roster (${members.length} Participants)")),
      body: SafeArea(
        bottom: false,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return Column(
              children: [
                ListTile(
                  title: Text('${member.firstName} ${member.lastName}'),
                  subtitle: Text(member.email),
                  leading: CircleAvatar(
                    child: Text(member.firstName[0]),
                  ),
                  trailing: Text('Age: ${member.age}'),
                ),
                if (index < members.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
