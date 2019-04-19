yaffa_sources = [
  'main.vala',
  'Services/RedditJsonService.vala',
  'Widgets/ScrollWindow.vala',
  'Widgets/MainToolbar.vala',
  'Widgets/Post.vala',
  'Widgets/Preview.vala',
  'Models/Post.vala',
]

yaffa_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('libsoup-2.4', version: '>=2.4'),
  dependency('json-glib-1.0', version: '>=1.0'),
  dependency('gee-0.8',version: '>0.8'),
]

gnome = import('gnome')

yaffa_sources += gnome.compile_resources('yaffa-resources',
  'yaffa.gresource.xml',
  c_name: 'yaffa'
)

executable('yaffa', yaffa_sources,
  vala_args: '--target-glib=2.50',  dependencies: yaffa_deps,
  install: true,
)
