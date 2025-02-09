import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/VechileScreen/HomePage.dart';
import 'package:flutter_map/model/VechileModel.dart';

import 'package:flutter_map/router/AppRouteConstant.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class MyWidget extends StatefulWidget {
  final String name;
  const MyWidget({super.key, required this.name});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  VechileModel? model;

  @override
  void initState() {
    super.initState();
    // Hive.registerAdapter(VechileModelAdapter());
    showData(widget.name);
  }

  showData(String name) async {
    await Hive.openBox<VechileModel>('VechileDatas');

    Box<VechileModel> box = Hive.box<VechileModel>('VechileDatas');
    VechileModel? catModel = box.get(name);
    setState(() {
      model = catModel!;
      debugPrint(model!.vechileName.toString());
    });
  }

  List<Widget> bottomNavScreen() => [
        Homepage(
          name: widget.name,
        )
      ];

  final List<BottomNavigationBarItem> bottomNavItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.document_scanner_sharp), label: "Proparsal"),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "BookMark"),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> screen = bottomNavScreen();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: const Color.fromARGB(143, 70, 143, 185),
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(AppRouteConstant.VechileEdit,
                      pathParameters: {'name': widget.name});
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: screen[0],
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: 0,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (index) {},
          type: BottomNavigationBarType.fixed,
        ),
        resizeToAvoidBottomInset: false);
  }

  Widget customDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 11, 88, 131),
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 11, 88, 131)),
              accountName: Text(model!.vechileName),

              accountEmail: Text(model!.vechileAge),
              currentAccountPictureSize: const Size.square(48),
              currentAccountPicture: CircleAvatar(
                backgroundImage: FileImage(File(model!.vechileImage)),
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(' Home'),
            onTap: () {
              // GoRouter.of(context).pushNamed(AppRouteConstant.jobHomePage);
            },
          ),
          ListTile(
            leading: const Icon(Icons.document_scanner_sharp),
            title: const Text(' Proporsals'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text(' Saved'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text(' Chat'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
