# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
MY_PV="$(ver_rs 1-2 -)"
MY_P="${PN}-${MY_PV}"
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 edo flag-o-matic java-pkg-opt-2 perl-module

DESCRIPTION="Static cluster configuration database used for cluster configuration management"
HOMEPAGE="https://github.com/chaos/genders"
SRC_URI="https://github.com/chaos/${PN}/archive/${MY_P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_P}"

KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="cxx java perl python"

CDEPEND="
	perl? ( dev-lang/perl:= )
	python?	( ${PYTHON_DEPS} )
"
DEPEND="
	${CDEPEND}
	java? ( virtual/jdk:1.8 )
"
RDEPEND="
	${DEPEND}
	java? ( virtual/jre:1.8 )
"
BDEPEND="
	python? (
		${PYTHON_DEPS}
		${DISTUTILS_DEPS}
	)
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
DOCS=( README TUTORIAL NEWS )

PATCHES=( "${FILESDIR}/${PN}-1.28.1-gcc14.patch" )

src_prepare() {
	default
	sed -i "s|perl python||" src/extensions/Makefile.am || die
	sed -i "s|\$(DESTDIR)\$(docdir)-\$(VERSION)-javadoc|\$(DESTDIR)\$(docdir)/html/javadoc|" \
		src/extensions/java/Makefile.am || die
	java-pkg_clean
	edo ./autogen.sh
}

src_configure() {
	use java && append-cflags "-I${S}/src/libgenders"
	use java && append-cflags "$(java-pkg_get-jni-cflags)"

	local myconf=(
		--disable-static
		--with-non-shortened-hostnames
		$(use_with cxx cplusplus-extensions)
		$(use_with java java-extensions)
		$(use_with perl perl-extensions)
		$(use_with python python-extensions)
	)
	econf "${myconf[@]}"
}

src_compile() {
	default

	if use perl; then
		pushd "${S}/src/extensions/perl" || die
		perl-module_src_configure
		perl-module_src_compile
		popd || die
	fi

	if use python; then
		pushd "${S}/src/extensions/python" || die
		cp genderssetup.py setup.py || die
		distutils-r1_src_compile
		popd || die
	fi
}

src_test() {
	pushd src/testsuite || die
	default
	popd || die
}

src_install() {
	default

	if use perl ; then
		pushd "${S}/src/extensions/perl" || die
		unset DOCS
		myinst=( DESTDIR="${D}" )
		perl-module_src_install
		popd || die
	fi

	if use python; then
		pushd "${S}/src/extensions/python" || die
		unset DOCS
		python_install() {
			distutils-r1_python_install
		}
		distutils-r1_src_install
		popd || die
	fi

	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
