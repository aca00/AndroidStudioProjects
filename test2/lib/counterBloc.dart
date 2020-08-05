import 'package:bloc/bloc.dart';

enum CounterEvents { increment, decrement }
// the second argument in Bloc<> is actually state. in  this case it is integer.
// but it can be class as well
class CounterBloc extends Bloc<CounterEvents, int> {
  CounterBloc() : super(0); //initial state. This replces get initialState() in tutorial videos

  @override
  Stream<int> mapEventToState(CounterEvents event) async* {
    switch (event) {
      case CounterEvents.increment:
        yield state + 1;
        break;
      case CounterEvents.decrement:
        yield state - 1;
        break;
    }
  }
}
