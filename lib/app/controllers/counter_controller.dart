import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/counter_provider.dart';

class CounterController {
  final WidgetRef ref;
  CounterController(this.ref);

  void increment() => ref.read(counterProvider.notifier).state++;
  void decrement() => ref.read(counterProvider.notifier).state--;
  void reset() => ref.read(counterProvider.notifier).state = 0;
}
