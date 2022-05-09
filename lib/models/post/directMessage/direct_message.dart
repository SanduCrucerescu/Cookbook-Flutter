import 'package:quiver/iterables.dart';

class DirectMessage implements Comparable {
  String? sender;
  String? receiver;
  String? content;
  String? time;
  String? date;

  DirectMessage({
    this.sender,
    this.receiver,
    this.content,
    this.time,
    this.date,
  });

  @override
  int compareTo(other) {
    if (time != null && other.time == null) {
      return -1;
    }

    if (time == null && other.time != null) {
      return 1;
    }

    if (time == null && other.time == null) {
      return 0;
    }

    final thisDateTime = [
      ...date!.split(' ')[0].split('-').map((e) => int.parse(e)).toList(),
      ...time!.split(':').map((e) => int.parse(e)).toList()
    ];

    final otherDateTime = [
      ...other.date!.split(' ')[0].split('-').map((e) => int.parse(e)),
      ...other.time!.split(':').map((e) => int.parse(e))
    ];

    bool equal = false;
    for (var pair in zip([thisDateTime, otherDateTime])) {
      if (pair[0] == pair[1]) {
        equal = true;
      } else {
        equal = false;
      }

      if (pair[0] < pair[1]) {
        return 0;
      }
    }

    return equal == true ? 0 : -1;
  }

  @override
  String toString() {
    return 'DirectMessage(sender: $sender, receiver: $receiver, content: $content, time: $time, date: $date)';
  }
}
