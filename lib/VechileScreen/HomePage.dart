import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_map/model/VechileModel.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  final String name;
  const Homepage({super.key, required this.name});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
   VechileModel? model;

  @override
  void initState() {
    super.initState();
    //Hive.registerAdapter(BussinessModelAdapter());
    showData(widget.name);
  }

  showData(String name) async {
    await Hive.openBox<VechileModel>('VechileDatas');

    Box<VechileModel> box = Hive.box<VechileModel>('VechileDatas');
    VechileModel? vechileModel = box.get(name);
    setState(() {
      model = vechileModel!;
    });

    return vechileModel;
  }

  @override
  Widget build(BuildContext context) {
 return   model == null ? const  Center(child: CircularProgressIndicator(),): Card(
      
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 300,
        child: Column(children: [
          Container(
            width: double.infinity,
            
            padding: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Welcome',
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 117, 117, 117)),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Your DashBoard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
              child: Stack(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white54),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 2,
                          color: Colors.black.withOpacity(0.1))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(File(model!.vechileImage)))),
                  ),
                ),
              
              
            ],
          )),
           Text(
              model!.vechileName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
              model!.vechileMileage,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

        ]),
      ),
    );
  }
}
