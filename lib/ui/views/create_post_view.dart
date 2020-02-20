import '../../models/post.dart';
import '../shared/ui_helpers.dart';
import '../widgets/input_field.dart';
import '../../viewmodels/create_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CreatePostView extends StatelessWidget {
  final titleController = TextEditingController();
  final Post edittingPost;
  CreatePostView({Key key, this.edittingPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreatePostViewModel>.withConsumer(
      viewModel: CreatePostViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        titleController.text = edittingPost?.title ?? '';

        model.setEdittingPost(edittingPost);
      },
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              if (!model.busy) {
                model.addPost(title: titleController.text);
              }
            },
            backgroundColor:
                !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                Text(
                  'Crea un post',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Titulo',
                  controller: titleController,
                ),
                verticalSpaceMedium,
                Text('Imagen del post'),
                verticalSpaceSmall,
                GestureDetector(
                  onTap: () => model.selectImage(),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: model.selectedImage == null ? Text(
                      'Toca para añadir una imagen',
                      style: TextStyle(color: Colors.grey[400]),
                    ) : Image.file(model.selectedImage),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
