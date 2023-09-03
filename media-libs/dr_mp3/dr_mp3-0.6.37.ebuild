# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Single-header MP3 audio decoder library"
HOMEPAGE="https://github.com/mackron/dr_libs/"
COMMIT="1b0bc87c6b9b04052e6ef0117396dab8482c250e"
SRC_URI="!test? ( https://raw.githubusercontent.com/mackron/dr_libs/${COMMIT}/dr_mp3.h -> ${P}.h )
		  test? ( https://github.com/mackron/dr_libs/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz )"
LICENSE="|| ( MIT-0 public-domain )"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

S="${WORKDIR}/dr_libs-${COMMIT}"

# Unfortunately, the only other test is interactive.
TESTCASES=(
	dr_mp3_test_0.c
)

src_unpack() {
	default
	unpack "${FILESDIR}"/${P}-docs.tar.xz
}

src_prepare() {
	if use test; then
		# Remove some unused parts of the source tree that could contribute different
		# (but acceptable) license terms if they were used—just to prove that we do not
		# use them.
		rm -rv old || die
	fi
	default
}

src_compile() {
	if use test; then
		local MY_{CC,BUILD}
		MY_CC=$(tc-getCC)

		pushd tests > /dev/null || die
		for tcase in ${TESTCASES[@]}; do
			einfo "Compiling test case ${tcase}."
			MY_BUILD="${MY_CC} mp3/${tcase} -o bin/${tcase} ${CFLAGS} ${CPPFLAGS}"
			${MY_BUILD} || die "Build failed: ${MY_BUILD}"
		done
		popd || die
	fi
}

src_test() {
	pushd tests > /dev/null || die
	for tcase in ${TESTCASES[@]}; do
		einfo "Running test case ${tcase}."
		./bin/${tcase} || die "Test case ${tcase} failed."
	done
	popd || die
}

src_install() {
	einstalldocs
	if use test; then
		doheader dr_mp3.h
	else
		newheader "${DISTDIR}"/${P}.h dr_mp3.h
	fi
}
