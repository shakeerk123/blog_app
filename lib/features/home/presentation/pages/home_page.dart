import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: (){}, icon:const Icon(CupertinoIcons.add_circled))],
        title: const Text("Blogify"),
      ),
    );
  }
}
