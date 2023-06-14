import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/providers/posts_provider.dart';
import 'package:untitled6/providers/user_provider.dart';
import 'package:untitled6/pages/home/widget/bottomSheetButton.dart';
import 'package:untitled6/pages/home/widget/header.dart';
import 'package:untitled6/pages/home/widget/postButton.dart';
import '../detail/detail.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> _refreshData(BuildContext context) async {
    final providerPosts = Provider.of<PostsProvider>(context, listen: false);
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    await providerPosts.getDataFromAPI();
    await usersProvider.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => PostsProvider()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF4E8),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/fond_home.png',
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Expanded(
                  child: Consumer2<PostsProvider, UsersProvider>(
                    builder: (context, providerPosts, usersProvider, _) {
                      if (!providerPosts.isDataLoaded) {
                        providerPosts.getDataFromAPI();
                      }
                      if (!usersProvider.isDataLoaded) {
                        usersProvider.fetchUsers();
                      }
                      return RefreshIndicator(
                        onRefresh: () => _refreshData(context),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (scrollNotification is ScrollEndNotification &&
                                scrollNotification.metrics.extentAfter == 0 &&
                                !providerPosts.isLoading) {
                              providerPosts.loadMoreData();
                            }
                            return false;
                          },
                          child: CustomScrollView(
                            slivers: [
                              const SliverToBoxAdapter(
                                child: HeaderSection(),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 50, bottom: 50, left: 50, right: 50),
                                  child: PostButton(),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    if (index < providerPosts.searchedPosts.length) {
                                      final post = providerPosts.searchedPosts[index];
                                      final user = usersProvider.getUserById(post.userId);
                                      return AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration: const Duration(milliseconds: 500),
                                        child: SlideAnimation(
                                          horizontalOffset: 200.0,
                                          child: FadeInAnimation(
                                            child: Container(
                                              child: getBodyUI(context, post, user),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: providerPosts.hasMoreData
                                            ? Visibility(
                                          visible: providerPosts.searchText.isEmpty,
                                          child: const CircularProgressIndicator(),
                                        )
                                            : const Text("Aucune donnée supplémentaire"),
                                      );
                                    }
                                  },
                                  childCount: providerPosts.searchedPosts.length + 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const BottomSheetButton()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getBodyUI(BuildContext context, post, user) {

    final userName = user?.name ?? 'Unknown User';
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 10,
            right: 10,
          ),
          margin: const EdgeInsets.only(
            bottom: 70,
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(2, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: ListTile(
            title: Column(
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontFamily: 'PublicSans',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
            subtitle: Text(
              'Ecrit par : $userName',
              style: const TextStyle(
                fontFamily: 'PublicSans',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: 45,
          right: 25,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1, 2),
                  blurRadius: 0,
                ),
              ],
            ),
            child: FloatingActionButton(
              heroTag: 'post_${post.id}',
              backgroundColor: const Color(0xFFFFDC02),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Detail(post: post, user: user,),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_forward,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
