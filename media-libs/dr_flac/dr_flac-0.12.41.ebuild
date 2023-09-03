# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Single-header FLAC audio decoder library"
HOMEPAGE="https://github.com/mackron/dr_libs/"
declare -A COMMITS=(
	[dr_flac]="353bdc08bd90b24832a5eb149b2c4fd770a650f6"
	[testbench]="4a19dc2ddb9ee3ac083abaa99faa3a0b7230f833"
)
SRC_URI="!test? ( https://raw.githubusercontent.com/mackron/dr_libs/${COMMITS[dr_flac]}/dr_flac.h -> ${P}.h )
		  test? ( https://github.com/mackron/dr_libs/archive/${COMMITS[dr_flac]}.tar.gz -> ${P}.gh.tar.gz
				  https://github.com/ietf-wg-cellar/flac-test-files/archive/${COMMITS[testbench]}.tar.gz
				  -> ${P}-testbench.gh.tar.gz )"

LICENSE="|| ( MIT-0 public-domain )"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( media-libs/flac )"

TESTCASES=(
	dr_flac_seeking.c
	dr_flac_{decoding,test_0}.{c,cpp}
)

S="${WORKDIR}/dr_libs-${COMMITS[dr_flac]}"

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

		# Sanitize testbench and move to expected location
		find "${WORKDIR}"/flac-test-files-${COMMITS[testbench]}/subset -type f \
			 \! -name "*.flac" -delete || die
		mv -T "${WORKDIR}"/flac-test-files-${COMMITS[testbench]}/subset \
		   tests/testvectors/flac/testbench || die

		# Disable profiling tests as they are not relevant downstream.
		for tcase in ${TESTCASES[@]}; do
			sed -i "s/doProfiling = DRFLAC_TRUE/doProfiling = DRFLAC_FALSE/" \
				tests/flac/$tcase || die "sed failed on tests/flac/$tcase"
		done

	fi
	default
}

src_compile() {
	if use test; then
		local MY_{C,CC,CXX,BUILD,FLAGS}
		MY_CC=$(tc-getCC)
		MY_CXX=$(tc-getCXX)

		pushd tests > /dev/null || die
		for tcase in ${TESTCASES[@]}; do
			einfo "Compiling test case ${tcase}."
			case ${tcase} in
				*.cpp)
					MY_C=${MY_CXX}
					MY_FLAGS=${CXXFLAGS}
					;;
				*.c)
					MY_C=${MY_CC}
					MY_FLAGS=${CFLAGS}
					;;
				*)
					die "Unknown test case ${tcase}"
					;;
			esac
			MY_BUILD="${MY_C} flac/${tcase} -o bin/${tcase} ${MY_FLAGS} ${CPPFLAGS}"
			case ${tcase%.*} in
				dr_flac_seeking)
				;&
				dr_flac_decoding)
					MY_BUILD="${MY_BUILD} -lFLAC ${LDFLAGS}"
					;;
				*)
					;;
			esac
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
		doheader dr_flac.h
	else
		newheader "${DISTDIR}"/${P}.h dr_flac.h
	fi
}
