import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/constants/app_sizes.dart';
import '/dependency_injection/dependency_injection.dart';
import '/features/auth/data/respository/auth_respository.dart';
import '/providers/auth_repository_provider.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../components/image_picker_widget.dart';
import '/components/custom_app_top_bar.dart';

@RoutePage()
class UserProfileScreen extends StatelessWidget {
  static const routeName = '/profile-settings-screen';
  UserProfileScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = AuthRepository.instance.currentUser;
    userNameController.text = user!.username!;
    final authProvider = locator<AuthRepositoryProvider>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: customAppBar(
        title: 'Edit Profile',
        showLeadingButton: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ImagePickerWidget(
                imageString: user.pic!,
                cacheKey: user.pic!,
                onImagePicked: (image) {
                  authProvider.selectImage(image);
                },
              ),
            ),
            gapH20,
            Text(
              'Username',
              style: secondaryStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            gapH4,
            Form(
              key: _formKey,
              child: CustomTextFormField(
                key: const ValueKey('username'),
                hintText: 'Enter username here',
                controller: userNameController,
                validator: (username) {
                  if (username!.isEmpty) {
                    return 'Please enter a username';
                  }
                  if (username.length < 3) {
                    return 'Username must be at least 3 characters long';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<AuthRepositoryProvider>(
        builder: (context, auth, _) => BottomAppBar(
          elevation: 0,
          color: bgColor,
          child: CustomButton(
            onPressed: auth.isUpdatingProfile
                ? null
                : () => auth.updateProfile(
                      userNameController.text,
                      auth.pickedImage,
                      context,
                    ),
            label: auth.isUpdatingProfile ? 'Saving...' : 'Save Profile',
            width: double.infinity,
            height: 50,
            borderRadius: 8,
            elevation: 5,
            textStyle: buttonStyle,
          ),
        ),
      ),
    );
  }
}
