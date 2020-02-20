import '../../models/post.dart';
import '../shared/ui_helpers.dart';
import '../widgets/post_item.dart';
import '../../viewmodels/posts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class PostsView extends StatelessWidget {
  const PostsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PostsViewModel>.withConsumer(
        viewModel: PostsViewModel(),
        onModelReady: (model) => model.listenToPosts(),
        builder: (context, model, child) => Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child:
                    !model.busy ? Icon(Icons.add) : CircularProgressIndicator(),
                onPressed: model.navigateToCreateView,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace(35),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          child: Image.asset('assets/images/logo-dino.png'),
                        ),
                      ],
                    ),
                    Expanded(
                        child: model.posts != null
                            ? ListView.builder(
                                itemCount: model.posts.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () => model.editPost(index),
                                  child: PostItem(
                                    post: model.posts[index],
                                    onDeleteItem: () => model.deletePost(index),
                                  ),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                ),
                              ))
                  ],
                ),
              ),
            ));
  }
}