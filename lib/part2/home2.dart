import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userapidata/part2/model2.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 1,
      //   shadowColor: const Color.fromARGB(255, 101, 67, 67),
      //   title: const Center(
      //       child: Text(
      //     'API',
      //     style: TextStyle(
      //         fontSize: 40,
      //         fontWeight: FontWeight.w800,
      //         letterSpacing: 2,
      //         color: Color.fromARGB(255, 49, 45, 45)),
      //   )),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(07.0),
        child: Column(
          children: [
            storyview(),
            Expanded(
              child: FutureBuilder<Imgdata>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(snapshot.data!.data[index].user.name),
                              subtitle:
                                  Text(snapshot.data!.data[index].user.email),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapshot.data!.data[index].user.img),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width * 1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data[index].images.length,
                                itemBuilder: (context, imgcount) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .37,
                                      width: MediaQuery.of(context).size.width *
                                          .51,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                              snapshot.data!.data[index]
                                                  .images[imgcount].imagename,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .24,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .53,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(snapshot
                                                    .data!
                                                    .data[index]
                                                    .images[imgcount]
                                                    .url
                                                    .toString()),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget storyview() {
    return FutureBuilder<Imgdata>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 125,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CircleAvatar(
                        foregroundColor: Colors.orange,
                        backgroundColor:
                            const Color.fromARGB(255, 245, 234, 234),
                        radius: 32,
                        backgroundImage:
                            NetworkImage(snapshot.data!.data[index].user.img),
                      ),
                    ),
                    Text(snapshot.data!.data[index].user.name),
                  ],
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Row userdatatext(int index, String name, String user) {
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

  Future<Imgdata> getData() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/b67f0a52-acd2-4fa2-bdf0-9ec5e47a2517'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return Imgdata.fromJson(data);
    } else {
      return Imgdata.fromJson(data);
    }
  }
}
