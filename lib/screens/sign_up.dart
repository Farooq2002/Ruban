import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruban/screens/home_screen.dart';
import 'package:ruban/screens/widgets/custom_tfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumController = TextEditingController();
  final workCompanyController = TextEditingController();
  final jobRoleController = TextEditingController();
  final langController = TextEditingController();
  bool validate = false;
  bool loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneNumController.dispose();
    workCompanyController.dispose();
    jobRoleController.dispose();
    langController.dispose();
  }

  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(msg: 'pick an image please!');
      }
    });
  }

  String? imageUrl;
  uploadImage() async {
    FirebaseStorage fs = FirebaseStorage.instance;
    Reference ref =
        fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
    await ref.putFile(File(_image!.path));
    imageUrl = await ref.getDownloadURL();
  }

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGN UP'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 13,
            ),
            InkWell(
              onTap: () {
                getImage();
              },
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: _image != null
                    ? Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: Image.file(
                          _image!.absolute,
                          fit: BoxFit.fill,
                        ),
                      )
                    : const Center(
                        child: Text(
                        'Image',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Row(
                children: [
                  Expanded(
                      child: CustomTField(
                    label: 'First Name',
                    kType: TextInputType.text,
                    controller: firstnameController,
                    title: 'First name',
                    icon: Icons.navigate_next,
                    errorText: validate ? 'Value Can\'t Be Empty' : null,
                  )),
                  Expanded(
                      child: CustomTField(
                    label: 'Last Name',
                    kType: TextInputType.text,
                    controller: lastnameController,
                    title: 'Last name',
                    icon: Icons.navigate_next,
                  ))
                ],
              ),
            ),
            CustomTField(
              label: 'Email',
              kType: TextInputType.emailAddress,
              controller: emailController,
              title: 'Email address',
              icon: Icons.navigate_next,
              errorText: validate ? 'Value Can\'t Be Empty' : null,
            ),
            CustomTField(
              label: 'Phone',
              kType: TextInputType.phone,
              controller: phoneNumController,
              title: 'Phone Number',
              icon: Icons.navigate_next,
              errorText: validate ? 'Value Can\'t Be Empty' : null,
            ),
            CustomTField(
              label: 'Work Company',
              kType: TextInputType.text,
              controller: workCompanyController,
              title: 'Work Company',
              icon: Icons.navigate_next,
              errorText: validate ? 'Value Can\'t Be Empty' : null,
            ),
            CustomTField(
              label: 'Job Role',
              kType: TextInputType.text,
              controller: jobRoleController,
              title: 'Job Role',
              icon: Icons.navigate_next,
              errorText: validate ? 'Value Can\'t Be Empty' : null,
            ),
            CustomTField(
              label: 'Languages',
              kType: TextInputType.text,
              controller: langController,
              title: 'Languages',
              icon: Icons.navigate_next,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        try {
                          if (firstnameController.text.isEmpty) {
                            showCustomMsg(context, "First Name Is Empty");
                          } else if (lastnameController.text.isEmpty) {
                            showCustomMsg(context, "Last Name Is Empty");
                          } else if (emailController.text.isEmpty ||
                              !emailController.text.contains("@")) {
                            showCustomMsg(context,
                                "Email Must Be Filled Or Invalid Email");
                          } else if (phoneNumController.text.isEmpty) {
                            showCustomMsg(context, "Please enter phone number");
                          } else if (workCompanyController.text.isEmpty) {
                            showCustomMsg(context, "Please enter work company");
                          } else if (jobRoleController.text.isEmpty) {
                            showCustomMsg(
                                context, "Please enter your job role");
                          } else if (langController.text.isEmpty) {
                            showCustomMsg(context, "Please enter languages!");
                          } else if (_image == null) {
                            showCustomMsg(context, "Please select an image");
                          } else {
                            FirebaseStorage fs = FirebaseStorage.instance;
                            Reference ref = await fs.ref().child(DateTime.now()
                                .millisecondsSinceEpoch
                                .toString());
                            await ref.putFile(File(_image!.path));
                            imageUrl = await ref.getDownloadURL();
                            await FirebaseFirestore.instance
                                .collection("users")
                                .add({
                              "firstName": firstnameController.text,
                              "lastName": lastnameController.text,
                              "email": emailController.text,
                              "phone": phoneNumController.text,
                              "role": jobRoleController.text,
                              "workCompany": workCompanyController.text,
                              "languages": langController.text,
                              "imageUrl": imageUrl!,
                            });

                            showCustomMsg(
                                context, "Your profile is completed!");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                          setState(() {
                            loading = false;
                          });
                        } catch (e) {
                          showCustomMsg(context, e.toString());
                        }
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                        child: Text("Submit"),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

showCustomMsg(BuildContext context, String msg) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg)));
}
