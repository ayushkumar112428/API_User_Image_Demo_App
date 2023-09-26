import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:userapidata/model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserDetails> userDetails = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: const Color.fromARGB(255, 101, 67, 67),
        title: const Center(child: Text('API',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w800,letterSpacing: 2, color: Color.fromARGB(255, 49, 45, 45)),)),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: userDetails.length,
              itemBuilder: (context, index) {
                return Container(
                  // height: 200,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 60, 51, 51),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 5),
                  child: Column(
                    children: [
                      userdatatext(index, "Name" ,userDetails[index].name),
                      userdatatext(index, "User Name" ,userDetails[index].username),
                      userdatatext(index, "Email",userDetails[index].email),
                      userdatatext(index, "Mobile No",userDetails[index].phone),
                      userdatatext(index, "Website",userDetails[index].website),
                      userdatatext(index, "Company Name",userDetails[index].company.name),
                      userdatatext(index, "Address",userDetails[index].address.suite+userDetails[index].address.city+userDetails[index].address.street+userDetails[index].address.zipcode),
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Row userdatatext(int index, String name , String user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$name : ",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Text(
            user,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 1,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Future<List<UserDetails>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        userDetails.add(UserDetails.fromJson(index));
      }
      return userDetails;
    } else {
      return userDetails;
    }
  }
}
