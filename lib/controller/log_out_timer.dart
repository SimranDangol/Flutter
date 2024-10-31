
import 'dart:async';
import 'package:math_game/controller/auths.dart';


class LogoutTimer {

  late Timer _timer;
  int second = 0;

  AuthServices au = AuthServices();

  void initializeTimer() {
     _timer = Timer.periodic(const Duration(seconds: 1)
     , (timer) {
      startSecond();
        if (second == 25) {
        autoLogout();
        print("Successfully log out");
      }
      });
   
  }

  void startSecond() {
    second ++;
  }

  
  void autoLogout() {
    _timer.cancel();
   // au.logoutUser();
  }

  // You will probably want to wrap this function in a debounce
        
        void _handleUserInteraction([_]) {
            if (_timer != null && !_timer.isActive) {
              // This means the user has been logged out
              return;
            }
        
            _timer.cancel();
            initializeTimer();
          }
  
  
  
}