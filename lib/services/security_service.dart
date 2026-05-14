import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final securityServiceProvider = Provider<SecurityService>((ref) => SecurityService());

class SecurityService {
  final _storage = const FlutterSecureStorage();
  final _localAuth = LocalAuthentication();

  // Biometrics
  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<bool> authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Secure your VaultX access',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  // Encryption
  Future<String> encryptText(String text, String key) async {
    final encryptionKey = encrypt.Key.fromUtf8(key.padRight(32).substring(0, 32));
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));

    final encrypted = encrypter.encrypt(text, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  Future<String> decryptText(String encryptedData, String key) async {
    try {
      final parts = encryptedData.split(':');
      final iv = encrypt.IV.fromBase64(parts[0]);
      final encryptedValue = parts[1];
      
      final encryptionKey = encrypt.Key.fromUtf8(key.padRight(32).substring(0, 32));
      final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));

      final decrypted = encrypter.decrypt64(encryptedValue, iv: iv);
      return decrypted;
    } catch (e) {
      return 'Error decrypting data';
    }
  }

  // PIN Storage
  Future<void> savePIN(String pin) async {
    await _storage.write(key: 'vault_pin', value: pin);
  }

  Future<String?> getPIN() async {
    return await _storage.read(key: 'vault_pin');
  }
}
