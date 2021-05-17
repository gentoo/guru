# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

COMMIT="ffd522e7188bef30a00c74dc7eb9de5faff90092"
DESCRIPTION="Family of better random number generators"
HOMEPAGE="https://www.pcg-random.org https://github.com/imneme/pcg-cpp"
SRC_URI="https://github.com/imneme/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

src_prepare() {
	default
	sed "s/install: all/install:/" -i Makefile || die
}

# this code installs only headers
src_compile() {
	tc-export CXX
	if use test ; then
		cd test-high || die
		emake
	fi
}

src_test() {
	cd test-high || die
	sh ./run-tests.sh || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
