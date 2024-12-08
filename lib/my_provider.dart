import 'package:flutter/material.dart';

class StateModel extends ChangeNotifier {
  static const int followerCost = 2;
  static const int toiletsInItaly = 41300000;
  static const int toiletsInEu = 525000000;
  static const int toiletsInWorld = 24000000000;
  static const int toiletsInHell = 58500000; // 1 per 1000
  static const int toiletsInHeaven = 58500000000; // 1 per 1

  int nFollowers = 0;
  Duration timePassed = const Duration();

  int fame = 0;
  int toiletsPerFameRatio = 10;
  double fameIncrementCounter = 0;

  int food = 0;
  double nDefeatedToilets = 0;
  int followerDestroyingTimeInMs = 2000;
  double followerDestroyingTimerInMs = 0;

  void destroyToilets(double amount) {
    nDefeatedToilets += amount;
    fameIncrementCounter += amount;

    if (fameIncrementCounter >= toiletsPerFameRatio) {
      fame += (fameIncrementCounter / toiletsPerFameRatio).floor();
      fameIncrementCounter %= toiletsPerFameRatio;
    }
  }

  void runGameLoop(int deltaInMs) {
    // 1 sec irl = 1 hour in game
    // 1000 ms irl = 60 minutes in game = 3600 seconds in game
    // 1 ms irl = 3.6 seconds in game = 3600 ms in game
    timePassed += Duration(milliseconds: 3600 * deltaInMs);

    double nDestroyedToilets =
        nFollowers * (deltaInMs / followerDestroyingTimeInMs);
    destroyToilets(nDestroyedToilets);

    notifyListeners();
  }

  void hireFollowers(int amount) {
    int cost = amount * followerCost;
    if (fame < cost) {
      return;
    }
    nFollowers += amount;
    fame -= cost;
    notifyListeners();
  }
}
