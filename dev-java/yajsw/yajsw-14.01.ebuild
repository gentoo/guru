# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

JAVA_PKG_WANT_BUILD_VM="openjdk-21 openjdk-bin-21"
JAVA_PKG_WANT_SOURCE="21"
JAVA_PKG_WANT_TARGET="21"

inherit edo edos2unix java-pkg-2 multiprocessing prefix

MY_P="${PN}-stable-${PV}"

DESCRIPTION="Yet Another Java Service Wrapper, runs any application as a daemon"
HOMEPAGE="https://yajsw.sourceforge.io/"
SRC_URI="
	https://sourceforge.net/projects/yajsw/files/yajsw/${MY_P}/${MY_P}.zip/download
		-> ${MY_P}.zip
"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-1.1 Apache-2.0 BSD BSD-2 CC-BY-2.5 GPL-2+ LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="
	>=dev-java/automaton-1.11.8:0
	dev-java/commons-beanutils:0
	>=dev-java/commons-cli-1.11.0:0
	>=dev-java/commons-collections-4.5.0:4
	>=dev-java/commons-io-2.21.0:0
	>=dev-java/commons-lang-3.20.0:0
	>=dev-java/commons-logging-1.3.6:0
	>=dev-java/commons-text-1.15.0:0
	>=dev-java/commons-vfs-2.0:2
	>=dev-java/jna-5.18.1:0
	>=dev-java/joda-time-2.13.0:0
	>=dev-java/permit-reflect-0.4:0
	>=dev-java/slf4j-api-2.0.3:0
	>=dev-java/slf4j-simple-2.0.3:0
	>=dev-java/velocity-2.4.1:0
"

RDEPEND="${CP_DEPEND}
	app-admin/sudo
	>=virtual/jre-21:*"

DEPEND="${CP_DEPEND}
	virtual/jdk:21"

BDEPEND="
	app-arch/unzip
	>=dev-java/gradle-bin-8.5
"

PATCHES=(
	"${FILESDIR}"/${P}-build-fixes.patch
	"${FILESDIR}"/${P}-system-libs.patch
	"${FILESDIR}"/${P}-system-native.patch
	"${FILESDIR}"/${P}-javadoc.patch
	"${FILESDIR}"/${P}-paths.patch
	"${FILESDIR}"/${P}-keystore.patch
)

DOCS=( readme.txt yajsw.policy.txt )

src_prepare() {
	edos2unix build/gradle/{build,settings,wrapper/build,wrapper-app/build}.gradle
	edos2unix src/app/src/main/java/org/rzo/yajsw/boot/WrapperLoader.java
	edos2unix src/yajsw/src/main/java/org/rzo/yajsw/os/posix/PosixProcess.java
	edos2unix conf/wrapper.conf.default

	default
	java-pkg-2_src_prepare
	sed -i "s|@GENTOO_LIBDIR@|${EPREFIX}/usr/$(get_libdir)|g" \
		src/app/src/main/java/org/rzo/yajsw/boot/WrapperLoader.java || die
	eprefixify bin/setenv.sh

	rm -r lib/core/{jna,permit} \
		lib/extended/{commons,keystore,regex,sigar,slf4j,velocity} \
		lib/groovy/{mail,joda,jasypt,snmp} || die
	find lib/core/commons -type f ! -name 'commons-configuration2-*.jar' -delete || die
	rm lib/extended/cron/{joda-time-2.7,prevayler-core-2.6,prevayler-factory-2.6}.jar || die
}

src_compile() {
	local gradle
	gradle=$(best_version -b '>=dev-java/gradle-bin-8.5') || die
	[[ -n ${gradle} ]] || die "No supported Gradle installed"
	gradle=${gradle##*/}
	gradle=${gradle%-r*}

	local packages=(
		automaton commons-beanutils commons-cli commons-collections-4
		commons-io commons-lang commons-logging commons-text commons-vfs-2 jna
		joda-time permit-reflect slf4j-api slf4j-simple velocity
	)
	local -x GENTOO_CLASSPATH
	GENTOO_CLASSPATH=$(java-pkg_getjars --with-dependencies "$(IFS=,; echo "${packages[*]}")") || die

	local -x JAVA_TOOL_OPTIONS="-Duser.home=${T}"
	local targets=( build )
	use doc && targets+=( :wrapper:javadoc )

	cd build/gradle || die
	edo "${EPREFIX}/usr/bin/${gradle}" \
		--console=plain \
		--offline \
		--no-daemon \
		--no-build-cache \
		--gradle-user-home "${T}/gradle_user_home" \
		--project-cache-dir "${T}/gradle_project_cache" \
		--parallel --max-workers="$(get_makeopts_jobs)" \
		"${targets[@]}"
}

src_install() {
	local dest="/usr/share/${PN}" b=build/gradle

	cp "${b}"/ahessian/build/libs/*.jar lib/core/yajsw/ || die
	cp "${b}"/hessian4/build/libs/*.jar lib/extended/yajsw/ || die
	cp "${b}"/groovy-patch/build/libs/*.jar lib/extended/groovy/ || die

	java-pkg_jarinto "${dest}"
	java-pkg_dojar "${b}/wrapper/build/libs/wrapper.jar"
	insinto "${dest}"
	doins "${b}/wrapper-app/build/libs/wrapperApp.jar"
	doins -r lib

	insinto /etc/yajsw
	doins conf/wrapper.conf.default

	insinto "${dest}/templates"
	doins templates/daemon.vm templates/systemd.vm

	exeinto "${dest}"/bin
	doexe bin/{wrapper,setenv,genConfig,runConsole}.sh
	doexe bin/{install,start,stop,query,uninstall}Daemon{,NoPriv}.sh

	einstalldocs

	if use doc; then
		java-pkg_dojavadoc "${b}/wrapper/build/docs/javadoc"
	fi

	if use source; then
		java-pkg_dosrc src/{yajsw,app,ahessian,hessian,groovy-patch,keystore}
	fi
}
