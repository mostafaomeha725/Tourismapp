import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/features/auth/presentation/cubit/register_cubit.dart';
import 'package:tourismapp/features/auth/presentation/screens/widgets/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterCubit>(),
      child: const Scaffold(body: RegisterScreenBody()),
    );
  }
}
