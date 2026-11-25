import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final imageUrl = project.projectImageUrl.trim();
    final projectTags = project.projectTagNames.isNotEmpty
        ? project.projectTagNames.join(', ')
        : project.projectTags.join(', ');
    final technologies = project.techTagNames.isNotEmpty
        ? project.techTagNames.join(', ')
        : project.techTags.join(', ');

    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (imageUrl.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  alignment: Alignment.center,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.broken_image_outlined, size: 48),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
          Text(
            project.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(project.description),
          if (projectTags.isNotEmpty) ...[
            const SizedBox(height: 20),
            _DetailField(label: 'Project areas', value: projectTags),
          ],
          if (technologies.isNotEmpty) ...[
            const SizedBox(height: 12),
            _DetailField(label: 'Technologies', value: technologies),
          ],
          if (project.projectUrl.isNotEmpty) ...[
            const SizedBox(height: 12),
            _DetailField(label: 'Project URL', value: project.projectUrl),
          ],
          if (project.startedAt != null) ...[
            const SizedBox(height: 12),
            _DetailField(label: 'Started', value: project.startedAt!),
          ],
          if (project.endedAt != null) ...[
            const SizedBox(height: 12),
            _DetailField(label: 'Ended', value: project.endedAt!),
          ],
          const SizedBox(height: 12),
          _DetailField(label: 'Stars', value: '${project.starCount}'),
          _DetailField(
            label: 'Starred by you',
            value: project.isStarred ? 'Yes' : 'No',
          ),
          if (project.starredByNames.isNotEmpty) ...[
            const SizedBox(height: 12),
            _DetailField(label: 'Starred by', value: project.starredByNames),
          ],
        ],
      ),
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 4),
        SelectableText(value),
      ],
    );
  }
}
