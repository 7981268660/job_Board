import 'package:flutter/material.dart';

void main() => runApp(const JobBoardApp());

class Job {
  final int id;
  final String title, company, location, type, salary, description;
  final List<String> responsibilities, requirements;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.salary,
    required this.description,
    required this.responsibilities,
    required this.requirements,
  });
}

const List<Job> jobs = [
  Job(
    id: 1, title: 'Flutter Developer', company: 'Google',
    location: 'Hyderabad', type: 'Full Time', salary: '₹6 - 12 LPA',
    description: 'Build beautiful, high-performance cross-platform mobile applications. Work with designers and developers to create modern mobile experiences.',
    responsibilities: ['Develop Flutter applications.', 'Write clean and reusable Dart code.', 'Collaborate with UI/UX designers.', 'Test and maintain applications.'],
    requirements: ['Knowledge of Flutter and Dart.', 'Understanding of REST APIs.', 'Firebase knowledge is preferred.', 'Good problem-solving skills.'],
  ),
  Job(
    id: 2, title: 'Frontend Developer', company: 'Microsoft',
    location: 'Bangalore', type: 'Full Time', salary: '₹8 - 15 LPA',
    description: 'Develop responsive and interactive web applications using modern frontend technologies.',
    responsibilities: ['Develop responsive interfaces.', 'Work with React and JavaScript.', 'Optimize application performance.', 'Collaborate with backend developers.'],
    requirements: ['HTML, CSS and JavaScript.', 'Experience with React.', 'Responsive design knowledge.', 'Knowledge of Git.'],
  ),
  Job(
    id: 3, title: 'UI/UX Designer', company: 'Adobe',
    location: 'Mumbai', type: 'Remote', salary: '₹5 - 10 LPA',
    description: 'Design engaging digital experiences and user-friendly interfaces for web and mobile products.',
    responsibilities: ['Create wireframes and prototypes.', 'Design user-friendly interfaces.', 'Conduct user research.', 'Work with development teams.'],
    requirements: ['Knowledge of Figma.', 'Understanding of UI/UX principles.', 'Creative thinking.', 'A portfolio of design projects.'],
  ),
  Job(
    id: 4, title: 'Backend Developer', company: 'Amazon',
    location: 'Hyderabad', type: 'Full Time', salary: '₹7 - 14 LPA',
    description: 'Develop secure, scalable and reliable server-side applications and services.',
    responsibilities: ['Develop REST APIs.', 'Manage databases.', 'Write efficient backend code.', 'Improve server performance.'],
    requirements: ['Python or Java knowledge.', 'Understanding of databases.', 'Knowledge of REST APIs.', 'Basic cloud computing knowledge.'],
  ),
  Job(
    id: 5, title: 'Data Analyst Intern', company: 'Infosys',
    location: 'Chennai', type: 'Internship', salary: '₹15,000/month',
    description: 'An internship for students interested in data analytics, reporting and business intelligence.',
    responsibilities: ['Analyze datasets.', 'Create reports and dashboards.', 'Clean and organize data.', 'Support the analytics team.'],
    requirements: ['Knowledge of Excel.', 'Basic SQL knowledge.', 'Understanding of statistics.', 'Willingness to learn.'],
  ),
  Job(
    id: 6, title: 'Python Developer', company: 'TCS',
    location: 'Pune', type: 'Part Time', salary: '₹20,000/month',
    description: 'Build automation tools and backend applications using Python.',
    responsibilities: ['Write Python programs.', 'Develop automation scripts.', 'Debug and test applications.', 'Work with the development team.'],
    requirements: ['Knowledge of Python.', 'Basic database knowledge.', 'Programming fundamentals.', 'Good communication skills.'],
  ),
];

class JobBoardApp extends StatelessWidget {
  const JobBoardApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'JobFinder',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5146E5)),
      scaffoldBackgroundColor: const Color(0xFFF7F7FC),
    ),
    home: const JobHomePage(),
  );
}

class JobHomePage extends StatefulWidget {
  const JobHomePage({super.key});

  @override
  State<JobHomePage> createState() => _JobHomePageState();
}

class _JobHomePageState extends State<JobHomePage> {
  String searchText = '';
  String selectedLocation = 'All Locations';
  String selectedType = 'All Types';

  final locations = const ['All Locations', 'Hyderabad', 'Bangalore', 'Mumbai', 'Chennai', 'Pune'];
  final types = const ['All Types', 'Full Time', 'Part Time', 'Remote', 'Internship'];

  List<Job> get filteredJobs => jobs.where((job) {
    final matchesSearch = job.title.toLowerCase().contains(searchText.toLowerCase()) ||
        job.company.toLowerCase().contains(searchText.toLowerCase());
    final matchesLocation = selectedLocation == 'All Locations' || job.location == selectedLocation;
    final matchesType = selectedType == 'All Types' || job.type == selectedType;
    return matchesSearch && matchesLocation && matchesType;
  }).toList();

  @override
  Widget build(BuildContext context) {
    final results = filteredJobs;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5146E5),
        foregroundColor: Colors.white,
        title: const Row(children: [
          Icon(Icons.work_outline), SizedBox(width: 10),
          Text('JobFinder', style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
        actions: [
          IconButton(
            tooltip: 'Reset filters',
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {
              searchText = '';
              selectedLocation = 'All Locations';
              selectedType = 'All Types';
            }),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text('Find Your Dream Job', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF252343))),
          const SizedBox(height: 7),
          const Text('Explore opportunities and build your career.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 22),
          TextField(
            onChanged: (value) => setState(() => searchText = value),
            decoration: InputDecoration(
              hintText: 'Search job title or company...',
              prefixIcon: const Icon(Icons.search),
              filled: true, fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Filter Jobs', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: _filterDropdown(selectedLocation, locations, (v) => setState(() => selectedLocation = v))),
            const SizedBox(width: 10),
            Expanded(child: _filterDropdown(selectedType, types, (v) => setState(() => selectedType = v))),
          ]),
          const SizedBox(height: 22),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Available Jobs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('${results.length} Jobs Found', style: const TextStyle(color: Color(0xFF5146E5), fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 12),
          if (results.isEmpty)
            const Padding(
              padding: EdgeInsets.all(30),
              child: Column(children: [
                Icon(Icons.search_off, size: 55, color: Colors.grey),
                SizedBox(height: 12),
                Text('No jobs found!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Try changing your search or filters.'),
              ]),
            )
          else
            ...results.map((job) => JobCard(
              job: job,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => JobDetailsPage(job: job))),
            )),
        ],
      ),
    );
  }

  Widget _filterDropdown(String value, List<String> options, ValueChanged<String> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true, fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      items: options.map((item) => DropdownMenuItem(value: item, child: Text(item, overflow: TextOverflow.ellipsis))).toList(),
      onChanged: (v) { if (v != null) onChanged(v); },
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;
  const JobCard({super.key, required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white, elevation: 1,
    margin: const EdgeInsets.only(bottom: 13),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              height: 48, width: 48,
              decoration: BoxDecoration(color: const Color(0xFFEEEDFF), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.business_center, color: Color(0xFF5146E5), size: 27),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(job.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(job.company, style: const TextStyle(color: Colors.grey)),
            ])),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ]),
          const SizedBox(height: 15),
          Wrap(spacing: 8, runSpacing: 8, children: [
            _tag(Icons.location_on_outlined, job.location),
            _tag(Icons.access_time, job.type),
          ]),
          const SizedBox(height: 13),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(job.salary, style: const TextStyle(color: Color(0xFF5146E5), fontWeight: FontWeight.bold)),
            const Text('View Details', style: TextStyle(color: Color(0xFF5146E5), fontWeight: FontWeight.w600)),
          ]),
        ]),
      ),
    ),
  );

  Widget _tag(IconData icon, String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
    decoration: BoxDecoration(color: const Color(0xFFF2F2F8), borderRadius: BorderRadius.circular(8)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 14, color: Colors.grey[700]),
      const SizedBox(width: 5),
      Text(label, style: const TextStyle(fontSize: 12)),
    ]),
  );
}

class JobDetailsPage extends StatelessWidget {
  final Job job;
  const JobDetailsPage({super.key, required this.job});

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 10, top: 18),
    child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF252343))),
  );

  Widget _bulletList(List<String> items) => Column(
    children: items.map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.check_circle, color: Color(0xFF5146E5), size: 19),
        const SizedBox(width: 9),
        Expanded(child: Text(item, style: const TextStyle(fontSize: 14, height: 1.5))),
      ]),
    )).toList(),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Job Details'), backgroundColor: const Color(0xFF5146E5), foregroundColor: Colors.white),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CircleAvatar(radius: 29, backgroundColor: Color(0xFFEEEDFF), child: Icon(Icons.business_center, color: Color(0xFF5146E5), size: 30)),
            const SizedBox(height: 15),
            Text(job.title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 7),
            Text(job.company, style: const TextStyle(color: Color(0xFF5146E5), fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 14),
            Text('📍 ${job.location}'),
            const SizedBox(height: 7),
            Text('💼 ${job.type}'),
            const SizedBox(height: 7),
            Text('💰 ${job.salary}'),
          ]),
        ),
        _sectionTitle('Job Description'),
        Text(job.description, style: const TextStyle(fontSize: 15, height: 1.7)),
        _sectionTitle('Responsibilities'),
        _bulletList(job.responsibilities),
        _sectionTitle('Requirements'),
        _bulletList(job.requirements),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity, height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5146E5), foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ApplicationPage(job: job))),
            child: const Text('Apply Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 20),
      ]),
    ),
  );
}

class ApplicationPage extends StatefulWidget {
  final Job job;
  const ApplicationPage({super.key, required this.job});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final coverController = TextEditingController();
  final resumeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    coverController.dispose();
    resumeController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, IconData icon) => InputDecoration(
    labelText: label, prefixIcon: Icon(icon), filled: true, fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF5146E5), width: 1.5)),
  );

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 15),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
  );

  String? _required(String? value, String field) =>
      value == null || value.trim().isEmpty ? 'Please enter $field' : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 55),
        title: const Text('Application Submitted!'),
        content: Text(
          'Thank you ${nameController.text.trim()}!\n\n'
          'Your application for ${widget.job.title} at ${widget.job.company} '
          'has been validated successfully. This demo does not send or store applications.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Job Application'), backgroundColor: const Color(0xFF5146E5), foregroundColor: Colors.white),
    body: Form(
      key: _formKey,
      child: ListView(padding: const EdgeInsets.all(20), children: [
        Text('Apply for ${widget.job.title}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF252343))),
        const SizedBox(height: 7),
        Text('${widget.job.company} • ${widget.job.location}', style: const TextStyle(color: Colors.grey)),
        _label('Full Name *'),
        TextFormField(
          controller: nameController,
          decoration: _decoration('Enter your full name', Icons.person_outline),
          validator: (v) {
            final required = _required(v, 'your name');
            if (required != null) return required;
            if (v!.trim().length < 3) return 'Name must contain at least 3 characters';
            return null;
          },
        ),
        _label('Email Address *'),
        TextFormField(
          controller: emailController, keyboardType: TextInputType.emailAddress,
          decoration: _decoration('Enter your email', Icons.email_outlined),
          validator: (v) {
            final required = _required(v, 'your email');
            if (required != null) return required;
            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v!.trim())) return 'Enter a valid email address';
            return null;
          },
        ),
        _label('Phone Number *'),
        TextFormField(
          controller: phoneController, keyboardType: TextInputType.phone,
          decoration: _decoration('Enter 10 digit phone number', Icons.phone_outlined),
          validator: (v) {
            final required = _required(v, 'your phone number');
            if (required != null) return required;
            if (!RegExp(r'^\d{10}$').hasMatch(v!.trim())) return 'Enter a valid 10 digit phone number';
            return null;
          },
        ),
        _label('Resume Link *'),
        TextFormField(
          controller: resumeController, keyboardType: TextInputType.url,
          decoration: _decoration('Enter your resume URL', Icons.description_outlined),
          validator: (v) {
            final required = _required(v, 'your resume link');
            if (required != null) return required;
            final uri = Uri.tryParse(v!.trim());
            if (uri == null || !uri.hasScheme || !['http', 'https'].contains(uri.scheme) || uri.host.isEmpty) {
              return 'Enter a valid HTTP or HTTPS URL';
            }
            return null;
          },
        ),
        _label('Cover Letter'),
        TextFormField(
          controller: coverController, maxLines: 5,
          decoration: _decoration('Tell us why you are suitable for this job', Icons.edit_note),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity, height: 53,
          child: ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5146E5), foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Submit Application', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 25),
      ]),
    ),
  );
}
