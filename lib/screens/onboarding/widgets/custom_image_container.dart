import 'package:dating_app/bloc/onboarding/onboarding_bloc.dart';
import 'package:dating_app/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageContainer extends StatelessWidget {
  final TabController tabController;
  final String? imageUrl;

  const CustomImageContainer({
    Key? key,
    required this.tabController,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border(
              bottom: BorderSide(color: Colors.orange[900]!, width: 1),
              top: BorderSide(color: Colors.orange[900]!, width: 1),
              left: BorderSide(color: Colors.orange[900]!, width: 1),
              right: BorderSide(color: Colors.orange[900]!, width: 1),
            )),
        child: (imageUrl == null)
            ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () async {
                    ImagePicker _picker = ImagePicker();
                    final XFile? _image =
                        await _picker.pickImage(source: ImageSource.gallery);

                    if (_image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('No image was selected.'),
                      ));
                    }

                    if (_image != null) {
                      print('Uploading...');
                      context
                          .read<OnboardingBloc>()
                          .add(UpdateUserImages(image: _image));
                    }
                  },
                ),
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
