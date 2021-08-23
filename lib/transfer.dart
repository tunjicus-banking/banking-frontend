import 'package:bank/repositories/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class Transfer extends StatefulWidget {
//   @override
//   _TransferState createState() => _TransferState();
// }

// class _TransferState extends State<Transfer> {
//   String userQuery = '';
//   @override
//   Widget build(BuildContext ctx) {}
// }

// class UserAutocomplete extends StatefulWidget {
//   final String searchQuery;

//   UserAutocomplete(this.searchQuery);

//   @override
//   _UserAutocompleteState createState() =>
//       _UserAutocompleteState(this.searchQuery);
// }

class UserAutocomplete extends HookWidget {
  @override
  Widget build(BuildContext ctx) {
    final thisQuery = useState('');
    final repository = useProvider(usersRepositoryProvider);
    final users = repository.findOne(5);
    return FutureBuilder(
        future: users,
        builder: (ctx, AsyncSnapshot<User?> users) {
          return Scaffold(
              body: Column(
            children: [
              SizedBox(height: 200),
              Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                thisQuery.value = textEditingValue.text;
                return [users.data?.firstName ?? ''];
              })
            ],
          ));
        });
  }
}
