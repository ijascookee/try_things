import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DismissibleAnimationList extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => 'Item ${index + 1}');

  DismissibleAnimationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slidable Demo'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: const ValueKey(0),

            endActionPane: ActionPane(
              motion: ScrollMotion(),
              dismissible: DismissiblePane(
                  confirmDismiss: () async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Deletion'),
                          content: Text('Are you sure you want to delete this item?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Dismiss the dialog
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                removeItem(index);
                                // Dismiss the dialog with a result
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: () {}),
              children: [
                SlidableAction(
                  onPressed: (delete) {},
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            //  dismissi: SlidableDismissal(
            //     onWillDismiss: (actionType) {
            //       return showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             title: Text('Confirm Deletion'),
            //             content: Text('Are you sure you want to delete this item?'),
            //             actions: <Widget>[
            //               TextButton(
            //                 onPressed: () {
            //                   Navigator.of(context).pop(false); // Dismiss the dialog
            //                 },
            //                 child: Text('Cancel'),
            //               ),
            //               TextButton(
            //                 onPressed: () {
            //                   Navigator.of(context).pop(true); // Dismiss the dialog with a result
            //                 },
            //                 child: Text('Delete'),
            //               ),
            //             ],
            //           );
            //         },
            //       );
            //     },
            //   ),
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: ListTile(
                tileColor: Colors.yellow,
                title: Text(items[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  void removeItem(int index) {
    items.removeAt(index);
  }
}
