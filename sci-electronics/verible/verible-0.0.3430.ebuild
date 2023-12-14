# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

# From release tag name
MY_PV="0.0-3430-g060bde0f"

inherit bazel

DESCRIPTION="SystemVerilog parser, style-linter, and formatter"
HOMEPAGE="
	https://chipsalliance.github.io/verible/
	https://github.com/chipsalliance/verible
"

# Generated with:
# git clone git@github.com:chipsalliance/verible.git
# git checkout v${MY_PV}
# cd verible
# cat WORKSPACE | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u
bazel_external_uris="
	https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz
	https://github.com/abseil/abseil-cpp/archive/35e8e3f7a2c6972d4c591448e8bbe4f9ed9f815a.zip -> abseil-cpp-35e8e3f7a2c6972d4c591448e8bbe4f9ed9f815a.zip
	https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz -> bazelbuild_bazel_skylib-1.3.0.tar.gz
	https://github.com/bazelbuild/platforms/releases/download/0.0.6/platforms-0.0.6.tar.gz -> bazelbuild_platforms-0.0.6.tar.gz
	https://github.com/bazelbuild/rules_cc/archive/e7c97c3af74e279a5db516a19f642e862ff58548.zip -> bazelbuild_rules_cc-0.0.0_e7c97c3af74e279a5db516a19f642e862ff58548.zip
	https://github.com/bazelbuild/rules_license/releases/download/0.0.4/rules_license-0.0.4.tar.gz -> bazelbuild_rules_license-0.0.4.tar.gz
	https://github.com/bazelbuild/rules_proto/archive/refs/tags/4.0.0-3.20.0.tar.gz -> bazelbuild_rules_proto-4.0.0-3.20.0.tar.gz
	https://github.com/bazelbuild/rules_python/releases/download/0.2.0/rules_python-0.2.0.tar.gz -> bazelbuild_rules_python-0.2.0.tar.gz
	https://github.com/c0fec0de/anytree/archive/2.8.0.tar.gz -> anytree-2.8.0.tar.gz
	https://github.com/google/bazel_rules_install/archive/5ae7c2a8d22de2558098e3872fc7f3f7edc61fb4.zip -> bazel_rules_install-5ae7c2a8d22de2558098e3872fc7f3f7edc61fb4.zip
	https://github.com/google/boringssl/archive/d345d68d5c4b5471290ebe13f090f1fd5b7e8f58.zip -> boringssl-d345d68d5c4b5471290ebe13f090f1fd5b7e8f58.zip
	https://github.com/google/googletest/archive/refs/tags/release-1.12.1.zip -> googletest-release-1.12.1.zip
	https://github.com/google/re2/archive/215bf4aa0bdc081862590463bc98a00bb2be48f2.zip -> re2-215bf4aa0bdc081862590463bc98a00bb2be48f2.zip
	https://github.com/grailbio/bazel-compilation-database/archive/940cedacdb8a1acbce42093bf67f3a5ca8b265f7.tar.gz -> grailbio_bazel_compilation_database-940cedacdb8a1acbce42093bf67f3a5ca8b265f7.tar.gz
	https://github.com/jmillikin/rules_bison/releases/download/v0.2.1/rules_bison-v0.2.1.tar.xz
	https://github.com/jmillikin/rules_flex/releases/download/v0.2/rules_flex-v0.2.tar.xz
	https://github.com/jmillikin/rules_m4/releases/download/v0.2.2/rules_m4-v0.2.2.tar.xz
	https://github.com/lexxmark/winflexbison/releases/download/v2.5.25/win_flex_bison-2.5.25.zip
	https://github.com/nlohmann/json/archive/refs/tags/v3.10.2.tar.gz
	https://github.com/protocolbuffers/protobuf/releases/download/v22.0/protobuf-22.0.tar.gz
	https://zlib.net/fossils/zlib-1.2.13.tar.gz
	mirror://gnu/m4/m4-1.4.18.tar.xz
	https://mirror.bazel.build/github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz
	https://github.com/bazelbuild/rules_python/archive/912a5051f51581784fd64094f6bdabf93f6d698f.zip -> bazelbuild_rules_python-912a5051f51581784fd64094f6bdabf93f6d698f.zip
	https://github.com/protocolbuffers/utf8_range/archive/de0b4a8ff9b5d4c98108bdfe723291a33c52c54f.zip -> protocolbuffers_utf8_range-de0b4a8ff9b5d4c98108bdfe723291a33c52c54f.zip
	https://github.com/protocolbuffers/rules_ruby/archive/5cf6ff74161d7f985b9bf86bb3c5fb16cef6337b.zip -> protocolbuffers_rules_ruby-5cf6ff74161d7f985b9bf86bb3c5fb16cef6337b.zip
	https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.7.0/rules_pkg-0.7.0.tar.gz -> bazelbuild_rules_pkg-0.7.0.tar.gz
	https://github.com/bazelbuild/rules_java/archive/981f06c3d2bd10225e85209904090eb7b5fb26bd.zip -> bazelbuild_rules_java-981f06c3d2bd10225e85209904090eb7b5fb26bd.zip
	https://mirror.bazel.build/bazel_coverage_output_generator/releases/coverage_output_generator-v2.5.zip -> bazelbuild_bazel_coverage_output_generator-2.5.zip
	https://github.com/protocolbuffers/upb/archive/1fb480bc76bc0e331564d672e60b97a388aa3f76.zip -> protocolbuffers_upb-1fb480bc76bc0e331564d672e60b97a388aa3f76.zip
	https://github.com/madler/zlib/releases/download/v1.2.13/zlib-1.2.13.tar.xz
	https://mirror.bazel.build/bazel_java_tools/releases/java/v11.7.1/java_tools-v11.7.1.zip
	https://mirror.bazel.build/openjdk/azul-zulu11.50.19-ca-jdk11.0.12/zulu11.50.19-ca-jdk11.0.12-linux_x64.tar.gz
	https://mirror.bazel.build/bazel_java_tools/releases/java/v11.7.1/java_tools_linux-v11.7.1.zip
	https://github.com/jmillikin/rules_m4/releases/download/v0.1/m4-gnulib-788db09a9f88abbef73c97e8d7291c40455336d8.tar.xz
	https://github.com/jmillikin/rules_m4/releases/download/v0.2.3/rules_m4-v0.2.3.tar.xz
	https://github.com/jmillikin/rules_flex/releases/download/v0.2.1/rules_flex-v0.2.1.tar.xz
	https://github.com/protocolbuffers/protobuf/releases/download/v23.4/protobuf-23.4.tar.gz
	https://github.com/protocolbuffers/upb/archive/455cfdb8ae60a1763e6d924e36851c6897a781bb.zip -> protocolbuffers_upb-455cfdb8ae60a1763e6d924e36851c6897a781bb.zip
	https://github.com/google/re2/archive/refs/tags/2023-06-01.tar.gz -> re2-2023-06-01.tar.gz
"

SRC_URI="
	https://github.com/chipsalliance/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
	${bazel_external_uris}
"

S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	sys-libs/zlib
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	app-arch/unzip
	sys-devel/bison
	sys-devel/flex
	sys-devel/m4
"

src_unpack() {
	unpack "${P}.tar.gz"
	bazel_load_distfiles "${bazel_external_uris}"
}

src_prepare() {
	bazel_setup_bazelrc
	default
}

src_compile() {
	export JAVA_HOME=$(java-config --jre-home)
	export GIT_DATE="$(date -r WORKSPACE "+%Y-%m-%d")"
	export GIT_VERSION="v${MY_PV}"

	ebazel build -c opt --//bazel:use_local_flex_bison //...
	ebazel shutdown
}

src_test() {
	ebazel test -c opt --//bazel:use_local_flex_bison //...
}

src_install() {
	ebazel run -c opt --//bazel:use_local_flex_bison //:install -- "${D}/usr/bin"
	ebazel shutdown
}
