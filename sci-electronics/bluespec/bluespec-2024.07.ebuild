# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Toolchain for the Bluespec Hardware Definition Language"
HOMEPAGE="https://github.com/B-Lang-org/bsc"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/B-Lang-org/bsc.git"
	inherit git-r3
else
	SRC_URI="
		https://github.com/B-Lang-org/bsc/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/SRI-CSL/yices2/archive/refs/tags/Yices-2.6.4.tar.gz -> yices-2.6.4.tar.gz
	"
	S="${WORKDIR}/bsc-${PV}"
	S_YICES="${WORKDIR}/yices2-Yices-2.6.4"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD GPL-3+ MIT"
SLOT="${PV}"
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-eselect/eselect-bluespec
	app-shells/tcsh
	dev-haskell/old-time:0=
	dev-haskell/regex-compat:0=
	dev-haskell/split:0=
	dev-haskell/syb:0=
	dev-lang/tcl
"

DEPEND="
	${RDEPEND}
	test? (
		dev-util/dejagnu
		sci-electronics/iverilog
		sci-electronics/systemc
		sys-process/time
	)
"

BDEPEND="
	dev-haskell/cabal:0=
	dev-lang/ghc:0=
	dev-lang/perl
	dev-util/gperf
	doc? (
		dev-ruby/asciidoctor
		dev-ruby/asciidoctor-pdf
		dev-texlive/texlive-bibtexextra
		dev-texlive/texlive-fontsextra
		dev-texlive/texlive-fontutils
		dev-texlive/texlive-latex
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-latexrecommended
		dev-texlive/texlive-plaingeneric
	)
	sys-apps/coreutils
	dev-build/automake
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-2022.01-libstp-stub-makefile.patch
)

# Do not complain about CFLAGS etc since we don't use them
QA_FLAGS_IGNORED="
	usr/share/bsc/bsc-${PV}/bin/core/.*
	usr/share/bsc/bsc-${PV}/lib/SAT/.*
	usr/share/bsc/bsc-${PV}/lib/VPI/.*
"

src_prepare() {
	if [[ ${PV} != "9999" ]] ; then
		rm -r "${S}"/src/vendor/yices/v2.6/yices2 || die
		ln -s "${S_YICES}" "${S}"/src/vendor/yices/v2.6/yices2 || die
	fi

	default
}

src_compile() {
	# NO_DEPS_CHECKS=1: skip the subrepo check (this deriviation uses yices.src instead of the subrepo)
	# LDCONFIG=ldconfig: https://github.com/B-Lang-org/bsc/pull/43
	# STP_STUB=1: https://github.com/B-Lang-org/bsc/pull/278
	emake \
		"NO_DEPS_CHECKS=1" \
		"LDCONFIG=ldconfig" \
		"STP_STUB=1" \
		$(usex doc "" "NOASCIIDOCTOR=1") \
		$(usex doc "install-doc" "") \
		$(usex doc "install-release" "") \
		install-src \
		$(usex doc "release" "")
	emake -C src/comp \
		install-extra
}

src_test() {
	emake check-smoke
	emake -C testsuite check
}

# Call eselect bluespec update with --if-unset
# to respect user's choice
eselect_bluespec_update() {
	ebegin "Calling eselect bluespec update"
	eselect bluespec update --if-unset
	eend $?
}

src_install() {
	# From https://github.com/B-Lang-org/bsc/blob/main/INSTALL.md,
	# upstream recommend placing the inst directory at
	# the path /usr/share/bsc/bsc-<VERSION> for multi-version.
	local INSTALL_PATH=/usr/share/bsc/bsc-"${PV}"
	local ED_INSTALL_PATH="${ED}${INSTALL_PATH}"
	mkdir -p "${ED_INSTALL_PATH}" || die
	local f
	for f in "${S}"/inst/bin/*; do
		if [[ ! -d "${f}" ]] ; then
			local b=$(basename ${f})
			sed -i "s|ABSNAME=.*\$|ABSNAME=\$(readlink -f -- \"\$0\")|g" "${f}" || die
		fi
	done
	cp -dr --preserve=mode,timestamp "${S}"/inst/* "${ED_INSTALL_PATH}"/ || die
	insinto "${INSTALL_PATH}"/vimfiles
	doins -r "${S}"/util/vim/{ftdetect,indent,syntax}
}

pkg_postinst() {
	eselect_bluespec_update
}

pkg_postrm() {
	eselect_bluespec_update
}
