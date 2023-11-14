import 'dart:async';
import 'dart:io';

class SocketService {
  late Socket _socket;

  Future<void> createSocketConnection() async {
    try {
      // Replace with your server's IP address and port
      _socket = await Socket.connect('192.168.1.10', 4444);
      _socket.listen(
        (List<int> data) {
          print(new String.fromCharCodes(data).trim());
          // Handle data from the server
        },
        onError: (error) {
          print(error);
          _socket.destroy();
        },
        onDone: () {
          print('Disconnected from the server.');
          _socket.destroy();
        },
      );
    } on SocketException catch (e) {
      print('Socket Exception: $e');
    } on Exception catch (e) {
      print('General Exception: $e');
    }
  }

  void sendMessage(String message) {
    _socket.write(message);
  }

  void dispose() {
    _socket.close();
  }
}
