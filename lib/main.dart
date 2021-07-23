import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_test/features/order/data/datasources/order_datasource.dart';
import 'package:test_test/features/order/data/repositroy/order_repository_impl.dart';
import 'package:test_test/features/order/presentation/pages/order_page.dart';
import 'features/order/presentation/bloc/order_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OrderRepositoryImpl(OrderDataSource()),
      child: BlocProvider(
        create: (context) =>
            OrderBloc(RepositoryProvider.of<OrderRepositoryImpl>(context)),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: IntroPage(),
        ),
      ),
    );
  }
}

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      BlocProvider.of<OrderBloc>(context)
        ..add(OrderGetMerchs())
        ..add(OrderGenerateRandom());
    });
    _redirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FlutterLogo(
          size: 300,
          style: FlutterLogoStyle.stacked,
        ),
      ),
    );
  }

  void _redirect() async {
    await Future.delayed(Duration(seconds: 2));
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OrderPage()));
  }
}
