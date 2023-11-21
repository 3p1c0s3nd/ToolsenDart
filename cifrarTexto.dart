import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

final key = Uint8List.fromList(List.generate(16, (index) => index));
final iv = Uint8List.fromList(List.generate(16, (index) => index));

Uint8List encryptAES(Uint8List plainText, Uint8List key, Uint8List iv) {
  final cipher = PaddedBlockCipherImpl(
      PKCS7Padding(), CBCBlockCipher(AESFastEngine()));
  cipher.init(true, PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv), null));

  return cipher.process(plainText);
}

Uint8List decryptAES(Uint8List cipherText, Uint8List key, Uint8List iv) {
  final cipher = PaddedBlockCipherImpl(
      PKCS7Padding(), CBCBlockCipher(AESFastEngine()));
  cipher.init(false, PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv), null));

  return cipher.process(cipherText);
}

void main() {
  // Texto a cifrar
  String text = 'Texto secreto';
  Uint8List plainText = Uint8List.fromList(utf8.encode(text));

  // Cifrado
  Uint8List cipherText = encryptAES(plainText, key, iv);
  print('Texto cifrado: $cipherText');

  // Descifrado
  Uint8List decryptedText = decryptAES(cipherText, key, iv);
  print('Texto descifrado: ${utf8.decode(decryptedText)}');
}
