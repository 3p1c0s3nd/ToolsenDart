import 'dart:io';
import 'dart:async';

class Server {
  final int port;
  List<Socket> clients = [];

  Server(this.port);

  void start() async {
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    print('Servidor escuchando en el puerto ${server.port}...');

    await for (var client in server) {
      print('Cliente conectado desde ${client.remoteAddress.address}:${client.remotePort}');
      clients.add(client);
      client.listen((data) {
        broadcast(String.fromCharCodes(data).trim(), from: client);
      }, onDone: () {
        print('Cliente desconectado');
        clients.remove(client);
      });
    }
  }

  void broadcast(String message, {Socket from}) {
    for (final client in clients) {
      if (client != from) {
        client.write(message);
      }
    }
  }
}

void main() {
  final server = Server(3000);
  server.start();
}
