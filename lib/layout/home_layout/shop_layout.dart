import 'package:flutter/material.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(child: TextButton(child: const Text('Log out'), onPressed: (){},),),
    );
  }
}
