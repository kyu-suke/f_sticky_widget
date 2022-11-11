import 'package:f_sticky_widget/f_sticky_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController? _scrollController;
  StickyController controller = StickyController();

  @override
  void initState() {
    super.initState();
  }

  Widget demoWidget() {
    return Container(
        width: 80,
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text("hoge"),
            SizedBox(width: 5),
            Text("fuga"),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          controller.notify();
          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Container(
              width: 1000,
              color: Colors.grey,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                            height: 1500, width: 1500, color: Colors.yellow),
                        Container(height: 500, width: 1500, color: Colors.blue),
                        Container(
                            height: 1500, width: 1500, color: Colors.green),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                            height: 500, width: 1500, color: Colors.green),
                        Container(
                          height: 500,
                          width: 1500,
                          color: Colors.purple,
                          child: FStickyWidget(
                              color: Colors.red,
                              track: true,
                              controller: controller,
                              widgetLocation: WidgetLocation.centerMiddle,
                              // widgetOffset: WidgetOffset(),
                              child: demoWidget()
                          ),
                        ),
                        Container(height: 500, width: 1500, color: Colors.red),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                            height: 1500, width: 1500, color: Colors.orange),
                        Container(
                            height: 1500, width: 1500, color: Colors.black87),
                        Container(
                            height: 1500, width: 1500, color: Colors.tealAccent),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}