import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Screens/bottombar_screen/addhabit_screen.dart';
import 'package:habittracker/Screens/bottombar_screen/home_screen.dart';
import 'package:habittracker/Screens/bottombar_screen/notification.dart';
import 'package:habittracker/Screens/bottombar_screen/profile_screen.dart';
import 'package:habittracker/Screens/bottombar_screen/progress_screen.dart';
import 'package:intl/intl.dart';
import '../Static Data/text_styles.dart';
import '../Widgets/dynamicsize.dart';
import '../services/task_service.dart';

class HomeProvider with ChangeNotifier {
  final TaskService _taskService = TaskService();

  List bottomData = [
    {"title": "Home", "Icon": "assets/icons/home.svg", "filledIcon": "assets/icons/homefill.svg", "page": const HomeScreen()},
    {"title": "Progress", "Icon": "assets/icons/progress.svg", "filledIcon": "assets/icons/progressfill.svg", "page": const ProgressScreen()},
    {"title": "add", "Icon": "assets/icons/add.svg", "filledIcon": "assets/icons/add.svg", "page": const AddHabitScreen()},
    {"title": "Notification", "Icon": "assets/icons/notification.svg", "filledIcon": "assets/icons/notificationfill.svg", "page": const NotificationScreen()},
    {"title": "Profile", "Icon": "assets/icons/Profile.svg", "filledIcon": "assets/icons/profilefill.svg", "page": const ProfileScreen()},
  ];

  List todayList = []; // Updated to load dynamically

  int currentIndex = 0;
  bool isLoading = false; // New loading state

  updateIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();

  /// Fetch and update today's tasks dynamically
  Future<void> fetchTodayTasks() async {
    isLoading = true;
    notifyListeners(); // Notify that loading has started

    try {
      
      final tasks = await _taskService.getTasks();
      
      print('Tasks: $tasks');

      todayList = tasks.map((task) {
        print("task:"+task.id);
        return {
          "_id": task.id,
          "title": task.title,
          "icon": "assets/temp/default_task_icon.svg", // Default icon for tasks
          "subtitle": task.description,
        };
      }).toList();
    } catch (e) {
      print('Error fetching today\'s tasks: $e');
    }

    isLoading = false;
    notifyListeners(); // Notify that loading has ended
  }

  Widget buildHeader(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat.yMMMM().format(selectedDate).toString(),
          style: TextStyles.heading1.copyWith(fontSize: 19),
        ),
        const Spacer(),
        InkWell(
          onTap: () async {
            selectedDate = (await showDatePicker(context: context, firstDate: DateTime(2005), lastDate: DateTime(2030), initialDate: selectedDate)) ?? DateTime.now();
            notifyListeners();
          },
          child: SvgPicture.asset("assets/icons/Calendar.svg"),
        ),
        sizeWidth(width: 16, context: context),
        InkWell(
          onTap: () {
            selectedDate = selectedDate.subtract(const Duration(days: 7));
            notifyListeners();
          },
          child: SvgPicture.asset("assets/icons/arrow left.svg"),
        ),
        sizeWidth(width: 16, context: context),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            selectedDate = selectedDate.add(const Duration(days: 7));
            notifyListeners();
          },
          child: SvgPicture.asset("assets/icons/arrow right.svg"),
        ),
      ],
    );
  }

  Widget buildDaysOfWeek() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        7,
        (index) => Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
              style: TextStyles.subTitle.copyWith(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCalendarDays() {
    DateTime firstDayOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));

    List<int> dayNumbers = List.generate(
      7,
      (index) => firstDayOfWeek.day + index,
    );

    return GridView.count(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 7,
      childAspectRatio: 1.5,
      children: dayNumbers.map((day) {
        DateTime currentDate = DateTime(firstDayOfWeek.year, firstDayOfWeek.month, day);
        return GestureDetector(
          onTap: () {
            selectedDate = currentDate;
            notifyListeners();
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedDate.day == currentDate.day ? Colors.white : Colors.transparent,
            ),
            child: Text(
              currentDate.day.toString(),
              style: TextStyles.subTitle.copyWith(fontSize: 14, color: selectedDate.day == currentDate.day ? Colors.black : null),
            ),
          ),
        );
      }).toList(),
    );
  }
}
