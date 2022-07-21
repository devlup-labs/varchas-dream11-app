import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utilities/constants.dart';

class MatchCard extends StatefulWidget {
  const MatchCard(
      {Key? key,
      required this.sport,
      required this.college1,
      required this.college2,
      required this.date,
      required this.time})
      : super(key: key);

  final String sport;
  final String college1;
  final String college2;
  final String date;
  final String time;

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  bool sendReminder = false;
  Duration duration = const Duration();
  Timer? timer;
  bool isLive = false;

  bool calculateMatchTime(String time) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);

    String currentTime = date.toString().substring(11, 16);
    String matchTime = time.substring(0, 5);

    var format = DateFormat("HH:mm");
    var current = format.parse(currentTime);
    var match = format.parse(matchTime);

    if (current.isAfter(match)) {
      return false;
    } else if (current.isBefore(match)) {
      List<String> list = match.difference(current).toString().split(":");
      int hours = int.parse(list[0]);
      int minutes = int.parse(list[1]);
      duration = Duration(hours: hours, minutes: minutes);

      return true;
    } else {
      return false;
    }
  }

  changeTime() {
    setState(() {
      duration = Duration(minutes: duration.inMinutes - 1);
    });
  }

  @override
  void initState() {
    if (calculateMatchTime(widget.time)) {
      timer = Timer.periodic(const Duration(minutes: 1), (_) => changeTime());
    } else {
      isLive = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          decoration: const BoxDecoration(
            color: primaryColorLight,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Matches",
                      style: kLabelTextStyleWhite.copyWith(fontSize: 13.0),
                    ),
                    buildMatchStatus(),
                  ],
                ),
                const Divider(
                  thickness: 1.0,
                  height: 5.0,
                  color: primaryColorLighter,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 60.0,
                            child: Image(
                                image: AssetImage(
                                    "images/college_logos/iitj_logo.png")),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            widget.college1,
                            textAlign: TextAlign.start,
                            style:
                                kLabelTextStyleWhite.copyWith(fontSize: 13.0),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF707070),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Text("VS",
                            style:
                                kLabelTextStyleWhite.copyWith(fontSize: 14.0)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 60.0,
                            child: Image(
                                image: AssetImage(
                                    "images/college_logos/mbm_logo.png")),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            widget.college2,
                            textAlign: TextAlign.end,
                            style:
                                kLabelTextStyleWhite.copyWith(fontSize: 13.0),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget buildTimeText() {
    if (duration.inMinutes == 0 && duration.inHours == 0) {
      timer?.cancel();
      setState(() {
        isLive = true;
      });
      timer?.cancel();
      return Text(
        "Live",
        style: kLabelTextStyleWhite.copyWith(
            fontSize: 13.0, color: secondaryColor),
      );
    }

    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    return Text(
      "${hours}h ${minutes}m",
      style:
          kLabelTextStyleWhite.copyWith(fontSize: 13.0, color: secondaryColor),
    );
  }

  Widget buildMatchStatus() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildTimeText(),
        const SizedBox(
          width: 8.0,
        ),
        isLive
            ? const CircleAvatar(
                radius: 3,
                backgroundColor: secondaryColor,
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    sendReminder = true;
                  });
                },
                child: Image(
                  width: 20.0,
                  image: sendReminder
                      ? const AssetImage("images/reminder_active.png")
                      : const AssetImage("images/reminder.png"),
                ))
      ],
    );
  }
}
