import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/firebase_cloud_storage.dart';
import 'package:mynotes/utilities/dialogs/logout_dialog.dart';
import 'package:mynotes/views/notes/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;
  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Ghi chú của bạn'), actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  context.read<AuthBloc>().add(
                    const AuthEventLogOut(),
                  );
                }
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text('Đăng xuất'),
              ),
            ];
          })
        ]),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: _notesService.allNotes(ownerUserId: userId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allNotes = snapshot.data as Iterable<CloudNote>;
                    return NotesListView(
                      notes: allNotes,
                      onDeleteNote: (note) async {
                        await _notesService.deleteNote(documentId: note.documentId);
                      },
                      onTap: (note) {
                        Navigator.of(context).pushNamed(
                          createOrUpdateNoteRoute,
                          arguments: note,
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                default:
                  return const CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}
