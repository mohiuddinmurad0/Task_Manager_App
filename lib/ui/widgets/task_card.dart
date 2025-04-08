// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


class CustomTaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String createdDate;
  final String status;
  final Color chipColor;
  final VoidCallback onChangeStatusPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const CustomTaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.status,
    required this.chipColor,
    required this.onChangeStatusPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            Text(createdDate),
            Row(
              children: [
                Chip(
                  label: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: chipColor,
                ),
                const Spacer(),
                IconButton(
                    onPressed: onChangeStatusPressed,
                    icon: Icon(
                      Icons.published_with_changes_outlined,
                      color: Colors.purple.shade300,
                    )),
                IconButton(
                  onPressed: onEditPressed,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: onDeletePressed,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
