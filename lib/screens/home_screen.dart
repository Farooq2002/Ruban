import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:ruban/screens/languages.dart';
import 'package:ruban/screens/sign_up.dart';
import 'package:ruban/screens/user_information_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  final searchController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: Icon(Icons.arrow_back),
        title: const LocaleText(
          'HOME',
          style: TextStyle(letterSpacing: 2),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LanguageScreen()));
              },
              icon: const Icon(Icons.language))
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: searchController,
                    onChanged: (val) {
                      setState(() {
                        // name = val;
                      });
                    },
                    decoration: const InputDecoration(
                        hintText: 'SEARCH', suffixIcon: Icon(Icons.search)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      if (searchController.text.isEmpty) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UserInformation(data: data)));
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['imageUrl']),
                          ),
                          title:
                              Text("${data['firstName']}  ${data['lastName']}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['email']),
                              Text(data['languages']),
                            ],
                          ),
                        );
                      } else if (data['firstName']
                              .toString()
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          data['email']
                              .toString()
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          data['languages']
                              .toString()
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UserInformation(data: data)));
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['imageUrl']),
                          ),
                          title:
                              Text(data['firstName'] + " " + data['lastName']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['email']),
                              Text(data['languages']),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
