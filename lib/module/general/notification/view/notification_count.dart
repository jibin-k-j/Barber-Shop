import 'package:badges/badges.dart' as badges;
import 'package:barber_app/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FireStreamDocument(
      stream: FirebaseFirestore.instance
          .collection(collection.userDataCollection)
          .doc(AppSession.userId)
          .snapshots(
            includeMetadataChanges: true,
          ),
      onSnapshot: (documentSnapshot) {
        var data = documentSnapshot.data() ?? {};
        var unreadNotificationCount = data["unread_notification_count"] ?? 0;

        return badges.Badge(
          badgeContent: Text('$unreadNotificationCount'),
          showBadge: unreadNotificationCount > 0,
          child: Icon(
            Icons.notifications,
          ),
        );
      },
    );
  }
}
