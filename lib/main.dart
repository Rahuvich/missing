import './ui/loginPage/loginPage.dart';
import 'package:flutter/material.dart';
import './ui/homePage/homePage_vm.dart';
import './themeData.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './models/appState.dart';
import './redux/reducers.dart';
import 'package:redux_logging/redux_logging.dart';
import './redux/middleware.dart';
import './redux/actions.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = Store<AppState>(appStateReducer,
        initialState: AppState.initial(),
        //middleware: [LoggingMiddleware.printer(), appStateMiddleware]);
        middleware: [appStateMiddleware]);
    return StoreProvider<AppState>(
      store: store,
      child: MyTheme(child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'missing',
            debugShowCheckedModeBanner: false,
            color: Color(0xffff7675),
            theme: buildTheme(context, false),
            home: StoreBuilder<AppState>(
              onInit: (store) => store.dispatch(GetCards()),
              builder: (context, store) => HomePageBuilder(), //HomePage(),
            ),
          );
        },
      )),
    );
  }

  ThemeData buildTheme(context, bool darkTheme) {
    ThemeData baseTheme = (darkTheme)
        ? ThemeData(
            brightness: Brightness.dark,
            fontFamily: "Nunito",
          )
        : ThemeData(
            brightness: Brightness.light,
            fontFamily: "Nunito",
          );
    return baseTheme.copyWith(
        primaryColor: MyTheme.of(context).kPrimaryColor,
        primaryColorLight: MyTheme.of(context).kPrimaryLight,
        primaryColorDark: MyTheme.of(context).kPrimaryDark,
        splashColor: Colors.grey.shade300,
        canvasColor: MyTheme.of(context).kBackground,
        iconTheme: IconThemeData(
          color: MyTheme.of(context).iconsColor
        ),
        textTheme: baseTheme.textTheme.copyWith(
          headline: baseTheme.textTheme.headline.copyWith(
            fontSize: 20
          ),
          title: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 18
          ),
          subtitle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
            fontWeight: FontWeight.w300
          ),
        ));
  }
}
