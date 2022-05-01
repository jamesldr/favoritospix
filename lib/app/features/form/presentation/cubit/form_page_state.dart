part of 'form_cubit.dart';

class FormPageState extends Equatable {
  const FormPageState({
    this.name,
    this.cpfCnpj,
    this.bankBranch,
    this.bankAccount,
    this.bankName,
    this.pixKey,
  });

  final String? name;
  final String? cpfCnpj;
  final String? bankBranch;
  final String? bankAccount;
  final String? bankName;
  final String? pixKey;

  @override
  List get props => [name, cpfCnpj, bankBranch, bankAccount, bankName, pixKey];

  FormPageState copyWith({
    String? name,
    String? cpfCnpj,
    String? bankBranch,
    String? bankAccount,
    String? bankName,
    String? pixKey,
  }) {
    return FormPageState(
      name: name ?? this.name,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      bankBranch: bankBranch ?? this.bankBranch,
      bankAccount: bankAccount ?? this.bankAccount,
      bankName: bankName ?? this.bankName,
      pixKey: pixKey ?? this.pixKey,
    );
  }
}
