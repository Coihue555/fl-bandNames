import 'package:flutter/material.dart';
 
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
 
// enum ServerStatus { Online, Offline, Connecting }
 
// class SocketService with ChangeNotifier {
//   ServerStatus _serverStatus = ServerStatus.Connecting;
//   late IO.Socket _socket;
 
//   ServerStatus get serverStatus => this._serverStatus;
 
//   IO.Socket get socket => this._socket;
//   Function get emit => this._socket.emit;
 
//   SocketService() {
//     this._initConfig();
//   }
 
//   void _initConfig() {
    

//     IO.Socket socket = IO.io('http://10.0.2.2:3001/', {  ///al menos aparece disconnect
//       'transports': ['websocket'],
//       'autoconnect': true
//     });
       
//     socket.on('connect',    (_)=> print('connecteee'));

//     socket.on('disconnect', (_)=> print('disconnecteee'));
//     socket.on('fromServer', (_)=> print(_));
//   }
// }

//
enum ServerStatus{
  Online,
  Offline,
  Connecting,
}
 
class SocketService with ChangeNotifier {
  late ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => this._serverStatus;
 
  SocketService(){
    _initConfig();
  }
 
  void _initConfig(){  
    IO.Socket socket = IO.io(
      "http://10.0.2.2:3001/",
      OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect() 
        .build()
    );
 
    socket.onConnect((_) {
      socket.emit('mensaje', 'conectado desde app Flutter');
      print('connect');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
 
    socket.onDisconnect((_) {
      socket.emit('mensaje', 'desconectado desde app Flutter');
      _serverStatus = ServerStatus.Offline;
      print('disconnectio');
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', (payload) {
    //   print('nuevo-mensaje: ');
    //   print('nombre:' + payload['nombre']);
    //   print('mensaje:' + payload['mensaje']);
    //   print( payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay' );
    // });


  }
}