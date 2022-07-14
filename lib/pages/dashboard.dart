import 'dart:convert';
import 'package:varchas_dream_11/utilities/constants.dart';

import 'datadecoder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _MyAppState();
}
class _MyAppState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Container(
          decoration: const BoxDecoration(
            color: primaryColor,
          ),
          child: Column(
            children: [
              Container(
                width: 380,
                height: 50,
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: const Text(
                  'Total Points',
                  style: TextStyle(
                     fontSize: 22,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 400,
                height: 50,
                padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children:[
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: const EdgeInsets.fromLTRB(10,15,5,15),
                      width: 175,
                      decoration: const BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.emoji_events_sharp,size: 25,color: Colors.white,),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: const Text(
                              "Points",
                              textAlign: TextAlign.left,
                              style: kLabelTextStyleWhite,
                            ),),
                      ],
                      ),),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: const EdgeInsets.fromLTRB(10,15,5,15),
                      width: 175,
                      decoration: const BoxDecoration(
                            color: primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.leaderboard,size: 25,color: Colors.white,),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: const Text(
                            "Rank",
                            textAlign: TextAlign.left,
                            style: kLabelTextStyleWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              FutureBuilder<List<Matches>>(
                  future: readJson(),
                  builder: (context, snapshot) {
                    final matches = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          return buildMatchList(matches!);
                        }
                    }
                  }
                ),
            ],
          ),
        ),
      ),);
  }
  Widget buildMatchList(matches) => Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
        alignment: Alignment.topCenter,
        child: Container(
            width: 380,
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: 380,
                  height: 60,
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: const Text(
                    'My Matches',
                    style: TextStyle(
                      fontSize: 22,
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container (
                  margin:const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  width: 380,
                  height: 150,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: primaryColorLight,
                  ),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                          width: 380,
                          child:Wrap(
                            children: [
                              const Text(
                                "Venue:  IIT Jodhpur",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Container(
                                width: 150,
                              ),
                              Text(matches[0].matchDate,
                                style: const TextStyle(
                                    color: Colors.white
                                ),)
                            ],
                          )
                      ),
                      const Divider(
                        indent: 10,
                        endIndent: 10,
                        color: Colors.white,
                        thickness: 1,
                      ),
                      Wrap(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage("https://dshelpingforever.com/wp-content/uploads/2021/04/IIT-Jodhpur-Various-Post-Recruitment-2021-1.jpg"),
                            ),
                          ),
                          Container(
                            width: 190,
                            height: 100,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    matches[0].matchteams,
                                    style: kLabelTextStyleWhite,
                                  ),
                                  const Divider(
                                    height: 10,
                                    color: primaryColorLight,
                                  ),
                                  Text(
                                    matches[0].matchTime,
                                    style: const TextStyle(
                                      color: secondaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage("https://dshelpingforever.com/wp-content/uploads/2021/04/IIT-Jodhpur-Various-Post-Recruitment-2021-1.jpg"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container (
                  margin:const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  width: 380,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: primaryColorLight,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                        width: 380,
                        child:Wrap(
                          children: [
                          const Text(
                          "Venue:  IIT Jodhpur",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                          Container(
                            width: 150,
                          ),
                          Text(matches[1].matchDate,
                            style: const TextStyle(
                              color: Colors.white
                          ),)
                        ],
                        )
                      ),
                      const Divider(
                        indent: 10,
                        endIndent: 10,
                        color: Colors.white,
                        thickness: 1,
                      ),
                      Wrap(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage("https://dshelpingforever.com/wp-content/uploads/2021/04/IIT-Jodhpur-Various-Post-Recruitment-2021-1.jpg"),
                            ),
                          ),
                          Container(
                            width: 190,
                            height: 100,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    matches[1].matchteams,
                                    style: kLabelTextStyleWhite,
                                  ),
                                  const Divider(
                                    height: 10,
                                    color: primaryColorLight,
                                  ),
                                  Text(
                                    matches[1].matchTime,
                                    style: const TextStyle(
                                      color: secondaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage("https://dshelpingforever.com/wp-content/uploads/2021/04/IIT-Jodhpur-Various-Post-Recruitment-2021-1.jpg"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container (
                  margin:const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  width: 380,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: primaryColorLight,
                  ),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                          width: 380,
                          child:Wrap(
                            children: [
                              const Text(
                                "Venue:  IIT Jodhpur",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Container(
                                width: 150,
                              ),
                              Text(matches[2].matchDate,
                                style: const TextStyle(
                                    color: Colors.white
                                ),)
                            ],
                          )
                      ),
                      const Divider(
                        indent: 10,
                        endIndent: 10,
                        color: Colors.white,
                        thickness: 1,
                      ),
                      Wrap(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage("https://dshelpingforever.com/wp-content/uploads/2021/04/IIT-Jodhpur-Various-Post-Recruitment-2021-1.jpg"),
                            ),
                          ),
                          Container(
                            width: 190,
                            height: 100,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    matches[2].matchteams,
                                    style: kLabelTextStyleWhite,
                                  ),
                                  const Divider(
                                    height: 10,
                                    color: primaryColorLight,
                                  ),
                                  Text(
                                    matches[2].matchTime,
                                    style: const TextStyle(
                                      color: secondaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage("https://dshelpingforever.com/wp-content/uploads/2021/04/IIT-Jodhpur-Various-Post-Recruitment-2021-1.jpg"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: secondaryColor,
                    ),
                    child: const Text(
                      'View more',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );

  Future<List<Matches>> readJson() async {
    final jsonData =
        await rootBundle.rootBundle.loadString("jsonfile/matchdata.json");
    final list = json.decode(jsonData) as List<dynamic>;
    List<Matches> matchList = list.map((e) => Matches.fromJson(e)).toList();
    return matchList;
  }
}
