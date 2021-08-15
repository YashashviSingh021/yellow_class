import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:todo/screens/todo_list_screen.dart';

/// this class uses this library flutter_overboard
/// the link to it is https://pub.dev/packages/flutter_overboard#-installing-tab-

class IntroOverboardPage extends StatefulWidget {
  static const routeName = '/IntroOverboardPage';


  @override
  _IntroOverboardPageState createState() => _IntroOverboardPageState();
}

class _IntroOverboardPageState extends State<IntroOverboardPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// -----------------------------------------------
    /// Build main content with Scaffold widget.
    /// -----------------------------------------------
    return Scaffold(
      key: _globalKey,

      /// -----------------------------------------------
      /// Build Into with OverBoard widget.
      /// -----------------------------------------------
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          // Navigator.of(context).pushNamed(TodoListScreeen.routeName);
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TodoListScreeen()),
  );
        },
        finishCallback: () {
          // Navigator.of(context).pushNamed(TodoListScreeen.routeName);
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TodoListScreeen()),
  );
        },
      ),
    );
  }

  /// -----------------------------------------------
  /// making list of PageModel needed to pass in OverBoard constructor.
  /// -----------------------------------------------
  final pages = [
    PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'assets/1.png',
        title: 'Netflix movies',
        body: '',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/2.jpg',
        title: 'Amazon Prime movies',
        body: '',
        doAnimateImage: true),
    // PageModel(
    //     color: const Color(0xFF9B90BC),
    //     imageAssetPath: 'assets/images/03.png',
    //     title: 'Screen 3',
    //     body: 'Connect with the people from different places',
    //     doAnimateImage: true),
    PageModel.withChild(
      
        child: Padding(
          padding: EdgeInsets.only(bottom: 25.0),
          child: Image.asset('assets/3.jpg', width: 300.0, height: 300.0),
        ),
        color: const Color(0xFF5886d6),
        doAnimateChild: true)
  ];
}