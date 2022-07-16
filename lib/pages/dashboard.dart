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
                matchDisplay(0,matches),
                matchDisplay(1,matches),
                matchDisplay(2,matches),
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

  Widget matchDisplay(int a,dynamic matches) => Container (
    margin:const EdgeInsets.fromLTRB(0, 5, 0, 5),
    width: 380,
    height: heightJudge(matches[a].matchResults),
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
                Text(
                  matches[a].matchDate,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
                Container(
                  width: 240,
                ),
                Text(
                  matches[a].matchTime,
                  style: const TextStyle(
                      color: Colors.white
                  ),),
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
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(matches[a].team1Logo),
                  ),
                  Text(
                    matches[a].team1,
                    style: kTeamNameTextStyleWhite,
                  ),
                ],
              ),
            ),
            Container(
              width: 190,
              height: 100,
              child: Center(
                child: Column(
                  children: const [
                    Divider(
                      height: 10,
                      color: primaryColorLight,
                    ),
                    Text(
                      "V/S",
                      style: kTeamNameTextStyleWhite,
                    )
                  ],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(matches[a].team2Logo),
                  ),
                  Text(
                    matches[a].team2,
                    style: kTeamNameTextStyleWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
        resultDisplay(matches[a].matchResults,matches[a].pointsEarned),
      ],
    ),
  );

  double heightJudge(String result){
    if (result==""){
      return 160;
    }
    else{
      return 218;
    }
  }
  Widget resultDisplay(String result,String points) {
    if (result!=""){
      return Column(
        children: [
          const Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.white,
            thickness: 1,
          ),
          Text(
                result,
            style: const TextStyle(
                color: Colors.white
            ),
              ),
          const Divider(
            height: 5,
            color: primaryColorLight,
          ),
          Text(
                "Points Received =   "+points,
              style: const TextStyle(
                  color: Colors.white
              ),
          )
        ],
      );
    }
    else {
      return Container();
    }
  }

  Future<List<Matches>> readJson() async {
    final jsonData =
    await rootBundle.rootBundle.loadString("jsonfile/matchdata.json");
    final list = json.decode(jsonData) as List<dynamic>;
    List<Matches> matchList = list.map((e) => Matches.fromJson(e)).toList();
    return matchList;
  }
}
