import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../models/match.dart';
import '../components/match_card.dart';

class LiveMatches extends StatefulWidget {
  const LiveMatches({Key? key}) : super(key: key);

  @override
  State<LiveMatches> createState() => _LiveMatchesState();
}

String selectedSport = 'cricket';

class _LiveMatchesState extends State<LiveMatches> {
  Map<String, List<String>> teamIdDecode = {};

  void decodeTeamIds() async {
    var url = Uri.parse("https://varchas22.in/registration/teamsApi/");

    var response = await http.get(url);

    Map jsonData = jsonDecode(response.body) as Map<String, dynamic>;

    for (var team in jsonData["results"]) {
      if (team["sport"] != "10") {
        teamIdDecode[team["teamId"]] = [
          team["college"],
          sportChoices[team["sport"]] ?? "invalid",
        ];
      }
    }

    if (jsonData["next"] != null) {
      while (jsonData["next"] != null) {
        var url = Uri.parse(jsonData["next"]);

        var response = await http.get(url);

        jsonData = jsonDecode(response.body);

        for (var team in jsonData["results"]) {
          if (team["sport"] != "10") {
            teamIdDecode[team["teamId"]] = [
              team["college"],
              sportChoices[team["sport"]] ?? "invalid",
            ];
          }
        }
      }
      for (var team in jsonData["results"]) {
        if (team["sport"] != "10") {
          teamIdDecode[team["teamId"]] = [
            team["college"],
            sportChoices[team["sport"]] ?? "invalid",
          ];
        }
      }
    }
  }

  @override
  void initState() {
    decodeTeamIds();
    super.initState();
  }

  void changeSport(String sport) {
    setState(() {
      selectedSport = sport;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: 9,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SportIconButton(
                        sport: sportChoices.values.toList()[index],
                        onPressed: () {
                          setState(() {
                            selectedSport = sportChoices.values.toList()[index];
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Upcoming Matches",
                    style: kMediumTextStyleOrange,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                FutureBuilder<List<Match>>(
                  future: readJsonData(),
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
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Match>> readJsonData() async {
    var url = Uri.parse("https://varchas22.in/events/MatchApi/");

    var response = await http.get(url);

    Map jsonData = jsonDecode(response.body) as Map<String, dynamic>;

    List<Match> matches = [];

    for (var m in jsonData["results"]) {
      Match match = Match(
          sport: teamIdDecode[m["team1"]]?[1] ?? "",
          team1: teamIdDecode[m["team1"]]?[0] ?? "",
          team2: teamIdDecode[m["team2"]]?[0] ?? "",
          date: m["date"],
          startTime: m["time"]);

      matches.add(match);
    }

    matches =
        matches.where((element) => element.sport == selectedSport).toList();

    return matches;

    /*
    Code for checking if the match is or current date and has not ended yet
     */

    // DateTime now = DateTime.now();
    // DateTime date = DateTime(
    //     now.year, now.month, now.day, now.hour, now.minute, now.second);
    //
    // matchList = matchList
    //     .where((element) => element.date == date.toString().substring(0, 10))
    //     .toList();
    //
    // matchList = matchList.where((element) {
    //   String currentTime = date.toString().substring(11, 16);
    //   String matchEndTime = element.endTime.substring(0, 5);
    //
    //   var format = DateFormat("HH:mm");
    //   var current = format.parse(currentTime);
    //   var matchEnd = format.parse(matchEndTime);
    //
    //   if (current.isAfter(matchEnd)) {
    //     return false;
    //   } else {
    //     return true;
    //   }
    // }).toList();
  }

  Widget buildMatchList(List<Match> matches) {
    return ListView.separated(
      itemCount: matches.length,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return MatchCard(
          sport: matches[index].sport,
          college1: matches[index].team1,
          college2: matches[index].team2,
          date: matches[index].date,
          time: matches[index].startTime,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 12.0,
        );
      },
    );
  }
}

class SportIconButton extends StatelessWidget {
  const SportIconButton({
    Key? key,
    required this.sport,
    required this.onPressed,
  }) : super(key: key);

  final String sport;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RawMaterialButton(
            onPressed: onPressed,
            constraints: const BoxConstraints.tightFor(
              width: 80,
            ),
            elevation: 2.0,
            fillColor:
                selectedSport == sport ? secondaryColor : primaryColorLighter,
            child: Image(
              image: AssetImage("images/sports_logos/$sport.png"),
            ),
            padding: const EdgeInsets.all(18.0),
            shape: const CircleBorder(),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          sport,
          style: kLabelTextStyleWhite.copyWith(
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
