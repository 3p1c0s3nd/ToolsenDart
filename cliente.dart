import 'dart:io';

class Client {
  final String address;
  final int port;

  Client(this.address, this.port);

  void start() async {
    final socket = await Socket.connect(address, port);
    print('Conectado al servidor en ${socket.remoteAddress.address}:${socket.remotePort}');

    // Escuchar mensajes del servidor
    socket.listen((data) {
      print(String.fromCharCodes(data).trim());
    });

    // Enviar mensajes al servidor
    stdin.listen((data) {
      socket.write(String.fromCharCodes(data).trim());
    });
  }
}

void main() {
  final client = Client('localhost', 3000);
  client.start();
}
