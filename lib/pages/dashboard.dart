import 'dart:convert';
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
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffe1e2e1),
          ),
          child: Column(
            children: [
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
                  }),
              Container(
                width: 380,
                height: 58,
                padding: const EdgeInsets.fromLTRB(15, 15, 5, 20),
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: const Color(0xfff5f5f6),
                ),
                child: const Text(
                  'Total Points:',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FutureBuilder<List<Matches>>(
                  future: read_Json(),
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
                          return buildMatchRList(matches);
                        }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMatchList(matches) => Container(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        alignment: Alignment.topCenter,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: const Color(0xfff5f5f6),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: 380,
            height: 345,
            alignment: Alignment.center,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(5, 15, 5, 25),
                  child: Center(
                    child: Text(
                      'My Matches',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 360,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                    width: 340,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      matches[0].matchteams,
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 360,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                    width: 340,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      matches[1].matchteams,
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 360,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                    width: 340,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      matches[2].matchteams,
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 360,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                    width: 340,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      matches[3].matchteams,
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffef6c00),
                    ),
                    child: const Text(
                      'View more',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
  Widget buildMatchRList(matches) => Container(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 15),
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black),
            color: const Color(0xfff5f5f6),
          ),
          width: 380,
          height: 345,
          alignment: Alignment.center,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 25),
                child: Center(
                  child: Text(
                    'Previous Results',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                width: 360,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                  width: 340,
                  child: Text(
                    matches[0].matchresults,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                width: 360,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                  width: 340,
                  child: Text(
                    matches[1].matchresults,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                  width: 340,
                  child: Text(
                    matches[2].matchresults,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                  width: 340,
                  child: Text(
                    matches[3].matchresults,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xffef6c00),
                  ),
                  child: const Text(
                    'View more',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Future<List<Matches>> readJson() async {
    final jsonData =
        await rootBundle.rootBundle.loadString("jsonfile/matchdata.json");
    final list = json.decode(jsonData) as List<dynamic>;
    List<Matches> matchList = list.map((e) => Matches.fromJson(e)).toList();
    return matchList;
  }

  Future<List<Matches>> read_Json() async {
    final jsonData =
        await rootBundle.rootBundle.loadString("jsonfile/matchdata.json");
    final list = json.decode(jsonData) as List<dynamic>;
    List<Matches> matchList = list.map((e) => Matches.fromJson(e)).toList();
    return matchList;
  }
}
