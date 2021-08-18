import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:flutter_swipable_example/app/models/user.dart';
import 'package:flutter_swipable_example/app/user_browse_service.dart';

class UserCard extends StatelessWidget {
  final User user;
  final int index;
  const UserCard({required this.user, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      onSwipeDown: (finalPosition) {},
      onSwipeUp: (finalPosition) {},
      onSwipeLeft: (finalPosition) {
        UserBrowseService().swipedLeft(index, user);
      },
      onSwipeRight: (finalPosition) {
        UserBrowseService().swipedRight(index, user);
      },
      onPositionChanged: (details) {},
      onSwipeStart: (details) {},
      onSwipeCancel: (position, details) {},
      onSwipeEnd: (position, details) {},
      child: Card(
        elevation: 2,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;
            return Container(
              padding: EdgeInsets.all(12),
              height: maxHeight,
              width: maxWidth,
              color: Colors.blueGrey.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 140,
                    width: 140,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.picture),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    '${user.name}, (${user.gender.toUpperCase()[0]})',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${user.city}, ${user.country}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
