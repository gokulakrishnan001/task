import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_map/components/CustomTextField.dart';

import 'package:flutter_map/model/VechileModel.dart';
import 'package:flutter_map/router/AppRouteConstant.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class Editingpage extends StatefulWidget {
  final String name;
  const Editingpage({super.key, required this.name});

  @override
  State<Editingpage> createState() => _EditingpageState();
}

class _EditingpageState extends State<Editingpage> {
  late VechileModel model;
  TextEditingController Vechilename = TextEditingController();

  TextEditingController VechileImage = TextEditingController();
  TextEditingController VechileMileage = TextEditingController();
  TextEditingController VechileAge = TextEditingController();

  final formKey = GlobalKey<FormState>();
  Uint8List? image;
  File? imageFile;

  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Hive.registerAdapter(VechileModelAdapter());
    showData(widget.name);
    // Vechilename.text = model.VechileName;
  }

  showData(String name) async {
    await Hive.openBox<VechileModel>('VechileDatas');

    Box<VechileModel> box = Hive.box<VechileModel>('VechileDatas');
    VechileModel? catModel = box.get(name);
    setState(() {
      model = catModel!;
      Vechilename.text = model.vechileName;
      VechileMileage.text = model.vechileMileage;
      VechileAge.text = model.vechileAge;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Edit"),
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pushNamed(AppRouteConstant.VechileLand,
                  pathParameters: {'name': Vechilename.text});
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Hello, there !!',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 117, 117, 117)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Create a new account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                  child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      takePhoto();
                    },
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
                            fit: BoxFit.cover,
                            image: FileImage(File(model.vechileImage))),
                      ),
                    ),
                  ),
                ],
              )),
              Form(
                  key: formKey,
                  child: Column(children: <Widget>[
                    CustomFormTextField(
                      controller: Vechilename,
                      hint: "Vechile Name",
                      obsecureText: false,
                      label: "Enter a Vechile name",
                      validator: (value) => Validator.validateName(name: value),
                      pIcon: Icons.person_2_outlined,
                      action: TextInputAction.next,
                    ),
                    CustomFormTextField(
                      enable: false,
                      controller: VechileAge,
                      hint: "Vechile Age",
                      label: "Enter a Vechile Age",
                      obsecureText: false,
                      validator: (value) =>
                          Validator.validatePhone(mobile: value),
                      pIcon: Icons.phone_outlined,
                      action: TextInputAction.next,
                    ),
                    CustomFormTextField(
                      controller: VechileMileage,
                      hint: "Vechile Mileage in ltr",
                      label: "Enter a Vechile Mileage in ltr",
                      obsecureText: false,
                      validator: (value) => Validator.validateName(name: value),
                      pIcon: Icons.phone_outlined,
                      action: TextInputAction.next,
                    ),
                  ])),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: CustomButton(
                    text: 'Save',
                    onPressed: () {
                      if (isVaild()) {
                        //  _postData();
                        registerData();
                        SnackBar snackBar = snackBarField("Saved Sucessfully");
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Future.delayed(const Duration(seconds: 2), () {});
                      }
                    }),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    'Already a user?',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 79, 79, 79)),
                  ),
                  InkWell(
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(
                            255,
                            47,
                            142,
                            194,
                          )),
                    ),
                    onTap: () {
                      // showData();
                    },
                  )
                ]),
              )
            ],
          ),
        )),
      ),
    );
  }

  bool isVaild() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  Future takePhoto() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 320, maxWidth: 320);
    setState(() {
      imageFile = File(pickedFile!.path);
      image = File(pickedFile.path).readAsBytesSync();
    });
  }

  void registerData() async {
    await Hive.openBox<VechileModel>('VechileDatas');

    Box<VechileModel> box = Hive.box<VechileModel>('VechileDatas');
    
    var data = VechileModel(Vechilename.text, model.vechileMileage,
        VechileImage.text, VechileAge.text); //creating object
    await box.put(data.vechileName, data);
  }
}
