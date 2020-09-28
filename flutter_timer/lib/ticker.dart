// The ticker will be our data source for the timer application.
// It will expose a stream of ticks which we can subscribe and react to.
// All our Ticker class does is expose a tick function which takes the number of
// ticks (seconds) we want and returns a stream which emits the remaining
// seconds every second.
class Ticker {
  Stream<int> tick({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (int x) => ticks - x - 1)
        .take(ticks);
  }
}
// take function takes that  number of data from stream. 