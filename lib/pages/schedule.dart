import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:varchas_dream_11/utilities/widgets.dart';
import 'package:varchas_dream_11/utilities/constants.dart';
import 'package:http/http.dart' as http;

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);
  @override
  State<Schedule> createState() => _MyAppState();
}

class _MyAppState extends State<Schedule> {
  final sportsChoices = {
    '1': 'Athletics',
    '2': 'Badminton',
    '3': 'Basketball',
    '4': 'Chess',
    '5': 'Cricket',
    '6': 'Football',
    '7': 'Table Tennis',
    '8': 'Tennis',
    '9': 'Volleyball',
    '10': 'Badminton-Mixed doubles',
  };
  final dates = ["2022-04-07", "2022-04-08", "2022-04-09"];
  Future getMatchData(int a) async {
    var response1 = await http.get(Uri.parse("https://varchas22.in/events/MatchApi/"));
    var response2 = await http.get(Uri.parse("https://varchas22.in/registration/teamsApi/"));
    if (response1.statusCode != 200){
      throw Exception('Failed to load data');
    }
    if (response2.statusCode != 200){
      throw Exception('Failed to load data');
    }
    Map jsonData1 = jsonDecode(response1.body) as Map<String,dynamic>;
    Map jsonData2 = jsonDecode(response2.body) as Map<String,dynamic>;
    List<Teams> teamNames = [];
    List<SchMatches> schMatchList1 = [];
    List<SchMatches> schMatchList2 = [];
    List<SchMatches> schMatchList3 = [];
    for (var v in jsonData2["results"]){
      Teams teamDetails = Teams(
          // v is taking individual team details
          v["url"],v["teamId"],v["college"],v["sport"],v["score"]
      );
      teamNames.add(teamDetails);
    }
    if (jsonData2["next"]!=null){
      while(jsonData2["next"]!=null){
        var url = Uri.parse(jsonData2["next"]);
        var response = await http.get(url);
        jsonData2 = jsonDecode(response.body);
        for (var v in jsonData2["results"]){
          // v is taking individual team details
          Teams teamDetails = Teams(
              v["url"],v["teamId"],v["college"],v["sport"],v["score"]
          );
          teamNames.add(teamDetails);
        }
      }
    }
    // dictionary object to keep the name and College Id
    var teamDict = {};
    for (var v in teamNames){
      teamDict[v.teamId]=v.college;
    }
    for (var u in jsonData1["results"]) {
      SchMatches schMatch = SchMatches(
          // u contains the details of a particular match
          sportsChoices[u["event"]], teamDict[u["team1"]],teamDict[u["team2"]], u["date"], u["time"],u["team1Logo"]="",u["team2Logo"]="",u["matchWinner"]="",u["pointsEarned"]="",u["scoreDifference"]=""
      );
      // sorting of matches in accordance with dates
      if (schMatch.date==dates[0]){
        schMatchList1.add(schMatch);
      }
      else if (schMatch.date==dates[1]){
        schMatchList2.add(schMatch);
      }
      else {
        schMatchList3.add(schMatch);
      }
    }
    for (var i=0 ; i<schMatchList1.length;i++){
      schMatchList1[i].date = schMatchList1[i].date?.substring(2);
      schMatchList1[i].time = schMatchList1[i].time?.substring(0,5);
    }
    for (var i=0 ; i<schMatchList2.length;i++){
      schMatchList2[i].date = schMatchList2[i].date?.substring(2);
      schMatchList2[i].time = schMatchList2[i].time?.substring(0,5);
    }
    for (var i=0 ; i<schMatchList3.length;i++){
      schMatchList3[i].date = schMatchList3[i].date?.substring(2);
      schMatchList3[i].time = schMatchList3[i].time?.substring(0,5);
    }
    if (a==1) {
      return schMatchList1;
    } else if (a==2) {
      return schMatchList2;
    } else {
      return schMatchList3;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                decoration: const BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))
                ),
                child: const TabBar(
                  tabs: [
                    Tab(child: Text("Day-1")),
                    Tab(child: Text("Day-2")),
                    Tab(child: Text("Day-3")),
                  ],
                ),
                height: 53,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                    children: [
                      FutureBuilder<dynamic>(
                          future: getMatchData(1),
                          builder: (context, snapshot){
                            if (snapshot.data == null){
                              return const Center(
                                child : CircularProgressIndicator(),
                              );
                            } else {
                              return matchesOfDay(snapshot.data,context);
                            }
                          }),
                      FutureBuilder<dynamic>(
                          future: getMatchData(2),
                          builder: (context, snapshot){
                            if (snapshot.data == null){
                              return const Center(
                                child : CircularProgressIndicator(),
                              );
                            } else {
                              return matchesOfDay(snapshot.data,context);
                            }
                          }),
                      FutureBuilder<dynamic>(
                      future: getMatchData(3),
                      builder: (context, snapshot){
                        if (snapshot.data == null){
                          return const Center(
                            child : CircularProgressIndicator(),
                          );
                        } else {
                          return matchesOfDay(snapshot.data,context);
                        }
                    }),
                    ]
                ),
              )
            ],
          ),

          backgroundColor: primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

Widget matchesOfDay(List matchList,BuildContext context){
  return SingleChildScrollView(child: Column(
    children: [
      Container(
        height: 10,
      ),
      for (var i=0; i<matchList.length;i++)
        matchDisplay(i, matchList, context),
      Container(
        height: 205,
      )
    ],
  ),
    );
}

class SchMatches {
  String? event,team1,team2,date,time,team1Logo,team2Logo,matchWinner,pointsEarned,scoreDifference;
  SchMatches(this.event, this.team1, this.team2, this.date, this.time,this.team1Logo,this.team2Logo,this.matchWinner,this.pointsEarned,this.scoreDifference);
}

class Teams{
  String? teamId,college,url,sport;
  int score;
  Teams(this.url, this.teamId, this.college, this.sport, this.score);
}
