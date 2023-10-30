import 'package:flutter/material.dart';
import 'package:stream_app/page_two.dart';
import 'package:stream_app/stream_controller.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initializeWidgetsUsingStreams();
  }

  Stream<List<Widget>> _initializeWidgetsUsingStreams() async* {
    await Future.delayed(const Duration(seconds: 2));
    List<Widget> widgets = [];

    for (var i = 0; i < 100; i++) {
      widgets.add(Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: InkWell(
          onTap: () {
            bids(i);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const PageTwo()));
          },
          child: Center(
            child: Text(
              i.toString(),
            ),
          ),
        ),
      ));
    }

    yield widgets;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<Widget>>(
            stream: _initializeWidgetsUsingStreams(),
            builder: (context, snapshot) {
              if (snapshot.data != null &&
                  snapshot.data!.isNotEmpty &&
                  snapshot.connectionState == ConnectionState.done) {
                return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                  ),
                  children: snapshot.data!,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
