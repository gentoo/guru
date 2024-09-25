project('libtess2', 'c',
version : '0.12.0',
default_options : [
  'buildtype=release',
  'optimization=3',
  'default_library=static',
  'prefer_static=true',
  'b_ndebug=if-release',
  'c_args=-pipe',
  'cpp_args=-pipe',
]
)

inc = include_directories(
  'Include',
  'Source'
)

install_headers('Include/tesselator.h')

sources = files(
  'Source/bucketalloc.c',
  'Source/dict.c',
  'Source/geom.c',
  'Source/mesh.c',
  'Source/priorityq.c',
  'Source/sweep.c',
  'Source/tess.c',
)

lib = library('tess2',
  sources,
  include_directories: inc,
  install: true)

pkg = import('pkgconfig')
pkg.generate(lib)
