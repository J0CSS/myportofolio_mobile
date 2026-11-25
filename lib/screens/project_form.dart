import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _validateUrl(String? value, {required String fieldName}) {
    final url = value?.trim() ?? '';
    if (url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return '$fieldName must be a valid HTTP or HTTPS URL.';
    }
    return null;
  }

  String? _validateTechStack(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return null;

    final ids = input.split(',').map((part) => part.trim());
    if (ids.any((id) => int.tryParse(id) == null || int.parse(id) <= 0)) {
      return 'Enter comma-separated positive tech tag IDs, for example: 1, 2.';
    }
    return null;
  }

  List<int> _techTagIds() {
    final input = _techStack.trim();
    if (input.isEmpty) return const [];
    return input.split(',').map((part) => int.parse(part.trim())).toList();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authState = context.read<AuthState>();
    final apiClient = context.read<ApiClient>();

    setState(() {
      _isSubmitting = true;
    });

    try {
      final authorized = await ensureLoggedIn(context);
      if (!mounted || !authorized) return;

      final token = authState.token;
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in before saving.')),
        );
        return;
      }

      final newProject = Project(
        title: _title.trim(),
        description: _description.trim(),
        techTags: _techTagIds(),
        projectUrl: _projectUrl.trim(),
        projectImageUrl: _projectImageUrl.trim(),
      );

      try {
        final created = await apiClient.createProject(
              newProject,
              token: token,
            );
        if (!mounted) return;

        await showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Project created'),
            content: Text('“${created.title}” was added successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } on ApiException catch (error) {
        if (error.statusCode == 401) {
          try {
            await authState.logout();
          } catch (_) {
            // AuthState clears its local token in finally, even if logout fails.
          }
          if (!mounted) return;

          final loggedInAgain = await ensureLoggedIn(context);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                loggedInAgain
                    ? 'Please tap Save again to submit the project.'
                    : 'Session expired. Log in to save the project.',
              ),
            ),
          );
          return;
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not save project (HTTP ${error.statusCode}): ${error.message}',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                maxLength: 255,
                decoration: InputDecoration(
                  hintText: 'Portfolio Website',
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) => _title = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title cannot be empty.';
                  }
                  if (value.trim().length > 255) {
                    return 'Title must be 255 characters or fewer.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe your project',
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description cannot be empty.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '1, 2',
                  labelText: 'Tech Stack (tag IDs, comma-separated)',
                  helperText: 'Use existing TechTag IDs from the web app.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) => _techStack = value,
                validator: _validateTechStack,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'https://github.com/username/project',
                  labelText: 'Project URL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) => _projectUrl = value,
                validator: (value) =>
                    _validateUrl(value, fieldName: 'Project URL'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'https://example.com/project-image.png',
                  labelText: 'Project Image URL (Optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (value) => _projectImageUrl = value,
                validator: (value) =>
                    _validateUrl(value, fieldName: 'Project image URL'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
