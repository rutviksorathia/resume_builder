import 'package:flutter/material.dart';

class DemoView extends StatefulWidget {
  const DemoView({super.key});

  @override
  State<DemoView> createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {
  List<String> item = [
    "GeeksforGeeks",
    "Flutter",
    "Developer",
    "Android",
    "Programming",
    "CplusPlus",
    "Python",
    "javascript"
  ];

  void reorderData(int oldindex, int newindex) {
    print(oldindex);
    print(newindex);
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = item.removeAt(oldindex);
      item.insert(newindex, items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.green[400],
          appBar: AppBar(
            title: const Text(
              "Reorderable ListView",
            ),
          ),
          body: ReorderableListView(
            onReorder: reorderData,
            children: [
              for (final items in item)
                Card(
                  color: Colors.white,
                  key: ValueKey(items),
                  elevation: 2,
                  child: Text(items),
                ),
            ],
          ),
        ));
  }
}
