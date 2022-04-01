import 'package:flutter/material.dart';
 
import 'package:socket_io_client/socket_io_client.dart' as IO;
 
enum ServerStatus { Online, Offline, Connecting }
 
class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;
 
  ServerStatus get serverStatus => this._serverStatus;
 
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;
 
  SocketService() {
    this._initConfig();
  }
 
  void _initConfig() {
    
    IO.Socket socket = IO.io('https://localhost:3001/', {
      'transports': ['websocket'],
      'autoconnect': true
    });
       
    socket.on('connect', ( _ ){
      print('connect');
    });

    socket.on('disconnect', (_)=> print('disconnect'));
    socket.on('fromServer', (_)=> print(_));
  }
}