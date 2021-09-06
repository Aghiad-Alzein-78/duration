part of dart.core;

class Duration implements Comparable<Duration> {
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

  /// An empty duration, representing zero time.
  static const Duration zero = Duration(seconds: 0);

  /// The total microseconds of this [Duration] object.
  final int _duration;

  /// Creates a new [Duration] object whose value
  /// is the sum of all individual parts.
  ///
  /// Individual parts can be larger than the number of those
  /// parts in the next larger unit.
  /// For example, [hours] can be greater than 23.
  /// If this happens, the value overflows into the next larger
  /// unit, so 26 [hours] is the same as 2 [hours] and
  /// one more [days].
  /// Likewise, values can be negative, in which case they
  /// underflow and subtract from the next larger unit.
  ///
  /// All arguments are 0 by default.
  const Duration(
      {int days = 0,
      int hours = 0,
      int minutes = 0,
      int seconds = 0,
      int milliseconds = 0,
      int microseconds = 0})
      : this._microseconds(microsecondsPerDay * days +
            microsecondsPerHour * hours +
            microsecondsPerMinute * minutes +
            microsecondsPerSecond * seconds +
            microsecondsPerMillisecond * milliseconds +
            microseconds);

  // Fast path internal direct constructor to avoids the optional arguments and
  // [_microseconds] recomputation.
  const Duration._microseconds(this._duration);

  /// Adds this Duration and [other] and
  /// returns the sum as a new Duration object.
  Duration operator +(Duration other) {
    return Duration._microseconds(_duration + other._duration);
  }

  /// Subtracts [other] from this Duration and
  /// returns the difference as a new Duration object.
  Duration operator -(Duration other) {
    return Duration._microseconds(_duration - other._duration);
  }

  /// Multiplies this Duration by the given [factor] and returns the result
  /// as a new Duration object.
  ///
  /// Note that when [factor] is a double, and the duration is greater than
  /// 53 bits, precision is lost because of double-precision arithmetic.
  Duration operator *(num factor) {
    return Duration._microseconds((_duration * factor).round());
  }

  /// Divides this Duration by the given [quotient] and returns the truncated
  /// result as a new Duration object.
  ///
  /// Throws an [IntegerDivisionByZeroException] if [quotient] is `0`.
  Duration operator ~/(int quotient) {
    // By doing the check here instead of relying on "~/" below we get the
    // exception even with dart2js.
    if (quotient == 0) throw IntegerDivisionByZeroException();
    return Duration._microseconds(_duration ~/ quotient);
  }

  /// Whether this [Duration] is shorter than [other].
  bool operator <(Duration other) => this._duration < other._duration;

  /// Whether this [Duration] is longer than [other].
  bool operator >(Duration other) => this._duration > other._duration;

  /// Whether this [Duration] is shorter than or equal to [other].
  bool operator <=(Duration other) => this._duration <= other._duration;

  /// Whether this [Duration] is longer than or equal to [other].
  bool operator >=(Duration other) => this._duration >= other._duration;

  /// The number of entire days spanned by this [Duration].
  int get inDays => _duration ~/ Duration.microsecondsPerDay;

  /// The number of entire hours spanned by this [Duration].
  ///
  /// The returned value can be greater than 23.
  /// For example a duration of four days and three hours
  /// has 99 entire hours.
  int get inHours => _duration ~/ Duration.microsecondsPerHour;

  /// The number of whole minutes spanned by this [Duration].
  ///
  /// The returned value can be greater than 59.
  /// For example a duration of three hours and 12 minutes
  /// has 192 minutes.
  int get inMinutes => _duration ~/ Duration.microsecondsPerMinute;

  /// The number of whole seconds spanned by this [Duration].
  ///
  /// The returned value can be greater than 59.
  /// For example a duration of three minutes and 12 seconds
  /// has 192 seconds.
  int get inSeconds => _duration ~/ Duration.microsecondsPerSecond;

  /// The number of whole milliseconds spanned by this [Duration].
  ///
  /// The returned value can be greater than 999.
  /// For example a duration of three seconds and 125 milliseconds
  /// has 3125 milliseconds.
  int get inMilliseconds => _duration ~/ Duration.microsecondsPerMillisecond;

  /// The number of whole microseconds spanned by this [Duration].
  ///
  /// The returned value can be greater than 999999.
  /// For example a duration of three seconds, 125 milliseconds and
  /// 369 microseconds has 3125369 microseconds.
  int get inMicroseconds => _duration;

  /// Whether this [Duration] has the same length as [other].
  ///
  /// Durations have the same length if they have the same number
  /// of microseconds, as reported by [inMicroseconds].
  bool operator ==(Object other) =>
      other is Duration && _duration == other.inMicroseconds;

  int get hashCode => _duration.hashCode;

  /// Compares this [Duration] to [other], returning zero if the values are equal.
  ///
  /// Returns a negative integer if this [Duration] is shorter than
  /// [other], or a positive integer if it is longer.
  ///
  /// A negative [Duration] is always considered shorter than a positive one.
  ///
  /// It is always the case that `duration1.compareTo(duration2) < 0` iff
  /// `(someDate + duration1).compareTo(someDate + duration2) < 0`.
  int compareTo(Duration other) => _duration.compareTo(other._duration);

  /// Returns a string representation of this [Duration].
  ///
  /// Returns a string with hours, minutes, seconds, and microseconds, in the
  /// following format: `H:MM:SS.mmmmmm`. For example,
  /// ```dart
  /// var d = Duration(days: 1, hours: 1, minutes: 33, microseconds: 500);
  /// d.toString();  // "25:33:00.000500"
  ///
  /// d = Duration(days: 0, hours: 1, minutes: 10, microseconds: 500);
  /// d.toString();  // "1:10:00.000500"
  /// ```
  String toString() {
    String sixDigits(int n) {
      if (n >= 100000) return "$n";
      if (n >= 10000) return "0$n";
      if (n >= 1000) return "00$n";
      if (n >= 100) return "000$n";
      if (n >= 10) return "0000$n";
      return "00000$n";
    }

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    if (inMicroseconds < 0) {
      return "-${-this}";
    }
    String twoDigitMinutes =
        twoDigits(inMinutes.remainder(minutesPerHour) as int);
    String twoDigitSeconds =
        twoDigits(inSeconds.remainder(secondsPerMinute) as int);
    String sixDigitUs =
        sixDigits(inMicroseconds.remainder(microsecondsPerSecond) as int);
    return "$inHours:$twoDigitMinutes:$twoDigitSeconds.$sixDigitUs";
  }

  /// Whether this [Duration] is negative.
  ///
  /// A negative [Duration] represents the difference from a later time to an
  /// earlier time.
  bool get isNegative => _duration < 0;

  /// Creates a new [Duration] representing the absolute length of this
  /// [Duration].
  ///
  /// The returned [Duration] has the same length as this one, but is always
  /// positive.
  Duration abs() => Duration._microseconds(_duration.abs());

  /// Creates a new [Duration] with the opposite direction of this [Duration].
  ///
  /// The returned [Duration] has the same length as this one, but will have the
  /// opposite sign (as reported by [isNegative]) as this one.
  // Using subtraction helps dart2js avoid negative zeros.
  Duration operator -() => Duration._microseconds(0 - _duration);
}

void main() {
  var period1 = Duration(days: 10);
  var period2 = Duration(days: 10);
  int dHours = (period1 + period2).inHours;
  int dMinutes = (period1 + period2).inMinutes;
  int dDays = (period1 + period2).inDays;
  Duration periodTester = Duration._microseconds(15000);
  print("Hours = ${periodTester.inMilliseconds}");
  print(dHours);
  print(dMinutes);
  print(dDays);
  print(period1 == period2);
  print(period1.hashCode);
  print(period2.hashCode);
  // print(period1.days);
}
