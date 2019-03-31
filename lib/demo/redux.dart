import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions {
  Increase,
  LogoutSuccess,
  LoginSuccess,
  Login,
}

class Action {
  final Actions type;

  Action({this.type});
}

AppState mainReducer(AppState state, dynamic action) {
  if (Actions.Increase == action) {
    state.main.counter += 1;
  }

  if (Actions.LogoutSuccess == action) {
    state.auth.isLogin = false;
    state.auth.account = null;
  }

  if (action is LoginSuccessAction) {
    state.auth.isLogin = true;
    state.auth.account = action.account;
  }

  return state;
}

void main() {
  Store<AppState> store = Store<AppState>(
    mainReducer,
    initialState: AppState(
      main: MainPageState(),
      auth: AuthState(),
    ),
  );
  runApp(new MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        //   home:
        home: StoreConnector<AppState, AppState>(
            builder: (BuildContext context, AppState state) {
          return new MyHomePage(
              title: 'Flutter Demo Home Page',
              counter: state.main.counter,
              isLogin: state.auth.isLogin,
              account: state.auth.account);
        }, converter: (Store<AppState> store) {
          return store.state;
        }),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title, this.counter, this.isLogin, this.account})
      : super(key: key);
  final String title;
  final int counter;
  final bool isLogin;
  final String account;

  @override
  Widget build(BuildContext context) {
    Widget loginPanel;
    if (isLogin) {
      loginPanel = StoreConnector(
          key: ValueKey("login"),
          builder: (BuildContext context, VoidCallback logout) {
            return RaisedButton(
              onPressed: logout,
              child: Text("您好:$account,点击退出"),
            );
          },
          converter: (Store<AppState> store) {
            return () => store.dispatch(Actions.LogoutSuccess);
          });
    } else {
      loginPanel = StoreConnector(
          key: ValueKey("logout"),
          builder: (BuildContext context, VoidCallback login) {
            return RaisedButton(
              onPressed: login,
              child: Text("登录"),
            );
          },
          converter: (Store<AppState> store) {
            return () => store.dispatch(new LoginSuccessAction("xxx account!"));
          });
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$counter',
              style: Theme.of(context).textTheme.display1,
            ),
            loginPanel,
          ],
        ),
      ),
      floatingActionButton: StoreConnector<AppState, VoidCallback>(
          builder: (BuildContext context, VoidCallback callback) {
        return new FloatingActionButton(
          onPressed: callback,
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        );
      }, converter: (Store<AppState> store) {
        return () => store.dispatch(Actions.Increase);
      }),
    );
  }
}

class AuthState {
  bool isLogin;
  String account;

  AuthState({this.isLogin: false, this.account});
}

class MainPageState {
  int counter;

  MainPageState({this.counter: 0});
}

class AppState {
  AuthState auth;
  MainPageState main;

  AppState({this.auth, this.main});
}

class LoginSuccessAction extends Action {
  final String account;

  LoginSuccessAction(this.account) : super(type: Actions.LoginSuccess);
}
