import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('CategoriesScreen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
