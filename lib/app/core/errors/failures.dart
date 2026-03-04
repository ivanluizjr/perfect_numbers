import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic details;

  const Failure({required this.message, this.code, this.details});

  @override
  List<Object?> get props => [message, code, details];
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    super.message = 'Erro no servidor. Tente novamente mais tarde.',
    super.code = 'SERVER_ERROR',
    super.details,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, code, details, statusCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Sem conexão com a internet.',
    super.code = 'NETWORK_ERROR',
    super.details,
  });
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'A requisição demorou muito. Tente novamente.',
    super.code = 'TIMEOUT_ERROR',
    super.details,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Erro ao acessar dados locais.',
    super.code = 'CACHE_ERROR',
    super.details,
  });
}

class SecureStorageFailure extends Failure {
  const SecureStorageFailure({
    super.message = 'Erro ao acessar armazenamento seguro.',
    super.code = 'SECURE_STORAGE_ERROR',
    super.details,
  });
}

class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Erro de autenticação.',
    super.code = 'AUTH_ERROR',
    super.details,
  });
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure({
    super.message = 'E-mail ou senha incorretos.',
    super.code = 'INVALID_CREDENTIALS',
    super.details,
  });
}

class SessionExpiredFailure extends AuthFailure {
  const SessionExpiredFailure({
    super.message = 'Sua sessão expirou. Faça login novamente.',
    super.code = 'SESSION_EXPIRED',
    super.details,
  });
}

class UnauthenticatedFailure extends AuthFailure {
  const UnauthenticatedFailure({
    super.message = 'Você precisa estar logado para acessar.',
    super.code = 'UNAUTHENTICATED',
    super.details,
  });
}

class UnauthorizedFailure extends AuthFailure {
  const UnauthorizedFailure({
    super.message = 'Você não tem permissão para acessar.',
    super.code = 'UNAUTHORIZED',
    super.details,
  });
}

class BiometricFailure extends AuthFailure {
  const BiometricFailure({
    super.message = 'Autenticação biométrica falhou.',
    super.code = 'BIOMETRIC_ERROR',
    super.details,
  });
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;

  const ValidationFailure({
    super.message = 'Dados inválidos.',
    super.code = 'VALIDATION_ERROR',
    super.details,
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [message, code, details, fieldErrors];
}

class PaymentFailure extends Failure {
  const PaymentFailure({
    super.message = 'Erro ao processar pagamento.',
    super.code = 'PAYMENT_ERROR',
    super.details,
  });
}

class InsufficientBalanceFailure extends PaymentFailure {
  const InsufficientBalanceFailure({
    super.message = 'Saldo insuficiente para esta operação.',
    super.code = 'INSUFFICIENT_BALANCE',
    super.details,
  });
}

class TransactionLimitFailure extends PaymentFailure {
  const TransactionLimitFailure({
    super.message = 'Limite de transação excedido.',
    super.code = 'TRANSACTION_LIMIT',
    super.details,
  });
}

/// Chave Pix inválida.
class InvalidPixKeyFailure extends PaymentFailure {
  const InvalidPixKeyFailure({
    super.message = 'Chave Pix inválida.',
    super.code = 'INVALID_PIX_KEY',
    super.details,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Recurso não encontrado.',
    super.code = 'NOT_FOUND',
    super.details,
  });
}

class AlreadyExistsFailure extends Failure {
  const AlreadyExistsFailure({
    super.message = 'Este recurso já existe.',
    super.code = 'ALREADY_EXISTS',
    super.details,
  });
}

class NfcFailure extends Failure {
  const NfcFailure({
    super.message = 'Erro ao usar NFC.',
    super.code = 'NFC_ERROR',
    super.details,
  });
}

class NfcNotSupportedFailure extends NfcFailure {
  const NfcNotSupportedFailure({
    super.message = 'Este dispositivo não suporta NFC.',
    super.code = 'NFC_NOT_SUPPORTED',
    super.details,
  });
}

class ScannerFailure extends Failure {
  const ScannerFailure({
    super.message = 'Erro ao acessar a câmera.',
    super.code = 'SCANNER_ERROR',
    super.details,
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Ocorreu um erro inesperado.',
    super.code = 'UNKNOWN_ERROR',
    super.details,
  });
}
