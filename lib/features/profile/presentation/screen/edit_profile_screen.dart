import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/features/auth/presentation/cubit/update_profile_cubit.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_appbar.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/edit_profile_screen_body.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Edit Profile'),
      body: BlocProvider(
        create: (_) => sl<UpdateProfileCubit>(),
        child: const EditProfileScreenBody(),
      ),
    );
  }
}
