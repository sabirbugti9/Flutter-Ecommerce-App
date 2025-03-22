import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velvet_app/blocs/auth/auth_event.dart';
import 'package:velvet_app/blocs/auth/auth_state.dart';
import 'package:velvet_app/repositories/auth_repository.dart';
import 'package:velvet_app/services/storage_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<LoginRequsted>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final user = await repository.login(event.email, event.password);

          // save token
          if (user.token.isNotEmpty) {
            final userProfile = await repository.getUserProfile(user.token);

            // save token to SF
            await StorageService.saveToken(user.token);

            emit(Authenticated(user: userProfile));
          } else {
            emit(AuthError(message: 'Token Error'));
          }
        } catch (e) {
          emit(AuthError(message: '$e'));
        }
      },
    );

    on<RegisterRequested>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final user = await repository.register(
              event.name, event.email, event.password);

          // Save Token
          if (user.token.isNotEmpty) {
            final userProfile = await repository.getUserProfile(user.token);
            await StorageService.saveToken(user.token);

            emit(Authenticated(user: userProfile));
          } else {
            emit(AuthError(message: 'Token Error'));
          }
        } catch (e) {
          emit(AuthError(message: 'Error: $e'));
        }
      },
    );

    on<LogoutRequested>(
      (event, emit) async {
        await StorageService.removeToken();
        emit(AuthInitial());
      },
    );

    on<CheckLoginStatus>(
      (event, emit) async {
        final token = await StorageService.getToken();
        if (token != null && token.isNotEmpty) {
          try {
            final userProfile = await repository.getUserProfile(token);
            emit(Authenticated(user: userProfile));
          } catch (e) {
            emit(AuthError(message: '$e'));
          }
        } else {
          emit(UnAuthenticated());
        }
      },
    );
  }
}
