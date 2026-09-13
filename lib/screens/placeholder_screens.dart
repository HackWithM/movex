import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movex/core/constants/app_constants.dart';
import 'package:movex/core/theme/app_theme.dart';

class PropertySearchScreen extends StatelessWidget {
  const PropertySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PlaceholderScreen(
      title: 'Property Search',
      icon: Icons.search_rounded,
      gradientColors: [AppColors.primary, AppColors.primaryMid],
      message: 'Advanced property search with filters\ncoming soon.',
    );
  }
}

class PostPropertyScreen extends StatefulWidget {
  const PostPropertyScreen({super.key});

  @override
  State<PostPropertyScreen> createState() => _PostPropertyScreenState();
}

class _PostPropertyScreenState extends State<PostPropertyScreen> {
  final PropertyListingDraft _draft = PropertyListingDraft();
  int _currentStep = 0;
  bool _showValidation = false;
  final Map<String, String> _errors = {};
  final ImagePicker _picker = ImagePicker();

  bool get _isSubmitted => _draft.isSubmitted;

  bool _isStepValid() {
    _errors.clear();

    switch (_currentStep) {
      case 0:
        _validateStepOne();
        break;
      case 1:
        _validateStepTwo();
        break;
      case 2:
        _validateStepThree();
        break;
      case 3:
        _validateStepFour();
        break;
      case 4:
        _validateStepFive();
        break;
      default:
        break;
    }

    return _errors.isEmpty;
  }

  void _validateStepOne() {
    final ownerName = _draft.ownerName.trim();
    final phone = _draft.phone.trim();
    final email = _draft.email.trim();

    if (ownerName.isEmpty) {
      _errors['ownerName'] = 'Please enter your name';
    }
    if (phone.isEmpty || !_validPhone(phone)) {
      _errors['phone'] = 'Please enter a valid mobile number';
    }
    if (email.isNotEmpty && !_validEmail(email)) {
      _errors['email'] = 'Please enter a valid email address';
    }
    if (_draft.propertyType == null) {
      _errors['propertyType'] = 'Please select a property type';
    }
  }

  void _validateStepTwo() {
    if (_draft.city.trim().isEmpty) {
      _errors['city'] = 'Please add your city';
    }
    if (_draft.locality.trim().isEmpty) {
      _errors['locality'] = 'Please add your locality';
    }
    if (_draft.society.trim().isEmpty) {
      _errors['society'] = 'Please add your society or building name';
    }
    if (_draft.exactAddress.trim().isEmpty) {
      _errors['exactAddress'] = 'Please add your exact address';
    }
  }

  void _validateStepThree() {
    final type = _draft.propertyType;

    if (type == null) {
      _errors['propertyType'] = 'Please select a property type';
      return;
    }

    switch (type) {
      case PropertyType.flat:
        if (_draft.bhk.trim().isEmpty) {
          _errors['bhk'] = 'Please select BHK';
        }
        if (_draft.area.trim().isEmpty) {
          _errors['area'] = 'Please add area';
        }
        if (_draft.floor.trim().isEmpty) {
          _errors['floor'] = 'Please add floor';
        }
        if (_draft.totalFloors.trim().isEmpty) {
          _errors['totalFloors'] = 'Please add total floors';
        }
        if (_draft.bathrooms.trim().isEmpty) {
          _errors['bathrooms'] = 'Please add bathrooms';
        }
        if (_draft.balconies.trim().isEmpty) {
          _errors['balconies'] = 'Please add balconies';
        }
        if (_draft.furnishing.trim().isEmpty) {
          _errors['furnishing'] = 'Please select furnishing';
        }
        if (_draft.parkingAvailable.trim().isEmpty) {
          _errors['parkingAvailable'] = 'Please select parking availability';
        }
        if (_draft.parkingAvailable == 'yes' && _draft.parkingType.trim().isEmpty) {
          _errors['parkingType'] = 'Please select parking type';
        }
        break;

      case PropertyType.rk:
        if (_draft.area.trim().isEmpty) {
          _errors['area'] = 'Please add area';
        }
        if (_draft.floor.trim().isEmpty) {
          _errors['floor'] = 'Please add floor';
        }
        if (_draft.totalFloors.trim().isEmpty) {
          _errors['totalFloors'] = 'Please add total floors';
        }
        if (_draft.bathrooms.trim().isEmpty) {
          _errors['bathrooms'] = 'Please add bathrooms';
        }
        if (_draft.balconies.trim().isEmpty) {
          _errors['balconies'] = 'Please add balconies';
        }
        if (_draft.furnishing.trim().isEmpty) {
          _errors['furnishing'] = 'Please select furnishing';
        }
        if (_draft.parkingAvailable.trim().isEmpty) {
          _errors['parkingAvailable'] = 'Please select parking availability';
        }
        if (_draft.parkingAvailable == 'yes' && _draft.parkingType.trim().isEmpty) {
          _errors['parkingType'] = 'Please select parking type';
        }
        break;

      case PropertyType.room:
        if (_draft.roomType.trim().isEmpty) {
          _errors['roomType'] = 'Please select room type';
        }
        if (_draft.area.trim().isEmpty) {
          _errors['area'] = 'Please add area';
        }
        if (_draft.bathroomType.trim().isEmpty) {
          _errors['bathroomType'] = 'Please select bathroom type';
        }
        if (_draft.floor.trim().isEmpty) {
          _errors['floor'] = 'Please add floor';
        }
        if (_draft.furnishing.trim().isEmpty) {
          _errors['furnishing'] = 'Please select furnishing';
        }
        if (_draft.bathroomType == 'common' && _draft.bathroomSharingPeople.trim().isEmpty) {
          _errors['bathroomSharingPeople'] = 'Please add approximate sharing count';
        }
        break;

      case PropertyType.pg:
        if (_draft.sharingType.trim().isEmpty) {
          _errors['sharingType'] = 'Please select sharing type';
        }
        if (_draft.availableBeds.trim().isEmpty) {
          _errors['availableBeds'] = 'Please add available beds';
        }
        if (_draft.suitableFor.trim().isEmpty) {
          _errors['suitableFor'] = 'Please select suitable tenant type';
        }
        if (_draft.bathroomType.trim().isEmpty) {
          _errors['bathroomType'] = 'Please select bathroom type';
        }
        if (_draft.furnishing.trim().isEmpty) {
          _errors['furnishing'] = 'Please select furnishing';
        }
        if (_draft.foodAvailable.trim().isEmpty) {
          _errors['foodAvailable'] = 'Please select food availability';
        }
        if (_draft.foodAvailable == 'yes') {
          if (_draft.meals.isEmpty) {
            _errors['meals'] = 'Please select meals available';
          }
          if (_draft.foodIncluded.trim().isEmpty) {
            _errors['foodIncluded'] = 'Please select if food is included';
          }
          if (_draft.foodIncluded == 'no' && _draft.foodCharges.trim().isEmpty) {
            _errors['foodCharges'] = 'Please add monthly food charges';
          }
        }
        if (_draft.acAvailable.trim().isEmpty) {
          _errors['acAvailable'] = 'Please select AC availability';
        }
        if (_draft.parkingAvailable.trim().isEmpty) {
          _errors['parkingAvailable'] = 'Please select parking availability';
        }
        if (_draft.parkingAvailable == 'yes' && _draft.parkingType.trim().isEmpty) {
          _errors['parkingType'] = 'Please select parking type';
        }
        break;

      case PropertyType.sharedRoom:
        if (_draft.sharingType.trim().isEmpty) {
          _errors['sharingType'] = 'Please select sharing capacity';
        }
        if (_draft.availableBeds.trim().isEmpty) {
          _errors['availableBeds'] = 'Please add available beds';
        }
        if (_draft.bathroomType.trim().isEmpty) {
          _errors['bathroomType'] = 'Please select bathroom type';
        }
        if (_draft.furnishing.trim().isEmpty) {
          _errors['furnishing'] = 'Please select furnishing';
        }
        if (_draft.parkingAvailable.trim().isEmpty) {
          _errors['parkingAvailable'] = 'Please select parking availability';
        }
        if (_draft.parkingAvailable == 'yes' && _draft.parkingType.trim().isEmpty) {
          _errors['parkingType'] = 'Please select parking type';
        }
        break;
    }
  }

  void _validateStepFour() {
    if (_draft.rent.trim().isEmpty || int.tryParse(_draft.rent) == null) {
      _errors['rent'] = 'Please enter monthly rent';
    }
    if (_draft.deposit.trim().isEmpty || int.tryParse(_draft.deposit) == null) {
      _errors['deposit'] = 'Please enter security deposit';
    }
    if (_draft.maintenanceOption == 'extra' &&
        (_draft.maintenance.trim().isEmpty || int.tryParse(_draft.maintenance) == null)) {
      _errors['maintenance'] = 'Please enter monthly maintenance';
    }
    if (_draft.electricityChargesOption == 'extra' &&
        (_draft.electricityCharges.trim().isEmpty || int.tryParse(_draft.electricityCharges) == null)) {
      _errors['electricityCharges'] = 'Please enter monthly electricity charges';
    }
    if (_draft.propertyAvailableOption == 'availableFrom' && _draft.availableFrom == null) {
      _errors['availableFrom'] = 'Please select the availability date';
    }
    if (_draft.photos.length < 3) {
      _errors['photos'] = 'Please add at least 3 property photos';
    }
  }

  void _validateStepFive() {
    if (_draft.description.trim().isEmpty) {
      _errors['description'] = 'Please add a property description';
    }
  }

  void _continue() {
    setState(() => _showValidation = true);

    if (!_isStepValid()) {
      return;
    }

    if (_currentStep == 4) {
      setState(() {
        _draft.isSubmitted = true;
        _showValidation = false;
        _errors.clear();
      });
      return;
    }

    setState(() {
      _currentStep += 1;
      _showValidation = false;
      _errors.clear();
    });
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
        _showValidation = false;
        _errors.clear();
      });
      return;
    }

    Navigator.of(context).pop();
  }

  Future<void> _addPhotos() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 26),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(height: 18),
                ListTile(
                  leading: const Icon(Icons.camera_alt_rounded, color: AppColors.primary),
                  title: const Text('Take Photo'),
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_rounded, color: AppColors.primary),
                  title: const Text('Choose from Gallery'),
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                  title: const Text('Cancel'),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null) return;

    await _addPhotosFromSource(source);
  }

  Future<void> _addPhotosFromSource(ImageSource source) async {
    try {
      List<XFile> files;

      if (source == ImageSource.gallery) {
        files = await _picker.pickMultiImage(imageQuality: 85);
      } else {
        final pickedFile = await _picker.pickImage(source: source, imageQuality: 85);
        files = pickedFile == null ? [] : [pickedFile];
      }

      if (files.isEmpty) return;

      setState(() {
        final remainingSlots = 10 - _draft.photos.length;
        final newPhotos = files
            .take(remainingSlots)
            .map((image) => PhotoItem(path: image.path, isRemote: false))
            .toList();

        _draft.photos.addAll(newPhotos);
        if (_draft.photos.isNotEmpty && _draft.coverPhotoIndex == -1) {
          _draft.coverPhotoIndex = 0;
        }
      });
    } catch (_) {}
  }

  void _deletePhoto(int index) {
    setState(() {
      _draft.photos.removeAt(index);
      if (_draft.coverPhotoIndex >= _draft.photos.length) {
        _draft.coverPhotoIndex = _draft.photos.isEmpty ? -1 : 0;
      }
    });
  }

  void _movePhoto(int index, {required bool up}) {
    if (up && index == 0) return;
    if (!up && index == _draft.photos.length - 1) return;

    setState(() {
      final item = _draft.photos.removeAt(index);
      final targetIndex = up ? index - 1 : index + 1;
      _draft.photos.insert(targetIndex, item);

      if (_draft.coverPhotoIndex == index) {
        _draft.coverPhotoIndex = targetIndex;
      } else if (up && _draft.coverPhotoIndex == targetIndex) {
        _draft.coverPhotoIndex = index;
      } else if (!up && _draft.coverPhotoIndex == targetIndex) {
        _draft.coverPhotoIndex = index;
      }
    });
  }

  void _setCoverPhoto(int index) {
    setState(() => _draft.coverPhotoIndex = index);
  }

  void _togglePreference(String value) {
    setState(() {
      if (_draft.preferredTenant.contains(value)) {
        _draft.preferredTenant.remove(value);
      } else {
        _draft.preferredTenant.add(value);
      }
    });
  }

  void _toggleRule(String value) {
    setState(() {
      if (_draft.propertyRules.contains(value)) {
        _draft.propertyRules.remove(value);
      } else {
        _draft.propertyRules.add(value);
      }
    });
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );

    if (picked != null) {
      setState(() => _draft.availableFrom = picked);
    }
  }

  Widget _buildTextField({
    required String initialValue,
    required String hint,
    String? errorText,
    TextInputType? keyboardType,
    int maxLines = 1,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textInputAction: maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
      ),
    );
  }

  Widget _buildProgressBar() {
    return SizedBox(
      width: 168,
      child: Row(
        children: List.generate(5, (index) {
          final isActive = index == _currentStep;
          final isComplete = index < _currentStep;
          final showLine = index < 4;

          return Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive || isComplete ? AppColors.primary : AppColors.divider,
                    border: Border.all(
                      color: isActive || isComplete ? AppColors.primary : AppColors.textHint,
                      width: 1.2,
                    ),
                  ),
                ),
                if (showLine)
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: isComplete ? AppColors.primary : AppColors.divider,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildOwnerAndTypeStep() {
    return _StepBody(
      title: "Let's get started 👋",
      subtitle: 'Tell us a little about you and your property.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel('Owner Details'),
          const SizedBox(height: 12),
          _FieldLabel('Full Name'),
          _buildTextField(
            initialValue: _draft.ownerName,
            hint: 'Enter your full name',
            errorText: _showValidation ? _errors['ownerName'] : null,
            onChanged: (value) => setState(() => _draft.ownerName = value),
          ),
          const SizedBox(height: 16),
          _FieldLabel('Mobile Number'),
          _buildTextField(
            initialValue: _draft.phone,
            hint: 'Enter your mobile number',
            keyboardType: TextInputType.phone,
            errorText: _showValidation ? _errors['phone'] : null,
            onChanged: (value) => setState(() => _draft.phone = value),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _FieldLabel('Email Address'),
              const Spacer(),
              const Text(
                'Optional',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          _buildTextField(
            initialValue: _draft.email,
            hint: 'Enter your email address',
            keyboardType: TextInputType.emailAddress,
            errorText: _showValidation ? _errors['email'] : null,
            onChanged: (value) => setState(() => _draft.email = value),
          ),
          const SizedBox(height: 26),
          _SectionLabel('What are you listing?'),
          if (_showValidation && _errors['propertyType'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _errors['propertyType']!,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.accent,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: PropertyType.values.map((type) {
              final selected = _draft.propertyType == type;

              return GestureDetector(
                onTap: () => setState(() => _draft.propertyType = type),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  width: (MediaQuery.of(context).size.width - 70) / 2,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.cardBg,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: selected ? AppColors.primary : AppColors.divider,
                      width: selected ? 1.4 : 1,
                    ),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(22),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Text(type.icon, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          type.label,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStep() {
    return _StepBody(
      title: 'Where is your property? 📍',
      subtitle:
          'Add your property location. Your exact address will stay private until a user unlocks this property.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel('City'),
          _buildTextField(
            initialValue: _draft.city,
            hint: 'Pune',
            errorText: _showValidation ? _errors['city'] : null,
            onChanged: (value) => setState(() => _draft.city = value),
          ),
          const SizedBox(height: 16),
          _FieldLabel('Locality / Area'),
          _buildTextField(
            initialValue: _draft.locality,
            hint: 'Wakad',
            errorText: _showValidation ? _errors['locality'] : null,
            onChanged: (value) => setState(() => _draft.locality = value),
          ),
          const SizedBox(height: 16),
          _FieldLabel('Society / Building Name'),
          _buildTextField(
            initialValue: _draft.society,
            hint: 'ABC Residency',
            errorText: _showValidation ? _errors['society'] : null,
            onChanged: (value) => setState(() => _draft.society = value),
          ),
          const SizedBox(height: 16),
          _FieldLabel('Exact Address'),
          _buildTextField(
            initialValue: _draft.exactAddress,
            hint: 'Flat No. 204, ABC Residency...',
            maxLines: 4,
            errorText: _showValidation ? _errors['exactAddress'] : null,
            onChanged: (value) => setState(() => _draft.exactAddress = value),
          ),
          const SizedBox(height: 20),
          _FieldLabel('Map Location'),
          const SizedBox(height: 8),
          InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () {
              setState(() {
                _draft.latitude = 18.5204;
                _draft.longitude = 73.8567;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.unlockStart, AppColors.unlockEnd],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Icon(Icons.location_on_rounded, color: Colors.white, size: 26),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _draft.latitude != 0 && _draft.longitude != 0
                              ? 'Property location selected'
                              : 'Tap to select map location',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _draft.latitude != 0 && _draft.longitude != 0
                              ? 'Latitude: ${_draft.latitude.toStringAsFixed(4)} • Longitude: ${_draft.longitude.toStringAsFixed(4)}'
                              : 'Your exact location stays private from users.',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.sectionBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_rounded, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '🔒 Your exact location will not be shown publicly.',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetailsStep() {
    final type = _draft.propertyType;
    final showFlatDetails = type == PropertyType.flat;
    final showRkDetails = type == PropertyType.rk;
    final showRoomDetails = type == PropertyType.room;
    final showPgDetails = type == PropertyType.pg;
    final showSharedRoomDetails = type == PropertyType.sharedRoom;

    return _StepBody(
      title: 'Tell us about your property',
      subtitle: 'Add details that actually match the kind of property you are listing.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showFlatDetails || showRkDetails) ...[
            if (showFlatDetails) ...[
              _SectionLabel('BHK'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ['1 BHK', '2 BHK', '3 BHK', '4+ BHK']
                    .map(
                      (option) => ChoiceChip(
                        label: Text(option),
                        selected: _draft.bhk == option,
                        selectedColor: AppColors.primary,
                        labelStyle: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: _draft.bhk == option ? Colors.white : AppColors.textPrimary,
                        ),
                        onSelected: (_) => setState(() => _draft.bhk = option),
                      ),
                    )
                    .toList(),
              ),
              if (_showValidation && _errors['bhk'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errors['bhk']!,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
            ],
            _FieldLabel('Area'),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    initialValue: _draft.area,
                    hint: showFlatDetails ? '750' : '450',
                    keyboardType: TextInputType.number,
                    errorText: _showValidation ? _errors['area'] : null,
                    onChanged: (value) => setState(() => _draft.area = value),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Wrap(
                    spacing: 6,
                    children: ['sq.ft', 'sq.m']
                        .map(
                          (unit) => ChoiceChip(
                            label: Text(unit),
                            selected: _draft.areaUnit == unit,
                            selectedColor: AppColors.primary,
                            labelStyle: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              color: _draft.areaUnit == unit ? Colors.white : AppColors.textPrimary,
                            ),
                            onSelected: (_) => setState(() => _draft.areaUnit = unit),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel('Floor'),
                      _buildTextField(
                        initialValue: _draft.floor,
                        hint: '5',
                        keyboardType: TextInputType.number,
                        errorText: _showValidation ? _errors['floor'] : null,
                        onChanged: (value) => setState(() => _draft.floor = value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel('Total Floors'),
                      _buildTextField(
                        initialValue: _draft.totalFloors,
                        hint: '12',
                        keyboardType: TextInputType.number,
                        errorText: _showValidation ? _errors['totalFloors'] : null,
                        onChanged: (value) => setState(() => _draft.totalFloors = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel('Bathrooms'),
                      _buildTextField(
                        initialValue: _draft.bathrooms,
                        hint: '2',
                        keyboardType: TextInputType.number,
                        errorText: _showValidation ? _errors['bathrooms'] : null,
                        onChanged: (value) => setState(() => _draft.bathrooms = value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel('Balcony'),
                      _buildTextField(
                        initialValue: _draft.balconies,
                        hint: '1',
                        keyboardType: TextInputType.number,
                        errorText: _showValidation ? _errors['balconies'] : null,
                        onChanged: (value) => setState(() => _draft.balconies = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
          ],

          if (showRoomDetails || showPgDetails || showSharedRoomDetails) ...[
            if (showRoomDetails) ...[
              _SectionLabel('Room Type'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ['Private Room', 'Shared Room']
                    .map(
                      (option) => ChoiceChip(
                        label: Text(option),
                        selected: _draft.roomType == option,
                        selectedColor: AppColors.primary,
                        labelStyle: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: _draft.roomType == option ? Colors.white : AppColors.textPrimary,
                        ),
                        onSelected: (_) => setState(() => _draft.roomType = option),
                      ),
                    )
                    .toList(),
              ),
              if (_showValidation && _errors['roomType'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errors['roomType']!,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
            ],
            if (showPgDetails || showSharedRoomDetails) ...[
              _SectionLabel(showPgDetails ? 'Sharing Type' : 'Sharing Capacity'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: (showPgDetails
                        ? ['Single', 'Double', 'Triple', '4 Sharing', '5+ Sharing']
                        : ['2 Sharing', '3 Sharing', '4 Sharing', '5+ Sharing'])
                    .map(
                      (option) => ChoiceChip(
                        label: Text(option),
                        selected: _draft.sharingType == option,
                        selectedColor: AppColors.primary,
                        labelStyle: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: _draft.sharingType == option ? Colors.white : AppColors.textPrimary,
                        ),
                        onSelected: (_) => setState(() => _draft.sharingType = option),
                      ),
                    )
                    .toList(),
              ),
              if (_showValidation && _errors['sharingType'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errors['sharingType']!,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
            ],
            _FieldLabel('Available Beds'),
            _buildTextField(
              initialValue: _draft.availableBeds,
              hint: '2',
              keyboardType: TextInputType.number,
              errorText: _showValidation ? _errors['availableBeds'] : null,
              onChanged: (value) => setState(() => _draft.availableBeds = value),
            ),
            const SizedBox(height: 16),
            if (showPgDetails) ...[
              _SectionLabel('Suitable For'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ['Male', 'Female', 'Anyone']
                    .map(
                      (option) => ChoiceChip(
                        label: Text(option),
                        selected: _draft.suitableFor == option,
                        selectedColor: AppColors.primary,
                        labelStyle: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: _draft.suitableFor == option ? Colors.white : AppColors.textPrimary,
                        ),
                        onSelected: (_) => setState(() => _draft.suitableFor = option),
                      ),
                    )
                    .toList(),
              ),
              if (_showValidation && _errors['suitableFor'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errors['suitableFor']!,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
            ],
            _SectionLabel('Bathroom'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ['Attached', 'Common']
                  .map(
                    (option) => ChoiceChip(
                      label: Text(option),
                      selected: _draft.bathroomType == option,
                      selectedColor: AppColors.primary,
                      labelStyle: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: _draft.bathroomType == option ? Colors.white : AppColors.textPrimary,
                      ),
                      onSelected: (_) => setState(() => _draft.bathroomType = option),
                    ),
                  )
                  .toList(),
            ),
            if (_showValidation && _errors['bathroomType'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _errors['bathroomType']!,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ),
            if (_draft.bathroomType == 'common') ...[
              const SizedBox(height: 16),
              _FieldLabel('Approx. people sharing bathroom'),
              _buildTextField(
                initialValue: _draft.bathroomSharingPeople,
                hint: '2 people',
                keyboardType: TextInputType.number,
                errorText: _showValidation ? _errors['bathroomSharingPeople'] : null,
                onChanged: (value) => setState(() => _draft.bathroomSharingPeople = value),
              ),
            ],
            const SizedBox(height: 16),
            if (showRoomDetails) ...[
              _FieldLabel('Area'),
              _buildTextField(
                initialValue: _draft.area,
                hint: '250',
                keyboardType: TextInputType.number,
                errorText: _showValidation ? _errors['area'] : null,
                onChanged: (value) => setState(() => _draft.area = value),
              ),
              const SizedBox(height: 16),
              _FieldLabel('Floor'),
              _buildTextField(
                initialValue: _draft.floor,
                hint: '2',
                keyboardType: TextInputType.number,
                errorText: _showValidation ? _errors['floor'] : null,
                onChanged: (value) => setState(() => _draft.floor = value),
              ),
              const SizedBox(height: 16),
            ],
          ],

          if (showPgDetails) ...[
            const SizedBox(height: 16),
            _SectionLabel('Food Available?'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ['yes', 'no']
                  .map(
                    (option) => ChoiceChip(
                      label: Text(option == 'yes' ? 'Yes' : 'No'),
                      selected: _draft.foodAvailable == option,
                      selectedColor: AppColors.primary,
                      labelStyle: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: _draft.foodAvailable == option ? Colors.white : AppColors.textPrimary,
                      ),
                      onSelected: (_) => setState(() => _draft.foodAvailable = option),
                    ),
                  )
                  .toList(),
            ),
            if (_showValidation && _errors['foodAvailable'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _errors['foodAvailable']!,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ),
            if (_draft.foodAvailable == 'yes') ...[
              const SizedBox(height: 16),
              _SectionLabel('Meals Available'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ['Breakfast', 'Lunch', 'Dinner']
                    .map(
                      (meal) => FilterChip(
                        label: Text(meal),
                        selected: _draft.meals.contains(meal),
                        selectedColor: AppColors.primary,
                        labelStyle: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: _draft.meals.contains(meal) ? Colors.white : AppColors.textPrimary,
                        ),
                        onSelected: (_) {
                          setState(() {
                            if (_draft.meals.contains(meal)) {
                              _draft.meals.remove(meal);
                            } else {
                              _draft.meals.add(meal);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              if (_showValidation && _errors['meals'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errors['meals']!,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              _SectionLabel('Food Included In Rent?'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ['yes', 'no']
                    .map(
                      (option) => ChoiceChip(
                        label: Text(option == 'yes' ? 'Yes' : 'No'),
                        selected: _draft.foodIncluded == option,
                        selectedColor: AppColors.primary,
                        labelStyle: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: _draft.foodIncluded == option ? Colors.white : AppColors.textPrimary,
                        ),
                        onSelected: (_) => setState(() => _draft.foodIncluded = option),
                      ),
                    )
                    .toList(),
              ),
              if (_showValidation && _errors['foodIncluded'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errors['foodIncluded']!,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              if (_draft.foodIncluded == 'no') ...[
                const SizedBox(height: 16),
                _FieldLabel('Monthly Food Charges'),
                _buildTextField(
                  initialValue: _draft.foodCharges,
                  hint: '₹ 1200',
                  keyboardType: TextInputType.number,
                  errorText: _showValidation ? _errors['foodCharges'] : null,
                  onChanged: (value) => setState(() => _draft.foodCharges = value),
                ),
              ],
            ],
            const SizedBox(height: 16),
            _SectionLabel('AC Available?'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ['yes', 'no']
                  .map(
                    (option) => ChoiceChip(
                      label: Text(option == 'yes' ? 'Yes' : 'No'),
                      selected: _draft.acAvailable == option,
                      selectedColor: AppColors.primary,
                      labelStyle: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: _draft.acAvailable == option ? Colors.white : AppColors.textPrimary,
                      ),
                      onSelected: (_) => setState(() => _draft.acAvailable = option),
                    ),
                  )
                  .toList(),
            ),
            if (_showValidation && _errors['acAvailable'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _errors['acAvailable']!,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ),
          ],

          const SizedBox(height: 22),
          _SectionLabel('Furnishing'),
          if (_showValidation && _errors['furnishing'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _errors['furnishing']!,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.accent,
                ),
              ),
            ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['Fully Furnished', 'Semi Furnished', 'Unfurnished']
                .map(
                  (option) => ChoiceChip(
                    label: Text(option),
                    selected: _draft.furnishing == option,
                    selectedColor: AppColors.primary,
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: _draft.furnishing == option ? Colors.white : AppColors.textPrimary,
                    ),
                    onSelected: (_) => setState(() => _draft.furnishing = option),
                  ),
                )
                .toList(),
          ),
          if (_draft.furnishing != 'Unfurnished') ...[
            const SizedBox(height: 16),
            _SectionLabel('Furniture & Appliances'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ['Bed', 'Mattress', 'Wardrobe', 'Sofa', 'TV', 'Refrigerator', 'Washing Machine', 'AC', 'Dining Table']
                  .map(
                    (item) => FilterChip(
                      label: Text(item),
                      selected: _draft.amenities.contains(item),
                      selectedColor: AppColors.primary,
                      labelStyle: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: _draft.amenities.contains(item) ? Colors.white : AppColors.textPrimary,
                      ),
                      onSelected: (_) {
                        setState(() {
                          if (_draft.amenities.contains(item)) {
                            _draft.amenities.remove(item);
                          } else {
                            _draft.amenities.add(item);
                          }
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 22),
          _SectionLabel('Parking Available?'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['yes', 'no']
                .map(
                  (option) => ChoiceChip(
                    label: Text(option == 'yes' ? 'Yes' : 'No'),
                    selected: _draft.parkingAvailable == option,
                    selectedColor: AppColors.primary,
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: _draft.parkingAvailable == option ? Colors.white : AppColors.textPrimary,
                    ),
                    onSelected: (_) => setState(() => _draft.parkingAvailable = option),
                  ),
                )
                .toList(),
          ),
          if (_showValidation && _errors['parkingAvailable'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _errors['parkingAvailable']!,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.accent,
                ),
              ),
            ),
          if (_draft.parkingAvailable == 'yes') ...[
            const SizedBox(height: 16),
            _SectionLabel('Parking Type'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ['2 Wheeler', '4 Wheeler', 'Both']
                  .map(
                    (option) => ChoiceChip(
                      label: Text(option),
                      selected: _draft.parkingType == option,
                      selectedColor: AppColors.primary,
                      labelStyle: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: _draft.parkingType == option ? Colors.white : AppColors.textPrimary,
                      ),
                      onSelected: (_) => setState(() => _draft.parkingType = option),
                    ),
                  )
                  .toList(),
            ),
            if (_showValidation && _errors['parkingType'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _errors['parkingType']!,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildRentAndPhotosStep() {
    return _StepBody(
      title: 'Set your rent & add photos 💰📸',
      subtitle: 'Add the pricing, availability, and photos people need to understand the property.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel('Rent'),
          const SizedBox(height: 12),
          _FieldLabel('Monthly Rent'),
          _buildTextField(
            initialValue: _draft.rent,
            hint: '₹ Enter monthly rent',
            keyboardType: TextInputType.number,
            errorText: _showValidation ? _errors['rent'] : null,
            onChanged: (value) => setState(() => _draft.rent = value),
          ),
          const SizedBox(height: 16),
          _FieldLabel('Security Deposit'),
          _buildTextField(
            initialValue: _draft.deposit,
            hint: '₹ Enter security deposit',
            keyboardType: TextInputType.number,
            errorText: _showValidation ? _errors['deposit'] : null,
            onChanged: (value) => setState(() => _draft.deposit = value),
          ),
          const SizedBox(height: 16),
          _SectionLabel('Maintenance'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['included', 'extra']
                .map(
                  (option) => ChoiceChip(
                    label: Text(option == 'included' ? 'Included in Rent' : 'Extra'),
                    selected: _draft.maintenanceOption == option,
                    selectedColor: AppColors.primary,
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: _draft.maintenanceOption == option ? Colors.white : AppColors.textPrimary,
                    ),
                    onSelected: (_) => setState(() => _draft.maintenanceOption = option),
                  ),
                )
                .toList(),
          ),
          if (_draft.maintenanceOption == 'extra') ...[
            const SizedBox(height: 16),
            _FieldLabel('Monthly Maintenance Amount'),
            _buildTextField(
              initialValue: _draft.maintenance,
              hint: '₹ Monthly maintenance',
              keyboardType: TextInputType.number,
              errorText: _showValidation ? _errors['maintenance'] : null,
              onChanged: (value) => setState(() => _draft.maintenance = value),
            ),
          ],
          const SizedBox(height: 20),
          _SectionLabel('Electricity Charges'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['included', 'extra', 'asPerUsage']
                .map(
                  (option) => ChoiceChip(
                    label: Text(
                      option == 'included'
                          ? 'Included in Rent'
                          : option == 'extra'
                              ? 'Extra'
                              : 'As Per Usage',
                    ),
                    selected: _draft.electricityChargesOption == option,
                    selectedColor: AppColors.primary,
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: _draft.electricityChargesOption == option ? Colors.white : AppColors.textPrimary,
                    ),
                    onSelected: (_) => setState(() => _draft.electricityChargesOption = option),
                  ),
                )
                .toList(),
          ),
          if (_draft.electricityChargesOption == 'extra') ...[
            const SizedBox(height: 16),
            _FieldLabel('Monthly Electricity Charges'),
            _buildTextField(
              initialValue: _draft.electricityCharges,
              hint: '₹ Electricity charges',
              keyboardType: TextInputType.number,
              errorText: _showValidation ? _errors['electricityCharges'] : null,
              onChanged: (value) => setState(() => _draft.electricityCharges = value),
            ),
          ],
          const SizedBox(height: 20),
          _SectionLabel('Property Available?'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['availableNow', 'availableFrom']
                .map(
                  (option) => ChoiceChip(
                    label: Text(option == 'availableNow' ? 'Available Now' : 'Available From Date'),
                    selected: _draft.propertyAvailableOption == option,
                    selectedColor: AppColors.primary,
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: _draft.propertyAvailableOption == option ? Colors.white : AppColors.textPrimary,
                    ),
                    onSelected: (_) => setState(() => _draft.propertyAvailableOption = option),
                  ),
                )
                .toList(),
          ),
          if (_draft.propertyAvailableOption == 'availableFrom') ...[
            const SizedBox(height: 16),
            _FieldLabel('Available From Date'),
            const SizedBox(height: 8),
            InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 18, color: AppColors.textSecondary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _draft.availableFrom == null
                            ? 'Select available date'
                            : '${_draft.availableFrom!.day}/${_draft.availableFrom!.month}/${_draft.availableFrom!.year}',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _draft.availableFrom == null ? AppColors.textHint : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_showValidation && _errors['availableFrom'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _errors['availableFrom']!,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ),
          ],
          const SizedBox(height: 24),
          _SectionLabel('Property Photos'),
          const SizedBox(height: 6),
          Text(
            'Add clear photos to help people understand your property.',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 18),
          if (_showValidation && _errors['photos'] != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _errors['photos']!,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.accent,
                ),
              ),
            ),
          LayoutBuilder(
            builder: (context, constraints) {
              final tileSize = (constraints.maxWidth - 10) / 2;
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (int index = 0; index < _draft.photos.length; index++)
                    SizedBox(
                      width: tileSize,
                      height: tileSize,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: _PhotoPreview(photo: _draft.photos[index]),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _draft.coverPhotoIndex == index ? AppColors.primary : Colors.black.withAlpha(140),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _draft.coverPhotoIndex == index ? 'COVER' : 'PHOTO',
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 8,
                            bottom: 8,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _setCoverPhoto(index),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(130),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Set Cover',
                                      style: GoogleFonts.outfit(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () => _deletePhoto(index),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(130),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: Row(
                              children: [
                                if (index > 0)
                                  GestureDetector(
                                    onTap: () => _movePhoto(index, up: true),
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(130),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 16),
                                    ),
                                  ),
                                if (index < _draft.photos.length - 1)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: GestureDetector(
                                      onTap: () => _movePhoto(index, up: false),
                                      child: Container(
                                        width: 26,
                                        height: 26,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(130),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(Icons.arrow_downward_rounded, color: Colors.white, size: 16),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    width: tileSize,
                    height: tileSize,
                    child: InkWell(
                      onTap: _addPhotos,
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.divider, width: 1.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_photo_alternate_rounded, size: 36, color: AppColors.textSecondary),
                            const SizedBox(height: 6),
                            Text(
                              '+ Add Photos',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          Text(
            '${_draft.photos.length} / 10 photos',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionAndPreviewStep() {
    final preferredTenantOptions = _draft.propertyType == PropertyType.pg
        ? ['Male', 'Female', 'Anyone']
        : ['Family', 'Bachelor', 'Anyone'];

    return _StepBody(
      title: 'Almost there 🎉',
      subtitle: 'Add a quick description and review how your listing will look to regular users.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel('Describe your property'),
          const SizedBox(height: 10),
          _buildTextField(
            initialValue: _draft.description,
            hint: 'Tell people about your property, nearby places, transport, special features, etc.',
            maxLines: 6,
            errorText: _showValidation ? _errors['description'] : null,
            onChanged: (value) => setState(() => _draft.description = value),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_draft.description.length} / 500',
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 22),
          _SectionLabel('Preferred Tenant'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: preferredTenantOptions
                .map(
                  (option) => FilterChip(
                    label: Text(option),
                    selected: _draft.preferredTenant.contains(option),
                    selectedColor: AppColors.primary,
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: _draft.preferredTenant.contains(option) ? Colors.white : AppColors.textPrimary,
                    ),
                    onSelected: (_) => _togglePreference(option),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          _SectionLabel('Property Rules'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['Pets Allowed', 'Non-Smoking', 'Smoking Allowed', 'No Restrictions']
                .map(
                  (option) => FilterChip(
                    label: Text(option),
                    selected: _draft.propertyRules.contains(option),
                    selectedColor: AppColors.primary,
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: _draft.propertyRules.contains(option) ? Colors.white : AppColors.textPrimary,
                    ),
                    onSelected: (_) => _toggleRule(option),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          _SectionLabel('Preview Your Listing'),
          const SizedBox(height: 12),
          _PreviewCard(draft: _draft),
        ],
      ),
    );
  }

  Widget _buildSuccessState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(16),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 60)),
              const SizedBox(height: 18),
              Text(
                'Property Submitted!',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your property has been submitted successfully and is now under verification.',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.sectionBg,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Under Review',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.profile);
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    side: const BorderSide(color: AppColors.divider),
                    foregroundColor: AppColors.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'View My Properties',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Back to Home',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    if (_isSubmitted) {
      return _buildSuccessState();
    }

    switch (_currentStep) {
      case 0:
        return _buildOwnerAndTypeStep();
      case 1:
        return _buildLocationStep();
      case 2:
        return _buildPropertyDetailsStep();
      case 3:
        return _buildRentAndPhotosStep();
      case 4:
        return _buildDescriptionAndPreviewStep();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: _back,
                        icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.textPrimary, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Post Your Property',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 36),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Step ${_currentStep + 1} of 5',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      _buildProgressBar(),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 260),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                child: KeyedSubtree(
                  key: ValueKey(_currentStep),
                  child: _buildStepContent(),
                ),
              ),
            ),
            if (!_isSubmitted)
              Container(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  border: const Border(
                    top: BorderSide(color: AppColors.divider, width: 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(12),
                      blurRadius: 20,
                      offset: const Offset(0, -8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _back,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            minimumSize: const Size.fromHeight(52),
                            side: const BorderSide(color: AppColors.divider),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            '← Back',
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 12),
                    Expanded(
                      flex: _currentStep > 0 ? 2 : 1,
                      child: ElevatedButton(
                        onPressed: _continue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          _currentStep == 4 ? 'Publish Property' : 'Continue →',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StepBody extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _StepBody({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          child,
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.outfit(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _PhotoPreview extends StatelessWidget {
  final PhotoItem photo;

  const _PhotoPreview({required this.photo});

  @override
  Widget build(BuildContext context) {
    if (photo.isRemote) {
      return Image.network(
        photo.path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) => _fallbackPreview(),
      );
    }

    return Image.file(
      File(photo.path),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => _fallbackPreview(),
    );
  }

  Widget _fallbackPreview() {
    return Container(
      color: AppColors.sectionBg,
      child: const Center(
        child: Icon(Icons.image_not_supported_rounded, color: AppColors.textSecondary),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  final PropertyListingDraft draft;

  const _PreviewCard({required this.draft});

  @override
  Widget build(BuildContext context) {
    final coverPhoto = draft.photos.isNotEmpty && draft.coverPhotoIndex >= 0
        ? draft.photos[draft.coverPhotoIndex]
        : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (coverPhoto != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: _PhotoPreview(photo: coverPhoto),
              ),
            )
          else
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryMid],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.home_outlined, size: 46, color: Colors.white),
              ),
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                draft.propertyType?.label ?? 'Property',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.sectionBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '₹${draft.rent.isNotEmpty ? draft.rent : '0'} / month',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${draft.locality.isNotEmpty ? draft.locality : 'Locality'}, • ${draft.city.isNotEmpty ? draft.city : 'City'}',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (draft.bhk.isNotEmpty) _previewPill(draft.bhk),
              if (draft.area.isNotEmpty) _previewPill('${draft.area} sq ft'),
              if (draft.bathrooms.isNotEmpty) _previewPill('${draft.bathrooms} baths'),
              if (draft.balconies.isNotEmpty) _previewPill('${draft.balconies} balconies'),
              if (draft.roomType.isNotEmpty) _previewPill(draft.roomType),
              if (draft.sharing.isNotEmpty) _previewPill(draft.sharing),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _detailText('Deposit', '₹${draft.deposit.isNotEmpty ? draft.deposit : '0'}'),
              const SizedBox(width: 18),
              _detailText(
                'Maintenance',
                draft.maintenanceOption == 'extra'
                    ? '₹${draft.maintenance.isNotEmpty ? draft.maintenance : '0'}'
                    : 'Included',
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (draft.amenities.isNotEmpty) ...[
            Text(
              'Amenities',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: draft.amenities.map(_previewPill).toList(),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            'Description',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            draft.description.isEmpty ? 'No description yet.' : draft.description,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.sectionBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_rounded, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Owner contact details and exact location are hidden from users.',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailText(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.sectionBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class PropertyListingDraft {
  String ownerName = '';
  String phone = '';
  String email = '';
  PropertyType? propertyType;
  String city = '';
  String locality = '';
  String society = '';
  String exactAddress = '';
  double latitude = 0;
  double longitude = 0;
  String bhk = '';
  String area = '';
  String areaUnit = 'sq.ft';
  String floor = '';
  String totalFloors = '';
  String bathrooms = '';
  String balconies = '';
  String furnishing = '';
  String roomType = '';
  String sharing = '';
  String sharingType = '';
  String attachedBathroom = '';
  String bathroomType = '';
  String bathroomSharingPeople = '';
  String suitableFor = '';
  String availableBeds = '';
  String foodAvailable = '';
  List<String> meals = [];
  String foodIncluded = '';
  String foodCharges = '';
  String acAvailable = '';
  String parkingAvailable = '';
  String parkingType = '';
  String rent = '';
  String deposit = '';
  String maintenance = '';
  String maintenanceOption = 'included';
  String electricityCharges = '';
  String electricityChargesOption = 'included';
  String propertyAvailableOption = 'availableNow';
  DateTime? availableFrom;
  List<String> amenities = [];
  List<PhotoItem> photos = [];
  int coverPhotoIndex = -1;
  String description = '';
  List<String> preferredTenant = [];
  List<String> propertyRules = [];
  bool isSubmitted = false;
}

class PhotoItem {
  final String path;
  final bool isRemote;

  PhotoItem({required this.path, required this.isRemote});
}

enum PropertyType {
  flat,
  rk,
  room,
  pg,
  sharedRoom;

  String get label {
    switch (this) {
      case PropertyType.flat:
        return 'Flat';
      case PropertyType.rk:
        return '1 RK';
      case PropertyType.room:
        return 'Room';
      case PropertyType.pg:
        return 'PG';
      case PropertyType.sharedRoom:
        return 'Shared Room';
    }
  }

  String get icon {
    switch (this) {
      case PropertyType.flat:
        return '🏠';
      case PropertyType.rk:
        return '🏡';
      case PropertyType.room:
        return '🛏';
      case PropertyType.pg:
        return '🏢';
      case PropertyType.sharedRoom:
        return '👥';
    }
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PlaceholderScreen(
      title: 'Profile',
      icon: Icons.person_rounded,
      gradientColors: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      message: 'User profile and account settings\ncoming soon.',
    );
  }
}

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PlaceholderScreen(
      title: 'Property Details',
      icon: Icons.apartment_rounded,
      gradientColors: [const Color(0xFF00C9A7), AppColors.primaryMid],
      message: 'Full property details with\n₹100 unlock flow coming soon.',
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradientColors;
  final String message;

  const _PlaceholderScreen({
    required this.title,
    required this.icon,
    required this.gradientColors,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.cardBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: gradientColors.first.withAlpha(60),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 44),
            ),
            const SizedBox(height: 28),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.sectionBg,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.divider),
              ),
              child: Text(
                '🚧  Coming Soon',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool _validPhone(String value) {
  final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
  return digits.length >= 10;
}

bool _validEmail(String value) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
}
