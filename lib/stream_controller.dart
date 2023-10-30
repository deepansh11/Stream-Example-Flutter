import 'dart:async';

StreamController<int> controller = StreamController();

Stream<int> bids(int i) {
  controller = StreamController<int>(
    onListen: () async {
      await Future<void>.delayed(const Duration(seconds: 2));
      controller.add(i);
      await Future<void>.delayed(const Duration(seconds: 2));
      await controller.close();
    },
  );
  return controller.stream;
}
