import 'package:biblio/animations/animate_do.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:biblio/screens/navigation_bar/pages/add_page.dart';
import 'package:biblio/screens/navigation_bar/pages/home_page_screen.dart';
import 'package:biblio/screens/navigation_bar/pages/more_page.dart';
import 'package:biblio/screens/navigation_bar/pages/my_liberary_page.dart';
import 'package:biblio/screens/navigation_bar/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBarApp extends StatefulWidget {
  const NavigationBarApp({
    super.key,
  });
  static String id = 'NavigationBarApp';
  @override
  State<NavigationBarApp> createState() => NavigationBarAppState();
}

class NavigationBarAppState extends State<NavigationBarApp> {
  int _selectedIndex = 0;
//خاص بألوان ال
// NAVIGATION_BAR
  int _currentIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const OrderPage(),
    const AddPage(),
    const MyLiberaryPage(),
    const MorePage(),
  ];
  void _onItemTapped(
    int index,
  ) {
    setState(() {
      _selectedIndex = index;
      _currentIndex = index;
    });
  }

  Future<bool?> showExitConfirmation(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'تأكيد',
              style: TextStyle(
                color: kMainColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'هل تريد الخروج',
              style: TextStyle(
                color: kMainColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(
                  context,
                ).pop(
                  true,
                ),
                child: Text(
                  'نعم',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(
                  false,
                ),
                child: Text(
                  'لا',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false; // Return false if the dialog is dismissed.
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showExitConfirmation(context);
        return shouldExit!;
      },
      child: Scaffold(
        body: pages.elementAt(_selectedIndex),
        bottomNavigationBar: CustomFadeInUp(
          duration: 500,
          child: BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: kMainColor,
            unselectedItemColor: kHeader1Color,
            selectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              color: kHeader1Color,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
            elevation: 50,
            iconSize: 24.sp,
            type: BottomNavigationBarType.fixed,
            items: [
              /// Explore button
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/explore.svg',
                  width: _currentIndex == 0 ? 26.sp : 24.sp,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 0 ? kMainColor : kHeader1Color,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'اكتشف',
              ),

              /// Order button
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/Chat.svg',
                  width: _currentIndex == 1 ? 26.sp : 24.sp,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 1 ? kMainColor : kHeader1Color,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'الطلبات',
              ),

              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 24.sp,
                  backgroundColor: kMainColor,
                  child: SvgPicture.asset(
                    'assets/svg/add.svg',
                    width: 28.sp,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/ph_books.svg',
                  width: _currentIndex == 3 ? 26.sp : 24.sp,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 3 ? kMainColor : kHeader1Color,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'مكتبتي',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/more.svg',
                  width: _currentIndex == 4 ? 26.sp : 24.sp,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 4 ? kMainColor : kHeader1Color,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'المزيد',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
