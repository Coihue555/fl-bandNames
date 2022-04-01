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
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;


  SocketService(){
    _initConfig();
  }
 
  void _initConfig(){  
    _socket = IO.io(
      "http://10.0.2.2:3001/",
      OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect() 
        .build()
    );
 
    _socket.onConnect((_) {
      _socket.emit('mensaje', 'conectado desde app Flutter');
      print('connect');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
 
    _socket.onDisconnect((_) {
      _socket.emit('mensaje', 'desconectado desde app Flutter');
      _serverStatus = ServerStatus.Offline;
      print('disconnected');
      notifyListeners();
    });



  }
}