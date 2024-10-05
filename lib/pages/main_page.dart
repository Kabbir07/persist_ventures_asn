// import 'package:flutter/material.dart';
// import 'package:persist_ventures_asn/pages/create_post_page.dart';
// import 'package:persist_ventures_asn/pages/profile_details_page.dart';

// import '../shared/colors.dart';
// import 'home_page.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0; // Track the selected tab

//   // List of pages for each tab
//   final List<Widget> _pages = <Widget>[
//     const HomePage(),
//     const Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
//     const CreatePostPage(),
//     const Center(child: Text('Chat Page', style: TextStyle(fontSize: 24))),
//     const ProfileDetailsPage()
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // Update the selected index
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Image.asset(
//           "assets/images/lg.png",
//           width: 200,
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.notifications_outlined,
//               size: 28,
//             ),
//             onPressed: () {},
//           ),
//           const SizedBox(
//             width: 5,
//           ),
//           Image.asset(
//             "assets/images/badge.png",
//             width: 28,
//           ),
//           const SizedBox(
//             width: 15,
//           ),
//         ],
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.white,
//         selectedItemColor: deeporrange,
//         unselectedItemColor: grey500,
//         showUnselectedLabels: false,
//         showSelectedLabels: false,
//         selectedIconTheme: IconThemeData(color: deeporrange),
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               "assets/icons/home-button.png",
//               height: 22,
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               "assets/icons/search.png",
//               height: 22,
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               "assets/icons/add.png",
//               height: 22,
//             ),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               "assets/icons/chat.png",
//               height: 22,
//             ),
//             label: '',
//           ),
//           const BottomNavigationBarItem(
//             icon: CircleAvatar(
//               radius: 15,
//               backgroundImage: NetworkImage(
//                   "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
//             ),
//             label: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
