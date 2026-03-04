abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  const AppException({required this.message, this.code, this.details});

  @override
  String toString() => 'AppException($code): $message';
}

class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    super.message = 'Erro no servidor',
    super.code = 'SERVER_ERROR',
    super.details,
    this.statusCode,
  });
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Sem conexão com a internet',
    super.code = 'NETWORK_ERROR',
    super.details,
  });
}

class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Tempo de requisição esgotado',
    super.code = 'TIMEOUT_ERROR',
    super.details,
  });
}

class CacheException extends AppException {
  const CacheException({
    super.message = 'Erro ao acessar cache',
    super.code = 'CACHE_ERROR',
    super.details,
  });
}

class SecureStorageException extends AppException {
  const SecureStorageException({
    super.message = 'Erro ao acessar storage seguro',
    super.code = 'SECURE_STORAGE_ERROR',
    super.details,
  });
}

class AuthException extends AppException {
  const AuthException({
    super.message = 'Erro de autenticação',
    super.code = 'AUTH_ERROR',
    super.details,
  });
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException({
    super.message = 'Credenciais inválidas',
    super.code = 'INVALID_CREDENTIALS',
    super.details,
  });
}

class SessionExpiredException extends AuthException {
  const SessionExpiredException({
    super.message = 'Sessão expirada',
    super.code = 'SESSION_EXPIRED',
    super.details,
  });
}

class ValidationException extends AppException {
  final Map<String, List<String>>? fieldErrors;

  const ValidationException({
    super.message = 'Dados inválidos',
    super.code = 'VALIDATION_ERROR',
    super.details,
    this.fieldErrors,
  });
}

class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Recurso não encontrado',
    super.code = 'NOT_FOUND',
    super.details,
  });
}

class ConflictException extends AppException {
  const ConflictException({
    super.message = 'Recurso já existe',
    super.code = 'CONFLICT',
    super.details,
  });
}

class BiometricException extends AppException {
  const BiometricException({
    super.message = 'Erro de biometria',
    super.code = 'BIOMETRIC_ERROR',
    super.details,
  });
}

class NfcException extends AppException {
  const NfcException({
    super.message = 'Erro de NFC',
    super.code = 'NFC_ERROR',
    super.details,
  });
}

class ScannerException extends AppException {
  const ScannerException({
    super.message = 'Erro de scanner',
    super.code = 'SCANNER_ERROR',
    super.details,
  });
}

class UnknownException extends AppException {
  const UnknownException({
    super.message = 'Erro inesperado',
    super.code = 'UNKNOWN_ERROR',
    super.details,
  });
}
