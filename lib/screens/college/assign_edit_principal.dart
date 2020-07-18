import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/components/card/card.dart';
import 'package:ums_flutter/components/card/rectangle_card/single_item_card.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/components/dialog/button_dialog.dart';
import 'package:ums_flutter/components/header/page_header.dart';
import 'package:ums_flutter/components/input/text_form_field_validation.dart';
import 'package:ums_flutter/components/progress_bar/custom_circular_progress.dart';
import 'package:ums_flutter/models/response/college_response.dart';
import 'package:ums_flutter/components/drawer/side_drawer.dart';
import 'package:ums_flutter/utils/utils.dart';

class AssignEditPrincipalScreen extends StatefulWidget {
  final SideDrawer sideDrawer;
  final CollegeResponse collegeResponse;
  final bool isEditing;

  AssignEditPrincipalScreen(
      {Key key,
      @required this.sideDrawer,
      @required this.collegeResponse,
      this.isEditing = false})
      : assert(collegeResponse != null),
        assert(sideDrawer != null),
        super(key: key);

  @override
  _AssignEditPrincipalScreenState createState() =>
      _AssignEditPrincipalScreenState();
}

class _AssignEditPrincipalScreenState extends State<AssignEditPrincipalScreen> {
  String _username;

  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      bottomNavigationBar: CustomBottomNavigationBar(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.cancel,
          color: Colors.red,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SIDE_MARGIN),
                ),
                padding: EdgeInsets.only(
                    left: SIDE_MARGIN, right: SIDE_MARGIN, bottom: SIDE_MARGIN),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PageHeader(
                      line1: isEditing ? "Edit" : "Assign",
                      line2: "Principal",
                      marginTop: 40,
                      marginBottom: 20,
                    ),
                    isEditing
                        ? OneColumnCard(
                            header: widget.collegeResponse.principal.username,
                            label:
                                "${widget.collegeResponse.principal.firstName} ${widget.collegeResponse.principal.lastName} ")
                        : Container(
                            width: 0,
                            height: 0,
                          ),
                    Form(
                      autovalidate: _autoValidate,
                      key: formKey,
                      child: TextFormFieldValidation(
                        initialValue: isEditing
                            ? widget.collegeResponse.principal.username
                            : "",
                        autofocus: isEditing,
                        prefixIcon: Icons.person_outline,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search,
                                color: const Color(0xfff96800)),
                            onPressed: () {
                              _onSubmit(context, _username);
                            }),
                        label: "Employee Username",
                        onValueChanged: (val) {
                          _username = val.trim();
                        },
                        isLastEntry: true,
                        validator: (String value) {
                          return value.length < 3
                              ? 'Minimum Length Should be 3'
                              : null;
                        },
                        onFieldSubmit: (val) {
                          _onSubmit(context, val);
                        },
                      ),
                    ),
                    BlocConsumer<PrincipalBloc, PrincipalState>(
                      listener: (BuildContext context, state) {
                        if (state is PrincipalAssignSuccess) {
                          BlocProvider.of<CollegesBloc>(context).add(
                              CollegeUpdatePrincipal(
                                  principalAssignResponse:
                                      state.principalAssignResponse));
                          customButtonDialog(
                            context: context,
                            header: "Principal Assigned",
                            data:
                                "New Principal ($_username) has been assigned to college ${widget.collegeResponse.code}\n(${widget.collegeResponse.name})",
                            onPressed: () {
                              var nav = Navigator.of(context);
                              nav.pop();
                              nav.pop();
                            },
                          );
                        } else if (state is PrincipalError) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${state.error}'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      builder: (BuildContext context, state) {
                        if (state is InitialPrincipalState) {
                          return Text("Search to get results");
                        } else if (state is PrincipalLoadInProgress) {
                          return CustomCircularProgress(label: "Searching");
                        } else if (state is PrincipalQueryLoadSuccess) {
                          final items = state.usernamesResponse.usernames;
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return SingleItemCard(
                                  label: item.username,
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    _username = item.username;
                                    BlocProvider.of<PrincipalBloc>(context)
                                        .add(AssignNewPrincipal(
                                      collegeId: widget.collegeResponse.id,
                                      instructorId: item.id,
                                    ));
                                  },
                                );
                              });
                        } else {
                          return Container(
                            width: 0,
                            height: 0,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit(BuildContext context, String val) {
    if (formKey.currentState.validate()) {
      BlocProvider.of<PrincipalBloc>(context)
          .add(PrincipalSearchQuery(key: val));
    } else {
      _autoValidate = true;
    }
  }
}
