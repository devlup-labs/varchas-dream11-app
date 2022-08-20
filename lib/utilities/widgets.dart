import 'package:varchas_dream_11/utilities/constants.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter/material.dart';

Widget matchDisplay(int a,dynamic matches,BuildContext context) => Container (
    margin:const EdgeInsets.fromLTRB(0, 6, 0, 5),
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
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child:Text(
                  matches[a].date,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child:SizedBox(
                  child: Center(
                    child: sportsname(matches[a].event),
                  ),
                  width: MediaQuery.of(context).size.width*0.55,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child:Text(
                  matches[a].time,
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
                    Container(
                      width: 90,
                      child: Text(
                      matches[a].team1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: kTeamNameTextStyleWhite,
                        textAlign: TextAlign.center,
                    ),
                    )
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
                        "V/S",
                        style: kTeamNameTextStyleWhite,
                        textAlign: TextAlign.center,
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
                    Container(
                      width: 90,
                      child: Text(
                      matches[a].team2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kTeamNameTextStyleWhite,
                        textAlign: TextAlign.center,
                    ),)
                  ],
                ),
              ),
            ],
          ),
        ),
        resultDisplay(matches[a].matchWinner,matches[a].pointsEarned,matches[a].scoreDifference,matches[a].event,matches[a].team1,matches[a].team2),
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
Widget teamlogo(String name,String teamName) {
  if (name==""){
    return ProfilePicture(
      name: teamName, radius: 40, fontsize: 40,
    );
  }
  return CircleAvatar(
    radius: 40,
    backgroundImage: NetworkImage(name),
  );
}
Widget winningStatement(String winner,String scoreDifference,String sport,String team1,String team2){
  if (sport=="Cricket" || sport=="Basketball"){
    return Text(
      winner + " won by " + scoreDifference,
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),
    );
  }
  else if (sport=="Football"){
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
  return Text(
    sport,
    style: const TextStyle(
        color: secondaryColorLight,
        fontSize: 19.0,
        fontWeight: FontWeight.w800
    ),
  );
}
