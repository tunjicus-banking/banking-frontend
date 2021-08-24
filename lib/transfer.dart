import 'package:bank/repositories/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserAutocomplete extends HookWidget {
  @override
  Widget build(BuildContext ctx) {
    final repository = useProvider(usersRepositoryProvider);
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 200),
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              decoration: InputDecoration(border: OutlineInputBorder())),
          suggestionsCallback: (pattern) async {
            return await repository
                .findAll(remote: true, params: {'name': pattern});
          },
          itemBuilder: (context, User suggestion) {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(suggestion.firstName),
            );
          },
          onSuggestionSelected: (suggestion) => {},
          noItemsFoundBuilder: (ctx) => ListTile(title: Text("No users found")),
        )
      ],
    ));
  }
}
