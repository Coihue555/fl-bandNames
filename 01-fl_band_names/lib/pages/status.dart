import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_band_names/services/socket_service.dart';

class StatusScreen extends StatelessWidget {
   
  const StatusScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);
    //

    return Scaffold(
      body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text('Server status: ${socketService.serverStatus}')
           ],
         )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: (){
          socketService.emit('emitir-mensaje', {
            'nombre': 'Flutter',
            'mensaje': 'Hi from Flutter app!' });
          
        },
      ),
    );
  }
}