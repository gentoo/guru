# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

# From release tag name
MY_PV="0.0-2275-gf82fe35e"

inherit bazel

DESCRIPTION="SystemVerilog parser, style-linter, and formatter"
HOMEPAGE="
	https://chipsalliance.github.io/verible/
	https://github.com/chipsalliance/verible
"

# From $(cat WORKSPACE | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u)
bazel_external_uris="
	https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz
	https://github.com/abseil/abseil-cpp/archive/refs/tags/20220623.0.zip -> abseil-cpp-20220623.0.zip
	https://github.com/abseil/abseil-py/archive/refs/tags/v1.2.0.tar.gz -> abseil-py-1.2.0.tar.gz
	https://github.com/bazelbuild/bazel-toolchains/releases/download/3.4.0/bazel-toolchains-3.4.0.tar.gz
	https://github.com/bazelbuild/platforms/archive/da5541f26b7de1dc8e04c075c99df5351742a4a2.zip -> platforms-da5541f26b7de1dc8e04c075c99df5351742a4a2.zip
	https://github.com/bazelbuild/rules_cc/archive/e7c97c3af74e279a5db516a19f642e862ff58548.zip -> rules_cc-e7c97c3af74e279a5db516a19f642e862ff58548.zip
	https://github.com/bazelbuild/rules_java/archive/981f06c3d2bd10225e85209904090eb7b5fb26bd.zip -> bazel_rules_java-981f06c3d2bd10225e85209904090eb7b5fb26bd.zip
	https://github.com/bazelbuild/rules_proto/archive/97d8af4dc474595af3900dd85cb3a29ad28cc313.tar.gz -> rules_proto-97d8af4dc474595af3900dd85cb3a29ad28cc313.tar.gz
	https://github.com/bazelbuild/rules_proto/archive/refs/tags/4.0.0-3.20.0.tar.gz -> rules_proto-4.0.0-3.20.0.tar.gz
	https://github.com/bazelbuild/rules_python/archive/refs/tags/0.8.0.tar.gz -> rules_python-0.8.0.tar.gz
	https://github.com/bazelbuild/rules_python/releases/download/0.2.0/rules_python-0.2.0.tar.gz
	https://github.com/c0fec0de/anytree/archive/2.8.0.tar.gz -> anytree-2.8.0.tar.gz
	https://github.com/gflags/gflags/archive/827c769e5fc98e0f2a34c47cef953cc6328abced.zip -> gflags-827c769e5fc98e0f2a34c47cef953cc6328abced.zip
	https://github.com/google/bazel_rules_install/archive/5ae7c2a8d22de2558098e3872fc7f3f7edc61fb4.zip -> bazel_rules_install-5ae7c2a8d22de2558098e3872fc7f3f7edc61fb4.zip
	https://github.com/google/glog/archive/v0.5.0-rc2.tar.gz -> glog-v0.5.0-rc2.tar.gz
	https://github.com/google/googletest/archive/refs/tags/release-1.12.1.zip -> googletest-release-1.12.1.zip
	https://github.com/google/re2/archive/215bf4aa0bdc081862590463bc98a00bb2be48f2.zip -> re2-215bf4aa0bdc081862590463bc98a00bb2be48f2.zip
	https://github.com/grailbio/bazel-compilation-database/archive/ace73b04e76111afa09934f8771a2798847e724e.tar.gz -> bazel-compilation-database-ace73b04e76111afa09934f8771a2798847e724e.tar.gz
	https://github.com/jmillikin/rules_bison/releases/download/v0.2.1/rules_bison-v0.2.1.tar.xz
	https://github.com/jmillikin/rules_flex/releases/download/v0.2/rules_flex-v0.2.tar.xz
	https://github.com/jmillikin/rules_m4/releases/download/v0.1/m4-gnulib-788db09a9f88abbef73c97e8d7291c40455336d8.tar.xz
	https://github.com/jmillikin/rules_m4/releases/download/v0.2.2/rules_m4-v0.2.2.tar.xz
	https://github.com/lexxmark/winflexbison/releases/download/v2.5.18/win_flex_bison-2.5.18.zip
	https://github.com/madler/zlib/archive/v1.2.11.tar.gz -> zlib-v1.2.11.tar.gz
	https://github.com/nlohmann/json/archive/refs/tags/v3.10.2.tar.gz -> json-v3.10.2.tar.gz
	https://github.com/protocolbuffers/protobuf/archive/v21.5.zip -> protobuf-v21.5.zip
	https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz
	https://mirror.bazel.build/bazel_coverage_output_generator/releases/coverage_output_generator-v2.5.zip -> bazel_coverage_output_generator-v2.5.zip
	https://mirror.bazel.build/bazel_java_tools/releases/java/v11.6/java_tools_linux-v11.6.zip -> bazel_java_tools_linux-v11.6.zip
	https://mirror.bazel.build/bazel_java_tools/releases/java/v11.6/java_tools-v11.6.zip -> bazel_java_tools-v11.6.zip
	https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz
	https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.7.0/rules_pkg-0.7.0.tar.gz
	https://mirror.bazel.build/openjdk/azul-zulu11.50.19-ca-jdk11.0.12/zulu11.50.19-ca-jdk11.0.12-linux_x64.tar.gz
	https://zlib.net/fossils/zlib-1.2.11.tar.gz
	https://zlib.net/fossils/zlib-1.2.12.tar.gz
	mirror://gnu/m4/m4-1.4.18.tar.xz
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
