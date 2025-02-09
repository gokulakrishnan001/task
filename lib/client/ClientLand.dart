import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_map/model/VechileModel.dart';
import 'package:hive/hive.dart';

class ClientLand extends StatefulWidget {
  const ClientLand({super.key});

  @override
  State<ClientLand> createState() => _ClientLandState();
}

class _ClientLandState extends State<ClientLand> {
  List<VechileModel>? model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.registerAdapter(VechileModelAdapter());
    showData();
  }

  void showData() async {
    await Hive.openBox<VechileModel>('VechileDatas');

    Box<VechileModel> box = Hive.box<VechileModel>('VechileDatas');
    List<VechileModel> Model = box.values.toList();

    setState(() {
      model = Model;
    });
  }

  Color getColor(String milage, String age) {
    if (int.parse(milage) > 15 && int.parse(age) < 5) {
      return Colors.green;
    } else if (int.parse(milage) > 15 && int.parse(age) > 5) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: model == null
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: model!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            color: getColor(model![index].vechileMileage,
                                model![index].vechileAge),
                            width: 2.0,
                          ),
                        ),
                        elevation: 8.0,
                        child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: FileImage(
                                      File(model![index].vechileImage),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    model![index].vechileName,
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    "Mileage ${model![index].vechileMileage} ltr",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    "Age ${model![index].vechileAge}",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey.shade600,
                                    ),
                                  )
                                ]))));
              }),
    );
  }
}
