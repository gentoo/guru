# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc"

PYTHON_COMPAT=( python3_{12..15} )

inherit check-reqs desktop edo flag-o-matic java-pkg-2 multiprocessing python-single-r1 toolchain-funcs virtualx xdg

DESCRIPTION="Software reverse engineering (SRE) framework"
HOMEPAGE="https://github.com/NationalSecurityAgency/ghidra"
SRC_URI="
	https://github.com/NationalSecurityAgency/ghidra/archive/refs/tags/Ghidra_${PV}_build.tar.gz -> ${P}.tar.gz
	https://github.com/NationalSecurityAgency/ghidra-data/raw/Ghidra_${PV}/lib/java-sarif-2.1-modified.jar

	https://codeberg.org/minorum/gentoo-dist/releases/download/${P}-maven/${P}-maven-deps.tar.gz
"

for fidb in vs{2012,2015,2017,2019,Older}_{x64,x86}; do
	SRC_URI+="
		https://github.com/NationalSecurityAgency/ghidra-data/raw/Ghidra_${PV}/FunctionID/${fidb}.fidb
			-> ${P}-${fidb}.fidb
	"
done
unset fidb

S="${WORKDIR}/${PN}-Ghidra_${PV}_build"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 CC-BY-2.5 EPL-2.0
	GPL-2 GPL-2-with-classpath-exception GPL-3 JDOM LGPL-2.1 LGPL-2.1+ LGPL-3 MIT
	MPL-2.0 POSTGRESQL PSF-2 PSF-2.4 ZLIB public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+python"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CHECKREQS_DISK_BUILD="3G"

QA_PREBUILT="
	opt/ghidra/docs/GhidraClass/ExerciseFiles/*
"

COMMON_DEPEND="
	dev-java/axmlprinter2:0
	>=dev-java/protobuf-java-4.33.5:0
	sci-mathematics/z3:=[java]
	virtual/zlib:=
"

RDEPEND="
	${COMMON_DEPEND}
	${PYTHON_DEPS}
	>=virtual/jdk-25:*[-headless-awt]
	$(python_gen_cond_dep '
		>=dev-python/protobuf-6.33.5[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	')
	>=dev-java/yajsw-14.01
"

PDEPEND="
	python? (
		$(python_gen_cond_dep '
			>=dev-python/pyghidra-3.2.0[${PYTHON_USEDEP}]
		')
	)
"

DEPEND="
	${COMMON_DEPEND}
	virtual/jdk:25
	test? ( virtual/jdk:25[-headless-awt] )
	dev-java/javacc:7.0.13
"

BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	')
	app-arch/unzip
	>=dev-java/gradle-bin-9.1
	>=dev-libs/protobuf-31.1[protoc(+)]
	<dev-libs/protobuf-33.6
	dev-util/pkgconf
"

pkg_setup() {
	check-reqs_pkg_setup
	java-pkg-2_pkg_setup
	python-single-r1_pkg_setup
}

# Keep bundled DMG/HFS libraries.
JAVA_PKG_NO_CLEAN=(
	"*/GPL/DMG/data/lib/*.jar"
)

PATCHES=(
	"${FILESDIR}"/ghidra-12.2-system-axmlprinter2.patch
	"${FILESDIR}"/ghidra-12.2-system-z3.patch
	"${FILESDIR}"/ghidra-12.2-system-python.patch
	"${FILESDIR}"/ghidra-12.2-system-protobuf.patch
	"${FILESDIR}"/ghidra-12.2-no-prebuilt-tlb.patch
	"${FILESDIR}"/ghidra-12.2-javacc7-dependency.patch
	"${FILESDIR}"/ghidra-12.2-native-build.patch
	"${FILESDIR}"/ghidra-12.2-system-yajsw.patch
	"${FILESDIR}"/ghidra-12.2-filesystem-paths.patch
	"${FILESDIR}"/ghidra-12.2-no-eclipse-plugins.patch
)

src_prepare() {
	default

	java-pkg-2_src_prepare
	java-pkg_clean
	sed -i "s|@GENTOO_EPREFIX@|${EPREFIX}|g" \
		Ghidra/RuntimeScripts/server/server.conf \
		Ghidra/RuntimeScripts/server/ghidraSvr || die
	sed -i '/^#ENVVARS_LINUX=_JAVA_AWT_WM_NONREPARENTING=1$/s/^#//' \
		Ghidra/RuntimeScripts/support/launch.properties || die

	local fidb
	for fidb in vs{2012,2015,2017,2019,Older}_{x64,x86}; do
		install -Dm644 "${DISTDIR}/${P}-${fidb}.fidb" \
			"dependencies/fidb/${fidb}.fidb" || die
	done

	# gradle resolves these from flatRepo by their upstream names
	install -Dm644 -t dependencies/flatRepo \
		"${DISTDIR}"/java-sarif-2.1-modified.jar || die

	mkdir -p "${T}/.m2" || die
	mv "${WORKDIR}/maven-deps" "${T}/.m2/repository" || die
	sed -i \
		-e 's/^application\.release\.name=DEV$/application.release.name=PUBLIC/' \
		-e "s/^application\.python\.supported=.*/application.python.supported=${EPYTHON#python}/" \
		Ghidra/application.properties || die

	local compiler
	for compiler in CC CXX; do
		printf '#!/bin/sh\nexec ${%s} "$@"\n' "${compiler}" > "${T}/${compiler}" || die
		chmod +x "${T}/${compiler}" || die
	done
}

_ghidra_gradle() {
	local gradle
	gradle=$(best_version -b '>=dev-java/gradle-bin-9.1') || die
	[[ -n ${gradle} ]] || die "No supported Gradle installed"
	gradle=${gradle##*/}
	gradle=${gradle%-r*}

	local -x JAVA_TOOL_OPTIONS="-Duser.home=${T}"
	local -x GENTOO_Z3_JAR="${ESYSROOT}/usr/share/java/com.microsoft.z3.jar"
	local -x GENTOO_AXMLPRINTER2_JAR GENTOO_JAVACC_CLASSPATH GENTOO_PROTOBUF_JAR
	local -x GENTOO_CC="${T}/CC" GENTOO_CXX="${T}/CXX"
	local -x ZLIB_CFLAGS ZLIB_LIBS

	tc-export CC CXX
	ZLIB_CFLAGS=$("$(tc-getPKG_CONFIG)" --cflags zlib) || die
	ZLIB_LIBS=$("$(tc-getPKG_CONFIG)" --libs zlib) || die

	GENTOO_AXMLPRINTER2_JAR=$(java-pkg_getjar axmlprinter2 axmlprinter2.jar) || die
	GENTOO_JAVACC_CLASSPATH=$(java-pkg_getjars --build-only javacc-7.0.13) || die
	GENTOO_PROTOBUF_JAR=$(java-pkg_getjar protobuf-java protobuf.jar) || die

	edo "${gradle}" \
		--console=plain \
		--offline \
		--no-daemon \
		--no-build-cache \
		--gradle-user-home "${T}/gradle_user_home" \
		--project-cache-dir "${T}/gradle_project_cache" \
		--init-script "${FILESDIR}"/ghidra-12.2-gentoo.init.gradle \
		--parallel --max-workers="$(get_makeopts_jobs)" \
		"$@"
}

src_compile() {
	# Generated parsers have conflicting yyalloc types.
	filter-lto

	# Extensions need a separate target.
	_ghidra_gradle assembleAll zipExtensions $(usev doc createJavadocs)
}

src_test() {
	# Swing tests need a display.
	virtx _ghidra_gradle --continue test
}

src_install() {
	local dest="/opt/${PN}"

	# cp -a: ghidra ships executables
	dodir "${dest}"
	cp -a build/dist/ghidra_*/. "${ED}${dest}"/ || die

	insinto /etc/ghidra
	local config
	for config in server/server.conf server/jaas.conf support/launch.properties; do
		doins "${ED}${dest}/${config}"
		rm "${ED}${dest}/${config}" || die
		dosym -r "/etc/ghidra/${config##*/}" "${dest}/${config}"
	done
	keepdir /var/lib/ghidra/repositories /var/log/ghidra

	insinto "${dest}"/Extensions/Ghidra
	doins build/dist/ghidra_*_*.zip

	dosym -r "${dest}/ghidraRun" /usr/bin/ghidra

	use doc && java-pkg_dojavadoc build/tmp/javadoc

	doicon Ghidra/Framework/Gui/src/main/resources/images/GhidraIcon64.png
	make_desktop_entry ghidra Ghidra GhidraIcon64 "Development;Security;"
}
