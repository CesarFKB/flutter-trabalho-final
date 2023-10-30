import 'package:flutter/material.dart';
import 'package:trabalho_final/widgets/custom_icon_button.dart';

// class TaskContainer extends StatelessWidget {
//   final String name;
//   bool isDisabled;
//   TaskContainer({Key? key, required this.name, this.isDisabled = false})
//       : super(key: key);

//   set setDisabled(bool value) {
//     isDisabled = value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.4),
//             blurRadius: 5,
//             offset: const Offset(3, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   'Teste Inline',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//           CustomIconButton(
//               isDisabled: isDisabled,
//               icon: Icons.done,
//               funcao: () {
//                 print('done');
//               }),
//           const SizedBox(width: 16.0),
//           CustomIconButton(
//               isDisabled: isDisabled, icon: Icons.delete, funcao: () {}),
//         ]
//       ),
//     );
//   }
// }

class TaskContainer extends StatefulWidget {
  bool isDisabled;
  final String name;
  TaskContainer({super.key, required this.name, this.isDisabled = false});

  set setDisabled(bool value) {
    isDisabled = value;
  }

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 5,
            offset: const Offset(3, 5),
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.0),
              Text(
                'Teste Inline',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        CustomIconButton(
            isDisabled: widget.isDisabled,
            icon: Icons.done,
            funcao: () {
              print('done');
            }),
        const SizedBox(width: 16.0),
        CustomIconButton(
            isDisabled: widget.isDisabled, icon: Icons.delete, funcao: () {}),
      ]),
    );
  }
}
