import 'package:flutter/material.dart';

void main() {
  // runApp(MaterialApp(title: 'Navigation Basic',home:SimpleNavigation()));

  runApp(MaterialApp(
    title: 'Navigation Basic',
    //start the app with the "/" named route
    // initialRoute: '/',
    // routes: {
    //   '/': (context) => FirstScreen(),
    //   '/second': (context) => SecondScreen(),
    // },
    //home:SimpleNavigation()

    onGenerateRoute: (settings) {
      //for PassArgs
      if (settings.name == PassArgumentsScreen.routeName) {
        //if pass args
        final ScreenArguments args = settings.arguments;//obj for screen args

        return MaterialPageRoute(builder: (context) {
          return PassArgumentsScreen(
            title: args.title,
            message: args.message,
          );
        });
      }
    },

    home: HomeScreen(),
    routes: {
      ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen()//simple extract
    },
  ));
}

class SimpleNavigation extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Navigation')),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondRoute(),
                  ));
            },
            child: Text('Next'),
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Route'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First Screen'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
            child: Text('Launch Screen'),
          ),
        ));
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Navigate to Screen that extracts arguments'),
            onPressed: () {
              Navigator.pushNamed(context, ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                      //pass args
                      "Extract Args",
                      "Message from Extract Argument"));
            },
          ),
          RaisedButton(
            child: Text('Navigate to a named that accept arguments'),
            onPressed: () {
              Navigator.pushNamed(context, PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                      'Accept arguments screen', 'Message from passArguments'));
            },
          ),
        ],
      )),
    );
  }
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';
  @override
  Widget build(BuildContext context) {
    //extract the arguments from the current ModalRoute
    //settings and cast them as ScreenArguments
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

//accepts the necessary arguments via the constructor
class PassArgumentsScreen extends StatelessWidget {
  //create constructor
  static const routeName = '/passArguments';

  final String title;
  final String message;

  const PassArgumentsScreen(//constructor for screen args
      {
      //create constructor
      Key key,
      @required this.title,
      @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
