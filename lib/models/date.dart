import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formattedDate(Timestamp timeStamp) {
  var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  return DateFormat('yyyy-MM-dd kk:mm:ss').format(dateFromTimeStamp);
}

String printDuration(Duration duration) {
  String twoDigits(int n, String m) => n.toString().padRight((n < 10 ? 2 : 3), m);
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60), 'm');
  String twoDigitSeconds = duration.inSeconds % 60 != 0 ? twoDigits(duration.inSeconds.remainder(60), 's') : '';
  return duration.inHours != 0
      ? "${twoDigits(duration.inHours, 'h')} $twoDigitMinutes $twoDigitSeconds"
      : duration.inMinutes != 0
          ? "$twoDigitMinutes $twoDigitSeconds"
          : twoDigitSeconds;
}
