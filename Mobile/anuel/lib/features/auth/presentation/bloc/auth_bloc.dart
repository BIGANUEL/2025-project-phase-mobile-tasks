import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpEvent(this.name, this.email, this.password);

  @override
  List<Object> get props => [name, email, password];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase signUp;
  final SignInUsecase signIn;

  AuthBloc({required this.signUp, required this.signIn}) : super(AuthInitial()) {
    on<SignUpEvent>(_handleSignUp);
    on<SignInEvent>(_handleSignIn);
  }

  Future<void> _handleSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signUp(event.name, event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _handleSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signIn(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}