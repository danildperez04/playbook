/** Ver docs/05-versionado-commits-y-ramas.md §2. */
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'fix',
        'docs',
        'style',
        'refactor',
        'perf',
        'test',
        'build',
        'ci',
        'chore',
        'revert',
      ],
    ],
    'scope-enum': [
      2,
      'always',
      [
        // Dominio del proyecto: un alcance por módulo (kebab-case). Agregar aquí.
        'auth',
        'users',
        // Transversales: no quitar.
        'api',
        'web',
        'mobile',
        'ui',
        'db',
        'deps',
        // Dependabot usa `deps-dev` para las dependencias de desarrollo.
        'deps-dev',
        'docker',
        'docs',
        'cicd',
        'repo',
      ],
    ],
    // El alcance es obligatorio: ordena el CHANGELOG y el historial.
    'scope-empty': [2, 'never'],
    'scope-case': [2, 'always', 'kebab-case'],
    'subject-case': [2, 'always', 'lower-case'],
    'header-max-length': [2, 'always', 100],
    'body-max-line-length': [2, 'always', 100],
  },
};
