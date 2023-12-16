// import 'package:add_2_calendar/add_2_calendar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_swipe_action_cell/core/cell.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../data/apiClient/studentClasess.dart';

// class AssignmentContainer extends StatefulWidget {
//   const AssignmentContainer({super.key});

//   @override
//   State<AssignmentContainer> createState() => _AssignmentContainerState();
// }

// class _AssignmentContainerState extends State<AssignmentContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return SwipeActionCell(
//       controller: controller,
//       backgroundColor: Colors.transparent,
//       key: ObjectKey('1'),
//       trailingActions: <SwipeAction>[
//         SwipeAction(
//             widthSpace: 60,
//             backgroundRadius: 12,
//             // title: "delete",
//             icon: Icon(Icons.delete),
//             onTap: (CompletionHandler handler) async {
//               StudentClasses.todoData?.remove(assignment);
//               StudentClasses.complete.add(assignment);
//               controller.closeAllOpenCell();
//               setState(
//                 () {},
//               );
//             },
//             color: Colors.red),
//       ],
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(
//           color: Color(0xff242424),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ExpansionTile(
//           collapsedBackgroundColor: Colors.transparent,
//           backgroundColor: Colors.transparent,
//           tilePadding: EdgeInsets.zero,
//           childrenPadding: EdgeInsets.zero,
//           trailing: SizedBox(
//             width: 0,
//             height: 0,
//           ),
//           title: Container(
//             height: 80,
//             margin: EdgeInsets.all(8),
//             padding: EdgeInsets.all(12),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 getIcon(index),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       assignment.assignment.name.length < 27
//                           ? assignment.assignment.name
//                           : '${assignment.assignment.name.substring(0, 26)}...',
//                       overflow: TextOverflow.fade,
//                       maxLines: 1,
//                       softWrap: false,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     getTitle(index),
//                   ],
//                 ),
//                 Spacer(),
//                 Text(
//                   assignment.assignment.pointsPossible.toString(),
//                   style: TextStyle(color: Colors.white),
//                 )
//               ],
//             ),
//           ),
//           children: <Widget>[
//             Container(
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Color(0xff242424),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         height: 33,
//                         width: 138,
//                         decoration: BoxDecoration(
//                             color: Color(0xff171717),
//                             borderRadius: BorderRadius.circular(23)),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 33,
//                               width: 33,
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: Colors.white)),
//                               child: SvgPicture.asset(
//                                 'assets/images/suit_case.svg',
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               '${assignment.assignment.dueAt.year}/${assignment.assignment.dueAt.month}/${assignment.assignment.dueAt.day} ${assignment.assignment.dueAt.toString().substring(10, 16)}',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         height: 33,
//                         width: 138,
//                         decoration: BoxDecoration(
//                             color: Color(0xff171717),
//                             borderRadius: BorderRadius.circular(23)),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 33,
//                               width: 33,
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: Colors.white)),
//                               child: SvgPicture.asset(
//                                 'assets/images/lock.svg',
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               assignment.assignment.lockAt == null
//                                   ? 'Empty '
//                                   : '${assignment.assignment.lockAt!.year}/${assignment.assignment.lockAt!.month}/${assignment.assignment.lockAt!.day} ${assignment.assignment.lockAt.toString().substring(10, 16)}',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         height: 33,
//                         width: 128,
//                         decoration: BoxDecoration(
//                             color: Color(0xff171717),
//                             borderRadius: BorderRadius.circular(23)),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 33,
//                               width: 33,
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: Colors.white)),
//                               child: SvgPicture.asset(
//                                 'assets/images/order.svg',
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               '5.6% Boost',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Fluttertoast.showToast(
//                                   msg: 'Boost up', // message
//                                   toastLength: Toast.LENGTH_SHORT, // length
//                                   gravity: ToastGravity.CENTER,
//                                   // location
//                                 );
//                               },
//                               child: Icon(Icons.info,
//                                   color: Colors.white, size: 18),
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         height: 33,
//                         width: 128,
//                         decoration: BoxDecoration(
//                             color: Color(0xff171717),
//                             borderRadius: BorderRadius.circular(23)),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 33,
//                               width: 33,
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: Colors.white)),
//                               child: SvgPicture.asset(
//                                 'assets/images/bell.svg',
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               'In 3 Hours?',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             GestureDetector(
//                               onTap: () async {
//                                 final Event event = Event(
//                                   title: 'Event title',
//                                   description: 'Event description',
//                                   location: 'Event location',
//                                   startDate: DateTime.now(),
//                                   endDate:
//                                       DateTime.now().add(Duration(hours: 3)),
//                                   iosParams: IOSParams(
//                                     reminder: Duration(
//                                         /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
//                                   ),
//                                   androidParams: AndroidParams(
//                                     emailInvites: [], // on Android, you can add invite emails to your event.
//                                   ),
//                                 );

//                                 var isSet =
//                                     await Add2Calendar.addEvent2Cal(event);
//                                 debugPrint('is set $isSet');
//                                 Fluttertoast.showToast(
//                                   msg: '3 hours remaining', // message
//                                   toastLength: Toast.LENGTH_SHORT, // length
//                                   gravity: ToastGravity.CENTER,
//                                   // location
//                                 );
//                               },
//                               child: Icon(Icons.info,
//                                   color: Colors.white, size: 18),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
