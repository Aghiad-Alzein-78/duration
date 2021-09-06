class MyDuration {
  static const int microsecondsPerMillisecond = 1000;
  static const int millisecondsPerSecond = 1000;
  static const int secondsPerMinute = 60;
  static const int minutesPerHour = 60;
  static const int hoursPerDay = 24;
  static const int microsecondsPerSecond =
      microsecondsPerMillisecond * millisecondsPerSecond;
  static const int microsecondsPerMinute =
      microsecondsPerSecond * secondsPerMinute;
  static const int microsecondsPerHour = microsecondsPerMinute * minutesPerHour;
  static const int microsecondsPerDay = microsecondsPerHour * hoursPerDay;
  static const int millisecondsPerMinute =
      millisecondsPerSecond * secondsPerMinute;
  static const int millisecondsPerHour = millisecondsPerMinute * minutesPerHour;
  static const int millisecondsPerDay = millisecondsPerHour * hoursPerDay;
  static const int secondsPerHour = secondsPerMinute * minutesPerHour;
  static const int secondsPerDay = secondsPerHour * hoursPerDay;
  static const int minutesPerDay = minutesPerHour * hoursPerDay;
  final int _duration;
  const MyDuration.microSeconds(this._duration);
  const MyDuration(
      {int days: 0,
      int hours: 0,
      int minutes: 0,
      int seconds: 0,
      int millisconds: 0,
      int microsconds: 0})
      : this.microSeconds(microsecondsPerDay * days +
            microsecondsPerHour * hours +
            microsecondsPerMinute * minutes +
            microsecondsPerSecond * seconds +
            microsecondsPerMillisecond * millisconds +
            microsconds);

  MyDuration operator +(MyDuration other) {
    return MyDuration.microSeconds(this._duration + other._duration);
  }

  MyDuration operator -(MyDuration other) {
    return MyDuration.microSeconds(this._duration - other._duration);
  }

  // MyDuration operator *(MyDuration other) {
  //   return MyDuration.microSeconds(this._duration * other._duration);
  // }

  // MyDuration operator ~/(MyDuration other) {
  //   return MyDuration.microSeconds(this._duration ~/ other._duration);
  // }

  bool operator >(MyDuration other) {
    return this._duration > other._duration;
  }

  bool operator ==(Object other) {
    return other is MyDuration && this._duration == other._duration;
  }

  bool operator >=(MyDuration other) {
    return this._duration >= other._duration;
  }

  bool operator <(MyDuration other) {
    return this._duration < other._duration;
  }

  bool operator <=(MyDuration other) {
    return this._duration <= other._duration;
  }

  int get hashCode => this._duration.hashCode;

  int get inMicroseconds => _duration;
  int get inMilliseconds => _duration ~/ microsecondsPerMillisecond;
  int get inSeconds => _duration ~/ microsecondsPerSecond;
  int get inHours => _duration ~/ microsecondsPerHour;
  int get inMinutes => _duration ~/ microsecondsPerMinute;
  int get inDays => _duration ~/ microsecondsPerDay;
}
