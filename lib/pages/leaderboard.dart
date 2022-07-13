import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/Users.dart';
import '../utilities/constants.dart';
import 'package:flutter/services.dart' as root_bundle;

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  Future<List<Users>> readJsonData() async {
    final jsonData = await root_bundle.rootBundle
        .loadString("jsonfile/leaderboard_list.json");

    final list = json.decode(jsonData) as List<dynamic>;

    List<Users> userList = list.map((e) => Users.fromJson(e)).toList();

    userList.sort((a, b) {
      return b.points.compareTo(a.points);
    });

    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: FutureBuilder<List<Users>>(
          future: readJsonData(),
          builder: (context, snapshot) {
            final users = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Some error occured"),
                  );
                } else {
                  return buildLeaderboard(users!);
                }
            }
          },
        ));
  }

  Widget buildLeaderboard(List<Users> users) => SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        // Rank Text
                        const Text(
                          "2",
                          style: kLabelTextStyleBlack,
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(users[1].imageUrl),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        // Points Text
                        Text(
                          users[1].points.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: kPointsTextStyleBlack,
                        ),
                        // Name Text
                        Text(
                          users[1].name,
                          overflow: TextOverflow.ellipsis,
                          style: kLabelTextStyleBlack,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Image(
                          image: AssetImage("images/crown.png"),
                          width: 30,
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(users[0].imageUrl),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        // Points Text
                        Text(
                          users[0].points.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: kPointsTextStyleBlack,
                        ),
                        // Name Text
                        Text(
                          users[0].name,
                          overflow: TextOverflow.ellipsis,
                          style: kLabelTextStyleBlack,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // Rank Text
                        const Text(
                          "3",
                          style: kLabelTextStyleBlack,
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(users[2].imageUrl),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        // Points Text
                        Text(
                          users[2].points.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: kPointsTextStyleBlack,
                        ),
                        // Name Text
                        Text(
                          users[2].name,
                          overflow: TextOverflow.ellipsis,
                          style: kLabelTextStyleBlack,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10.0,
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  itemCount: users.length - 3,
                  itemBuilder: (context, index) {
                    final userModel = users[index + 3];
                    return ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      tileColor: primaryColorLight,
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Rank Text
                          Text(
                            (index + 4).toString(),
                            overflow: TextOverflow.ellipsis,
                            style: kLabelTextStyleWhite,
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(userModel.imageUrl),
                          ),
                        ],
                      ),
                      // Name Text
                      title: Text(
                        userModel.name,
                        overflow: TextOverflow.ellipsis,
                        style: kLabelTextStyleWhite,
                      ),
                      subtitle: const Text(""),
                      // Points Text
                      trailing: Text(
                        userModel.points.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: kPointsTextStyleWhite,
                      ),
                    );
                  }),
            ],
          ),
        ),
      );
}
