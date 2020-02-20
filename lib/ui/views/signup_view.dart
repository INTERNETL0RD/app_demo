import '../shared/ui_helpers.dart';
import '../widgets/busy_button.dart';
import '../widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../../viewmodels/signup_view_model.dart';
import '../widgets/expansion_list.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Registrate',
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
              verticalSpaceLarge,
              InputField(
                placeholder: 'Nombre completo',
                controller: fullNameController,
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Email',
                controller: emailController,
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Contraseña',
                password: true,
                controller: passwordController,
                additionalNote: 'Minimo de 6 caracteres',
              ),
              verticalSpaceSmall,
              ExpansionList<String>(
                  items: ['Admin', 'Usuario'],
                  title: model.selectedRole,
                  onItemSelected: model.setSelectedRole),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BusyButton(
                    title: 'Registrar',
                    busy: model.busy,
                    onPressed: () {
                      model.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          fullName: fullNameController.text);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}