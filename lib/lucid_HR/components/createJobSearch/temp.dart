import 'package:flutter/material.dart';

class AIJobSearchCreationScreen extends StatefulWidget {
  const AIJobSearchCreationScreen({Key? key}) : super(key: key);

  @override
  _AIJobSearchCreationScreenState createState() => _AIJobSearchCreationScreenState();
}

class _AIJobSearchCreationScreenState extends State<AIJobSearchCreationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final List<String> _emailList = [];
  String _newEmail = '';
  double _alignmentValue = 70.0;
  double _peopleValue = 70.0;
  double _processValue = 70.0;
  double _leadershipValue = 70.0;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _addEmail() {
    if (_newEmail.isNotEmpty && _newEmail.contains('@')) {
      setState(() {
        _emailList.add(_newEmail);
        _newEmail = '';
      });
    }
  }

  void _removeEmail(int index) {
    setState(() {
      _emailList.removeAt(index);
    });
  }

  void _clearAllEmails() {
    setState(() {
      _emailList.clear();
    });
  }

  void _submitJobSearch() {
    // Here you would connect to your Python Google Function backend
    // For example:
    // final jobSearch = {
    //   'title': _titleController.text,
    //   'emails': _emailList,
    //   'alignment': _alignmentValue,
    //   'people': _peopleValue,
    //   'process': _processValue,
    //   'leadership': _leadershipValue,
    // };
    
    // Call your backend API
    print('Submitting job search: $_titleController.text');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(title: 'Create New Job Search'),
            const SizedBox(height: 20),
            
            // Two columns layout for larger screens
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 700) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left column
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleInput(controller: _titleController),
                            const SizedBox(height: 20),
                            // EmailListWidget(
                            //   emails: _emailList,
                            //   onEmailChanged: (value) {
                            //     _newEmail = value;
                            //   },
                            //   onRemoveEmail: _removeEmail,
                            //   onAddEmail: _addEmail,
                            //   onClearAll: _clearAllEmails,
                            // ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // Right column
                      Expanded(
                        flex: 3,
                        child: BenchmarkSection(
                          alignmentValue: _alignmentValue,
                          peopleValue: _peopleValue,
                          processValue: _processValue,
                          leadershipValue: _leadershipValue,
                          onAlignmentChanged: (value) {
                            setState(() => _alignmentValue = value);
                          },
                          onPeopleChanged: (value) {
                            setState(() => _peopleValue = value);
                          },
                          onProcessChanged: (value) {
                            setState(() => _processValue = value);
                          },
                          onLeadershipChanged: (value) {
                            setState(() => _leadershipValue = value);
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  // Single column for smaller screens
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleInput(controller: _titleController),
                      const SizedBox(height: 20),
                      // EmailListWidget(
                      //   emails: _emailList,
                      //   onEmailChanged: (value) {
                      //     _newEmail = value;
                      //   },
                      //   onRemoveEmail: _removeEmail,
                      //   onAddEmail: _addEmail,
                      //   onClearAll: _clearAllEmails,
                      // ),
                      const SizedBox(height: 20),
                      BenchmarkSection(
                        alignmentValue: _alignmentValue,
                        peopleValue: _peopleValue,
                        processValue: _processValue,
                        leadershipValue: _leadershipValue,
                        onAlignmentChanged: (value) {
                          setState(() => _alignmentValue = value);
                        },
                        onPeopleChanged: (value) {
                          setState(() => _peopleValue = value);
                        },
                        onProcessChanged: (value) {
                          setState(() => _processValue = value);
                        },
                        onLeadershipChanged: (value) {
                          setState(() => _leadershipValue = value);
                        },
                      ),
                    ],
                  );
                }
              },
            ),
            
            const SizedBox(height: 20),
            
            // Next button
            Align(
              alignment: Alignment.centerRight,
              child: NextButton(onPressed: _submitJobSearch),
            ),
          ],
        ),
      ),
    );
  }
}

// Modular components

class PageHeader extends StatelessWidget {
  final String title;
  
  const PageHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4D4D4D),
      ),
    );
  }
}

class TitleInput extends StatelessWidget {
  final TextEditingController controller;
  
  const TitleInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Title',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4D4D4D),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Paralegal...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}


class EmailListItem extends StatelessWidget {
  final String email;
  final VoidCallback onRemove;
  
  const EmailListItem({
    Key? key,
    required this.email,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              email,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            color: Colors.grey,
            onPressed: onRemove,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class BenchmarkSection extends StatelessWidget {
  final double alignmentValue;
  final double peopleValue;
  final double processValue;
  final double leadershipValue;
  final Function(double) onAlignmentChanged;
  final Function(double) onPeopleChanged;
  final Function(double) onProcessChanged;
  final Function(double) onLeadershipChanged;
  
  const BenchmarkSection({
    Key? key,
    required this.alignmentValue,
    required this.peopleValue,
    required this.processValue,
    required this.leadershipValue,
    required this.onAlignmentChanged,
    required this.onPeopleChanged,
    required this.onProcessChanged,
    required this.onLeadershipChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Benchmark',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4D4D4D),
          ),
        ),
        const SizedBox(height: 20),
        BenchmarkSlider(
          title: 'Alignment',
          description: 'Alignment scores show how well a candidate fits the company\'s structure, goals, and collaboration style. lower scores fit structured roles, mid-range balances flexibility, and higher scores suit autonomous environments.',
          value: alignmentValue,
          onChanged: onAlignmentChanged,
        ),
        const SizedBox(height: 16),
        BenchmarkSlider(
          title: 'People',
          description: 'People scores measure how a candidate engages with company culture, teamwork, and accountability—lower scores fit structured, role-defined teams, mid-range balances collaboration and autonomy, and higher scores suit highly engaged, self-driven environments',
          value: peopleValue,
          onChanged: onPeopleChanged,
        ),
        const SizedBox(height: 16),
        BenchmarkSlider(
          title: 'Process',
          description: 'Alignment scores show how well a candidate fits the company\'s structure, goals, and collaboration style. lower scores fit structured roles, mid-range balances flexibility, and higher scores suit autonomous environments.',
          value: processValue,
          onChanged: onProcessChanged,
        ),
        const SizedBox(height: 16),
        BenchmarkSlider(
          title: 'Leadership',
          description: 'Leadership scores reflect decision-making, initiative, and influence—lower scores fit structured, top-down environments, mid-range balances autonomy with guidance, and higher scores suit self-led, empowered leadership roles.',
          value: leadershipValue,
          onChanged: onLeadershipChanged,
        ),
      ],
    );
  }
}

class BenchmarkSlider extends StatelessWidget {
  final String title;
  final String description;
  final double value;
  final Function(double) onChanged;
  
  const BenchmarkSlider({
    Key? key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4D4D4D),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.info_outline,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('0%', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8.0,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
                  activeTrackColor: Colors.green[300],
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Colors.white,
                  overlayColor: Colors.green.withOpacity(0.3),
                ),
                child: Slider(
                  value: value,
                  min: 0,
                  max: 100,
                  onChanged: onChanged,
                ),
              ),
            ),
            const Text('100%', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${value.toInt()}%',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  
  const NextButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[400],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Next',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}