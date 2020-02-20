import 'package:flutter/material.dart';
import 'package:prototipo_agifreu/ui/shared/ui_helpers.dart';
import 'package:prototipo_agifreu/ui/widgets/expansion_list.dart';
import 'package:prototipo_agifreu/ui/widgets/input_field.dart';
import 'package:prototipo_agifreu/ui/widgets/text_link.dart';
import 'package:prototipo_agifreu/viewmodels/profile_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class ProfileView extends StatelessWidget {
  final dateController = TextEditingController();
  final userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      onModelReady: (n) {
        dateController.text = n.currentUser.date;
        userController.text = n.currentUser.userRole;
      },
      viewModel: ProfileViewModel(),
      builder: (context, model, child) => Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: model.selectedBkdPic == null
                                ? (model.currentUser.bkdPicUrl != null
                                    ? NetworkImage(model.currentUser.bkdPicUrl)
                                    : NetworkImage(
                                        'https://alucobond.imgix.net/http%3A%2F%2Fcms.alucobond.com%2Fstorage%2Fuploads%2F2018%2F08%2F10%2F5b6d36cfb5bcasolid-104.jpg?auto=compress&cs=tinysrgb&dpr=1&ixlib=php-1.2.1&q=39&w=1128&s=09daae017c251fc53c0c80302b18fdea'))
                                : FileImage(model.selectedBkdPic),
                            fit: BoxFit.cover)),
                  ),
                 !model.isEditting ? GestureDetector(
                    onTap: () => model.selectBkdPic(),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black38,
                      child: Center(
                          child: Icon(
                        Icons.edit,
                        size: 40,
                      )),
                    ),
                  ) : Container(),
                  Positioned(
                      left: 20,
                      bottom: -25,
                      child: GestureDetector(
                        onTap: () {
                          if (!model.isEditting) {
                            model.selectProfilePic();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff0F1013),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(offset: Offset(5, 5), blurRadius: 10)
                              ]),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: model.selectedProfilePic == null
                                ? (model.currentUser.picUrl != null
                                    ? NetworkImage(model.currentUser.picUrl)
                                    : AssetImage(
                                        'assets/images/profile-pic.png'))
                                : FileImage(model.selectedProfilePic),
                          ),
                        ),
                      )),
                 !model.isEditting ? Positioned(
                      left: 20,
                      bottom: -25,
                      child: GestureDetector(
                        onTap: () {
                          if (!model.isEditting) {
                            model.selectProfilePic();
                          }
                        },
                        child: Container(
                          width: 108,
                          height: 108,
                          child: Center(
                              child: Icon(
                            Icons.edit,
                            size: 40,
                          )),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black38),
                        ),
                      )): Container(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(30),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text(
                      model.currentUser.fullName,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceLarge,
                    Row(
                      children: <Widget>[
                        Text("Nacido:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(width: 40),
                        Expanded(
                            child: InputField(
                          controller: dateController,
                          placeholder: 'DD/MM/AAAA',
                          isReadOnly: model.isEditting,
                        ))
                      ],
                    ),
                    verticalSpaceMedium,
                    Row(
                      children: <Widget>[
                        Text("Tipo de cuenta:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(width: 40),
                        Expanded(
                            child: InputField(
                          controller: userController,
                          placeholder: model.currentUser.userRole,
                          isReadOnly: model.isEditting,
                        ))
                      ],
                    ),
                    verticalSpaceMedium,
                    Expanded(
                        child: Container(
                      alignment: Alignment.bottomCenter,
                      child: model.busy
                          ? CircularProgressIndicator()
                          : TextLink(
                              model.isEditting
                                  ? "Editar informacion"
                                  : "Guardar cambios",
                              onPressed: () {
                                if (!model.isEditting) {
                                  model.saveChanges(
                                      dateController.text, userController.text);
                                }
                                model.toggleEdit();
                              },
                            ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
