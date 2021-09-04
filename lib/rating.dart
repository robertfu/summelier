import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:summelier/bloc/rating_bloc.dart';
import 'package:summelier/widgets/rating_stream.dart';
import 'package:summelier/widgets/sliding_widget.dart';

import 'bloc/rating_bloc.dart';

class RatingWidget extends StatefulWidget {
  RatingWidget({Key? key}) : super(key: key);

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  String? newReason;
  late PanelController controller;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    final RatingBloc ratingBloc = Provider.of<RatingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Q/A'),
        actions: [
          StreamBuilder(
              stream: ratingBloc.canSave,
              builder: (_, AsyncSnapshot<bool> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Container();
                }
                bool canSave = false;
                if (!snapshot.hasError && snapshot.hasData) {
                  canSave = snapshot.data!;
                }
                return IconButton(
                    onPressed: canSave
                        ? ratingBloc.save
                        : null,
                    icon: const Icon(Icons.add));
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/shunoko.jpg'),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'How was Shunoco',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'They\'ll get your feedback, along with your name and photo',
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          RatingStream(ratingBloc: ratingBloc, controller: controller),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SlidingWidget(controller: controller, ratingBloc: ratingBloc),
                ),
                StreamBuilder(
                    stream: ratingBloc.panelOpen,
                    builder: (_, AsyncSnapshot<bool> panelOpenSnapshot) {
                      if (panelOpenSnapshot.connectionState == ConnectionState.waiting || panelOpenSnapshot.hasError ||
                          panelOpenSnapshot.data == false) {
                        return Container();
                      }

                      return Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                controller: editingController,
                                decoration: const InputDecoration(
                                    labelText: 'Another favorite'),
                                onSaved: (value) {
                                  newReason = value;
                                },
                                validator: (value) {
                                  final trimmed = value!.trim();
                                  if (trimmed.isEmpty) return 'Required.';
                                },
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  ratingBloc.addQuestion(newReason!);
                                  editingController.clear();
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              icon: const Icon(Icons.add)),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
