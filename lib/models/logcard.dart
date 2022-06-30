import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weloggerweb/globalvalues/globalvalues.dart';
import 'package:weloggerweb/models/date.dart';
import 'package:weloggerweb/products/products.dart';

class LogCard extends StatefulWidget {
  final String number;
  const LogCard({Key? key, required this.number}) : super(key: key);

  @override
  State<LogCard> createState() => _LogCardState();
}

class _LogCardState extends State<LogCard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Obx(() => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('webcontacts').doc(widget.number).collection('logs').where('start',isGreaterThanOrEqualTo: controller.startDate.value, isLessThanOrEqualTo: controller.endDate.value).orderBy('start', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return Column(
                children: snapshot.data!.docs.map((document) {
                
                final DateTime now = DateTime.now();
                final DateTime start;
                final DateTime end;
                Duration diff;
                bool isOnline = document['end'] == null ? true : false;

                start = DateTime.parse(formattedDate(document['start'])).subtract(const Duration(hours: 3));
                end = isOnline
                  ? DateTime.parse(formattedDate(document['start'])).subtract(const Duration(hours: 3))
                  : DateTime.parse(formattedDate(document['end'])).subtract(const Duration(hours: 3));
                diff = isOnline ? now.difference(start) : end.difference(start);

                return Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(Values.contactCardRadius / 2), 
            border: Border.all(color: isOnline ? Colors.green : Colors.grey, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _startDate(start),
                      _space(),
                      _startHour(start),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _textDuration(),
                    _space(),
                    _duration(isOnline, start, diff),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _endDate(isOnline, end),
                      _space(),
                      _endHour(isOnline, end),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
              }).toList());
            } else {
              return Space.emptySpace;
            }
          } else {
            return Space.emptySpace;
          }
        }));
  }
  SizedBox _space() => const SizedBox(height: 2,);

  Container _startHour(DateTime start) {
    return Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                DateFormat.Hms().format(start),
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ));
  }

  Container _startDate(DateTime start) {
    return Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                DateFormat().add_MMMd().format(start),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 16),
                              ));
  }

  Container _duration(bool isOnline, DateTime start, Duration diff) {
    return Container(
                            child: isOnline
                                ? _sayac(start)
                                : Text(printDuration(diff), style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),));
  }

  Text _textDuration() {
    return Text(
                          'duration',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 16),
                        );
  }

  Container _endHour(bool isOnline, DateTime end) {
    return Container(
                              alignment: Alignment.centerRight,
                              child: isOnline
                                  ? null
                                  : Text(
                                      DateFormat.Hms().format(end),
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ));
  }

  Container _endDate(bool isOnline, DateTime end) {
    return Container(
                            child: isOnline
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                      margin:
                                      const EdgeInsets.only(right: 5),
                                          width: 5,
                                          height: 5,
                                          child: const CircleAvatar(
                                          backgroundColor: Colors.green)),
                                          const Text('online',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  )
                                : Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      DateFormat().add_MMMd().format(end),
                                      style: TextStyle(color:Colors.white.withOpacity(0.7),fontSize: 16),
                                    )),
                          );
  }

  StreamBuilder<dynamic> _sayac(DateTime start) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),builder: (context, snapshot) {
        DateTime nowDate = DateTime.parse(formattedDate(Timestamp.fromDate(DateTime.now())));
        final sayac = Duration(seconds: nowDate.difference(start).inSeconds);
        return Center(child: Text(printDuration(sayac),style: TextStyle(
          fontSize: 16,color: Colors.white.withOpacity(0.8)),
          ),
        );
      },
    );
  }
}
