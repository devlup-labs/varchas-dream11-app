import 'package:varchas_dream_11/utilities/constants.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter/material.dart';

Widget matchDisplay(int a,dynamic matches,BuildContext context) => Container (
  margin:const EdgeInsets.fromLTRB(0, 5, 0, 5),
  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
  width: 380,
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    color: primaryColorLight,
  ),
  child: Wrap(
    children: [
      Container(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 3),
        width: 380,
        child: Center(child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child:Text(
                matches[a].matchDate,
                style: const TextStyle(
                    color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
              child:SizedBox(
                child: Center(
                  child: sportsname(matches[a].sport),
                ),
                width: MediaQuery.of(context).size.width*0.55,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child:Text(
                matches[a].matchTime,
                style: const TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ],
        ),),
      ),
      const Divider(
        indent: 10,
        endIndent: 10,
        color: Colors.white,
        thickness: 1,
      ),
      Center(
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Column(
                children: [
                  teamlogo(matches[a].team1Logo,matches[a].team1),
                  Text(
                    matches[a].team1,
                    style: kTeamNameTextStyleWhite,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.38,
              height: 100,
              child: Center(
                child: Column(
                  children: const [
                    Text(
                      "    V/S",
                      style: kTeamNameTextStyleWhite,
                    )
                  ],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 25),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Column(
                children: [
                  teamlogo(matches[a].team2Logo,matches[a].team2),
                  Text(
                    matches[a].team2,
                    style: kTeamNameTextStyleWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      resultDisplay(matches[a].matchWinner,matches[a].pointsEarned,matches[a].scoreDifference,matches[a].sport,matches[a].team1,matches[a].team2),
    ],
  ),
);
Widget resultDisplay(String winner,String points,String scoreDifference,String sport,String team1, String team2) {
  if (winner!=""){
    return Column(
      children: [
        const Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.white,
          thickness: 1,
        ),
        winningStatement(winner,scoreDifference,sport,team1,team2),
        const Divider(
          height: 5,
          color: primaryColorLight,
        ),
        Text(
          "Points Received = "+points,
          style: const TextStyle(
              fontSize: 15,
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
Widget teamlogo(String name,String teamname) {
  if (name==""){
    return ProfilePicture(
      name: teamname, radius: 40, fontsize: 40,
    );
  }
  return CircleAvatar(
    radius: 40,
    backgroundImage: NetworkImage(name),
  );
}
Widget winningStatement(String winner,String scoreDifference,String sport,String team1,String team2){
  if (sport=="cricket" || sport=="basketball"){
    return Text(
      winner + " won by " + scoreDifference,
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),
    );
  }
  else if (sport=="football"){
    return Text(
      team1 + "     " + scoreDifference + "     " + team2,
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),
    );
  }
  return Container();
}

Widget sportsname(String sport) {
  if (sport == "cricket"){
    return const Text(
      "Cricket",
      style: TextStyle(
          color: secondaryColorLight,
          fontSize: 19.0,
          fontWeight: FontWeight.w800
      ),
    );
  }
  else if (sport =="football"){
    return const Text(
      "Football",
      style: TextStyle(
          color: secondaryColorLight,
          fontSize: 19.0,
          fontWeight: FontWeight.w800
      ),
    );
  }
  else if (sport == "basketball"){
    return const Text(
      "Basketball",
      style: TextStyle(
          color: secondaryColorLight,
          fontSize: 19.0,
          fontWeight: FontWeight.w800
      ),
    );
  }
  return Container();
}
