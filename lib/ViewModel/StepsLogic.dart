import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Background Step Counter

//Tells Flutter dont remove this function background Service needs it
@pragma('vm:entry-point')
Future<void> onBgServiceStart(ServiceInstance service) async {
  // run if Android Specific code
  if (service is AndroidServiceInstance) {
    //It keeps running Service
    service.setAsForegroundService();

    //flutter notification object
    final FlutterLocalNotificationsPlugin notifiacation =
        FlutterLocalNotificationsPlugin();

    //For notification can use app icon in notification
    const InitializationSettings InitSetting = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    // initialize notification with App icon
    await notifiacation.initialize(settings: InitSetting);

    /* Create notification channel object
          - notifiacation channel is group of notification*/
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'steps_channel', // id of channel
      'steps tracker', // channel name
      description:
          'count your steps in backgound', //this explain what is your channel is used for
      importance: Importance
          .low, // this tells android how important this notification from this channel
    );

    //create channel on anroid
    await notifiacation
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // show this when background service start
    service.setForegroundNotificationInfo(
      title: "Step Tracker",
      content: "Counting your info",
    );
  }

  //Use for listn senssor update
  StreamSubscription<StepCount>? sub;

  //stepCountStream - continiuosly give data from phone sensor
  sub = Pedometer.stepCountStream.listen(
    //Every time data arive this function runs
    (StepCount event) async {
      final prefs = await SharedPreferences.getInstance();
      final today = DateFormat('yyyy-mm-dd').format(DateTime.now());

      await prefs.setInt('bg_total_$today', event.steps);

      //read initial step count
      int? savedInitial = prefs.getInt('initial_$today');

      //Storing initial step count
      if (savedInitial == null) {
        savedInitial = event.steps;
        await prefs.setInt('initial_$today', savedInitial);
      }

      //saved today steps
      final todaySteps = (event.steps - savedInitial).clamp(0, 9999999);

      await prefs.setInt("Steps_$today", todaySteps);

      debugPrint("[BG]Steps Saved => $todaySteps");

      //update Notification
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "Steps Tracker",
          content: "Today Step Count is $todaySteps",
        );
      }
    },
    onError: (e) => debugPrint("[BG]Steps error: $e"),
  );

  //when Stop message arive it stop steps sensor strem and stop background service completly
  service.on('stop').listen((_) {
    sub?.cancel();
    service?.stopSelf();
  });
}

@pragma('vm:entry-point')
Future<bool> onBackground(ServiceInstance service) async {
  return true;
}
//For starting background service

Future<void> initBackgroundService() async {
  //For manging notification
  final FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();

  const InitializationSettings InitSetting = InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  );

  //start notification
  await notification.initialize(settings: InitSetting);

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'steps_channel',
    'steps tracker',
    description: "Cont your steps in background",
    importance: Importance.low,
  );

  await notification
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onBgServiceStart,
      isForegroundMode: true,
      notificationChannelId: 'steps_channel',
      initialNotificationTitle: 'steps tracker',
      initialNotificationContent: 'Starting...',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onBgServiceStart,
      onBackground: onBackground,
    ),
  );

  await service.startService();
}

//========================= Steps-Logic ====================================
/* initilize()
   RequestPermission()
   LoadData()
   StartStepCounter()
   StartStatusListner()
   LoadTodaySteps()
   LoadWeeklyData()
   SetGoal()
   LoadGoal()
   Dispoce()
   Datekey,
   Progress
 */

class StepsLogic {
  //use store connection between app and android
  StreamSubscription<StepCount>? stepSubscription;

  //same but fore status
  StreamSubscription<PedestrianStatus>? statusSubscription;

  bool isLoading = false;
  bool isWalking = false;
  bool permissionGranted = false;

  String status = "stoped";

  int totalSensorSteps = 0;
  int initialSteps = 0;
  int todaySteps = 0;

  double calories = 0.0;
  double distance = 0.0;

  int daily_Goal = 10000;

  List<Map<String, dynamic>> weeklyData = [];

  String getdateKey() => DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> Initilize({required VoidCallback Refresh}) async {
    await LoadGoal();
    await RequestPermission(Refresh: Refresh);
  }

  Future<void> RequestPermission({required VoidCallback Refresh}) async {
    isLoading = true;
    Refresh();

    final result = await Permission.activityRecognition.request();

    permissionGranted = result.isGranted;

    if (permissionGranted) {
      await initBackgroundService();
      await LoadData();
      await StartStepsCounter(Refresh: Refresh);
      await StartStatusListner(Refresh: Refresh);
    }

    isLoading = false;
    Refresh();
  }

  Future<void> LoadData() async {
    await LoadTodaySteps();
    await LoadWeeklyData();
  }

  Future<void> StartStepsCounter({required VoidCallback Refresh}) async {
    await stepSubscription?.cancel();

    stepSubscription = Pedometer.stepCountStream.listen((
      StepCount event,
    ) async {
      final prefs = await SharedPreferences.getInstance();
      final today = getdateKey();

      int? savedInitial = prefs.getInt('initial_$today');

      if (savedInitial == null) {
        savedInitial = event.steps;

        await prefs.setInt('initial_$today', savedInitial);
      }

      totalSensorSteps = event.steps;
      initialSteps = savedInitial;
      todaySteps = (totalSensorSteps - initialSteps).clamp(0, 9999999);

      CalculateMetrics();
      Refresh();
    }, onError: (e) => debugPrint("Step Strem Error $e"));
  }

  Future<void> StartStatusListner({required VoidCallback Refresh}) async {
    await statusSubscription?.cancel();

    statusSubscription = Pedometer.pedestrianStatusStream.listen(
      (PedestrianStatus event) {
        status = event.status;

        isWalking = event.status.toLowerCase() == 'walking';
        Refresh();
      },
      onError: (e) {
        debugPrint("Status Error: $e");
        status = "Unavailable";
        isWalking = false;
        Refresh();
      },
    );
  }

  Future<void> LoadTodaySteps() async {
    final prefs = await SharedPreferences.getInstance();

    todaySteps = prefs.getInt('Steps_${getdateKey()}') ?? 0;

    CalculateMetrics();
  }

  Future<void> LoadWeeklyData() async {
    final prefs = await SharedPreferences.getInstance();
    weeklyData.clear();

    for (int i = 6; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));

      final datekey = DateFormat('yyyy-MM-dd').format(date);
      final isToday = i == 0;

      weeklyData.add({
        'day': DateFormat('E').format(date),
        'steps': isToday ? todaySteps : (prefs.getInt('steps_$datekey') ?? 0),
        'isToday' : isToday
      });
    }
  }

  void CalculateMetrics() {
    calories = todaySteps * 0.04;
    distance = (todaySteps * 0.762) / 1000;
  }

  double get Progress =>
      daily_Goal == 0 ? 0 : (todaySteps / daily_Goal).clamp(0.0, 1.0);

  Future<void> SetGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    daily_Goal = goal;
    await prefs.setInt('dailyGoal', goal);
  }

  Future<void> LoadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    daily_Goal = prefs.getInt('dailyGoal') ?? 10000;
  }

  void dispose() {
    stepSubscription?.cancel();
    statusSubscription?.cancel();
  }
}
