from pathlib import Path

modules = [
    'auth', 'users', 'roles', 'companies', 'branches', 'warehouses', 'inventory',
    'medicines', 'batches', 'distributors', 'representatives', 'pharmacies',
    'wholesales', 'factories', 'tracking', 'audit', 'reports', 'chat',
    'ai_assistant', 'fingerprint', 'settings'
]

model_template = """class {0} {{
  const {0}({{
    required this.id,
    required this.name,
    this.status = 'ready',
  }});

  final String id;
  final String name;
  final String status;
}}
"""

repo_template = """class {0} {{
  const {0}();

  Future<List<Map<String, dynamic>>> fetchAll() async => const <Map<String, dynamic>>[];
  Future<Map<String, dynamic>> fetchById(String id) async => <String, dynamic>{{'id': id}};
}}
"""

service_template = """import '../repositories/{0}_repository.dart';

class {1} {{
  const {1}({{ this.repository = const {2}() }});

  final {2} repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}}
"""

provider_template = """import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/{0}_service.dart';

final {1} = Provider<{2}>((ref) => const {2}());
"""

screen_template = """import 'package:flutter/material.dart';

class {0} extends StatelessWidget {{
  const {0}(super.key);

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(title: Text('{1}')),
      body: Center(
        child: Text('Clean Architecture placeholder for {1}'),
      ),
    );
  }}
}}
"""

for mod in modules:
    base = Path('lib/features') / mod
    (base / 'domain' / 'models').mkdir(parents=True, exist_ok=True)
    (base / 'data' / 'repositories').mkdir(parents=True, exist_ok=True)
    (base / 'data' / 'services').mkdir(parents=True, exist_ok=True)
    (base / 'application' / 'providers').mkdir(parents=True, exist_ok=True)
    (base / 'presentation' / 'screens').mkdir(parents=True, exist_ok=True)

    class_name = ''.join(x.capitalize() for x in mod.split('_'))
    model_name = f'{class_name}Model'
    repo_name = f'{class_name}Repository'
    service_name = f'{class_name}Service'
    provider_name = f'{mod.replace("-", "_")}Provider'
    screen_name = f'{class_name}Screen'

    (base / 'domain' / 'models' / f'{mod}_model.dart').write_text(model_template.format(model_name), encoding='utf-8')
    (base / 'data' / 'repositories' / f'{mod}_repository.dart').write_text(repo_template.format(repo_name), encoding='utf-8')
    (base / 'data' / 'services' / f'{mod}_service.dart').write_text(service_template.format(mod, service_name, repo_name), encoding='utf-8')
    (base / 'application' / 'providers' / f'{mod}_provider.dart').write_text(provider_template.format(mod, provider_name, service_name), encoding='utf-8')
    (base / 'presentation' / 'screens' / f'{mod}_screen.dart').write_text(screen_template.format(screen_name, class_name), encoding='utf-8')

    print('created', mod)
