import 'package:flutter_swipable_example/app/api_providers/users_api_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'models/user.dart';

class UserBrowseService {
  final _usersApi = UsersApiProvider();
  static final UserBrowseService _instance = UserBrowseService._internal();

  //Storage a queue or more precisely a reverse queue you can figure that on your own
  //Hint : reverse queue + stack ?
  final usersBrowsed = BehaviorSubject<List<User>>();

  //If you want to show loading status in case your queue is empty
  final browsedLoading = BehaviorSubject<bool>.seeded(false);
  UserBrowseService._internal();

  factory UserBrowseService() => _instance;

  void _maybeBrowseMore() {
    // Fetch fresh ones when two or less remaining after swipe
    List<User> browsed = usersBrowsed.value;
    if (browsed.length <= 3) {
      browseUsers();
    }
  }

  Future<List<User>> browseMoreUsers() async {
    List<User> browsedUsers = await _usersApi.getUsers();
    return browsedUsers;
  }

  Future<void> browseUsers() async {
    browsedLoading.add(true);
    List<User> users = await browseMoreUsers();
    _addMoreUsersToQueue(users);
    browsedLoading.add(false);
  }

  // Adds new brosed users -- duplicates allowed
  void _addMoreUsersToQueue(List<User> browsed) {
    List<User> usersInList = usersBrowsed.valueOrNull ?? <User>[];
    print("Added ${browsed.length} more users");
    usersBrowsed.add(browsed + usersInList);
  }

  void _removeFromBrowsedUserByIndex(int swipedOn) {
    List<User> browsed = usersBrowsed.value;
    browsed.removeAt(swipedOn);
    usersBrowsed.add(browsed);
    _maybeBrowseMore();
  }

  Future<void> swipedLeft(int index, User user) async {
    assert(usersBrowsed.valueOrNull != null);
    _removeFromBrowsedUserByIndex(index);
    print("After Swiping Left ${usersBrowsed.valueOrNull!.length}");
  }

  Future<void> swipedRight(int index, User user) async {
    assert(usersBrowsed.valueOrNull != null);
    _removeFromBrowsedUserByIndex(index);
    print("After Swiping Right ${usersBrowsed.valueOrNull!.length}");
  }
}
