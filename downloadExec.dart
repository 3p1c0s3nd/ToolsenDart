import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> downloadAndExecute(String url, String savePath) async {
  try {
    // Descarga el archivo
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Escribe el archivo en el sistema local
      var file = File(savePath);
      await file.writeAsBytes(response.bodyBytes);

      // Ejecuta el archivo
      Process.run(savePath, []).then((ProcessResult results) {
        print(results.stdout);
      });
    } else {
      print('Error al descargar el archivo: ${response.statusCode}');
    }
  } catch (e) {
    print('Ocurrió un error: $e');
  }
}

void main() {
  // URL del archivo a descargar
  String url = 'http://ejemplo.com/archivo.exe';

  // Ruta local para guardar el archivo
  String savePath = '/path/to/save/archivo.exe';

  // Descarga y ejecuta el archivo
  downloadAndExecute(url, savePath);
}
