# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_OPTIONAL=true
PYTHON_COMPAT=( python3_{9..10} )

inherit bash-completion-r1 distutils-r1

DESCRIPTION="Scripts to make the life of a Debian Package maintainer easier"
HOMEPAGE="https://salsa.debian.org/debian/devscripts"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python test"

CDEPEND="
	dev-lang/perl:=
	dev-perl/File-DesktopEntry
	dev-perl/File-DirList
	dev-perl/File-HomeDir
	dev-perl/File-Touch
	dev-perl/IPC-Run
	dev-perl/Moo
	dev-perl/libwww-perl
	dev-util/distro-info
	python? ( ${PYTHON_DEPS} )
"
DEPEND="
	${CDEPEND}
	app-text/docbook-xsl-stylesheets
	test? (
		app-arch/zip
		dev-perl/Git-Wrapper
		dev-perl/GitLab-API-v4
		dev-perl/List-Compare
		dev-perl/Software-License
		dev-perl/String-ShellQuote
		dev-perl/UNIVERSAL-require
		dev-python/pyftpdlib[${PYTHON_USEDEP}]
		dev-python/python-debian[${PYTHON_USEDEP}]
		dev-util/shunit2
		dev-vcs/subversion
		sys-libs/libfaketime
		virtual/perl-DB_File
	)
"
RDEPEND="
	${CDEPEND}
	app-arch/dpkg
	app-crypt/gnupg
	app-text/wdiff
	!dev-util/checkbashisms
	dev-util/debhelper
	dev-util/patchutils
	sys-apps/fakeroot
"
BDEPEND="virtual/pkgconfig"

REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
	test? ( python )
"
RESTRICT="!test? ( test )"
PATCHES=(
	"${FILESDIR}/distutils-r1.patch"
	"${FILESDIR}/Remove-failing-tests.patch"
	"${FILESDIR}/Replace-Debian-xsl-stylesheets-paths-with-Gentoos.patch"
)

DISTUTILS_S="${S}/scripts"

src_prepare() {
	default

	# Avoid file collision with app-shells/bash-completion
	rm "${DISTUTILS_S}/bts.bash_completion" || die
}

src_configure() {
	default

	if use python; then
		pushd "${DISTUTILS_S}" > /dev/null || die
		python_foreach_impl distutils-r1_src_configure
		popd > /dev/null || die
	fi
}

src_compile() {
	default

	if use python; then
		pushd "${DISTUTILS_S}" > /dev/null || die
		python_foreach_impl distutils-r1_src_compile
		popd > /dev/null || die
	fi
}

src_install() {
	dodir /usr/bin
	default

	if use python; then
		pushd "${DISTUTILS_S}" > /dev/null || die
		python_foreach_impl distutils-r1_src_install
		popd > /dev/null || die
	fi

	mv "${ED}/usr/share/doc/${PN}" "${ED}/usr/share/doc/${PF}" || die

	rm "${ED}/usr/share/bash-completion/completions/debcheckout" || die
	mv "${ED}"/usr/share/bash-completion/completions/{pkgnames,debsnap} || die
	bashcomp_alias debsnap wnpp-alert wnpp-check mk-build-deps rmadison mass-bug dd-list build-rdeps who-uploads transition-check getbuildlog grep-excuses rc-alert whodepends dget pts-subscribe pts-unsubscribe
}

src_test() {
	default

	pushd "${DISTUTILS_S}" > /dev/null || die
	python_foreach_impl distutils-r1_src_test
	popd > /dev/null || die
}
