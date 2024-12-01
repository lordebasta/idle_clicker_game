import 'package:flutter/material.dart';

class StateModel extends ChangeNotifier {
  static const int followerCost = 2;

  int nFollowers = 1;
  int fame = 0;
  int nDefeatedToilets = 0;
  int followerDestroyingTimeInSec = 2;
  int followerDestroyingTimer = 0;

  void destroyToilets(int amount) {
    nDefeatedToilets += amount;
    fame = (nDefeatedToilets / 10).floor();
    notifyListeners();
  }

  void runGameLoop() {
    followerDestroyingTimer += 1;
    if (followerDestroyingTimeInSec == followerDestroyingTimer) {
      destroyToilets(nFollowers);
      followerDestroyingTimer = 0;
    }
  }

  void hireFollowers(int amount) {
    nFollowers += amount;
    fame -= followerCost;
    notifyListeners();
  }
}
