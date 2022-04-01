
import 'package:fl_band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_band_names/pages/home.dart';
import 'package:fl_band_names/pages/status.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ )=> SocketService() )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home'  : ( _ ) => const HomeScreen(),
          'status': ( _ ) => const StatusScreen()
        },
        
      ),
    );
  }
}