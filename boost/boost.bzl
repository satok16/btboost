include_pattern = "boost/%s/"
hdrs_patterns = [
  "boost/%s.h",
  "boost/%s_fwd.h",
  "boost/%s.hpp",
  "boost/%s_fwd.hpp",
  "boost/%s/**/*.hpp",
  "boost/%s/**/*.ipp",
  "boost/%s/**/*.h",
  "libs/%s/src/*.ipp",
]
srcs_patterns = [
  "libs/%s/src/*.cpp",
  "libs/%s/src/*.hpp",
]

# Building boost results in many warnings for unused values. Downstream users
# won't be interested, so just disable the warning.
default_copts = ["-Wno-unused-value"]

def srcs_list(library_name):
  return native.glob([p % (library_name,) for p in srcs_patterns])

def includes_list(library_name):
  return [".", include_pattern % library_name]

def hdr_list(library_name):
  return native.glob([p % (library_name,) for p in hdrs_patterns])

def boost_library(name, defines=None, includes=None, hdrs=None, textual_hdrs=None, srcs=None, deps=None, copts=None, linkstatic=0, alwayslink=0, linkopts=[]):
  if defines == None:
    defines = []

  if includes == None:
    includes = []

  if hdrs == None:
    hdrs = []

  if textual_hdrs == None:
    textual_hdrs = []

  if srcs == None:
    srcs = []

  if deps == None:
    deps = []

  if copts == None:
    copts = []

  native.cc_library(
    alwayslink = alwayslink,
    name = name,
    visibility = ["//visibility:public"],
    defines = defines,
    includes = includes_list(name) + includes,
    hdrs = hdr_list(name) + hdrs,
    textual_hdrs = textual_hdrs,
    srcs = srcs_list(name) + srcs,
    deps = deps,
    copts = default_copts + copts,
    linkstatic = linkstatic,
    linkopts = linkopts,
    licenses = ["notice"],
  )

  native.cc_library(
    alwayslink = 1,
    name = name + "_static",
    visibility = ["//visibility:public"],
    defines = defines,
    includes = includes_list(name) + includes,
    hdrs = hdr_list(name) + hdrs,
    textual_hdrs = textual_hdrs,
    srcs = srcs_list(name) + srcs,
    deps = deps,
    copts = default_copts + copts,
    linkstatic = 1,
    linkopts = ["-fPIC", "-Wl,--allow-multiple-definition", "-Wl,--whole-archive" ] + linkopts,
    licenses = ["notice"],
  )

def boost_deps():
  native.new_http_archive(
    name = "boost",
    url = "https://storage.googleapis.com/satok_coldline_bucket_us/bt_public/boost_1_63_0.tar.bz2",
    build_file = "@com_github_satok16_btboost//:BUILD.boost",
    type = "tar.bz2",
    strip_prefix = "boost_1_63_0/",
    sha256 = "beae2529f759f6b3bf3f4969a19c2e9d6f0c503edcb2de4a61d1428519fcb3b0",
  )
