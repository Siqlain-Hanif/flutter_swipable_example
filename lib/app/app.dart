import 'package:flutter/material.dart';
import 'package:flutter_swipable_example/app/models/user.dart';
import 'package:flutter_swipable_example/app/user_browse_service.dart';
import 'package:flutter_swipable_example/app/widgets/user_card.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {
    init();
  }
  void init() async {
    UserBrowseService().browseUsers();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Tinder Cards")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<User>>(
            stream: UserBrowseService().usersBrowsed,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              if (!snapshot.hasData || snapshot.data == null)
                return Expanded(child: Text("Empty"));
              final users = snapshot.data ?? <User>[];
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                width: _mediaQuery.size.width,
                height: _mediaQuery.size.height -
                    kBottomNavigationBarHeight -
                    kToolbarHeight,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: AlignmentDirectional.center,
                  children: users.asMap().entries.map(
                    (entry) {
                      final index = entry.key;
                      final user = entry.value;
                      return UserCard(index: index, user: user);
                    },
                  ).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
