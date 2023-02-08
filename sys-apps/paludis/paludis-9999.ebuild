# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/MageSlayer/paludis-gentoo-patches.git"
PYTHON_COMPAT=( python3_{8..11} )
RUBY_VER=2.7

inherit bash-completion-r1 cmake git-r3 python-r1

DESCRIPTION="paludis, the other package mangler"
HOMEPAGE="https://paludis.exherbo.org/"
SRC_URI=""

IUSE="doc pbins pink python ruby ruby_targets_ruby${RUBY_VER/./} search-index test +xml eapi7 eapi8"
LICENSE="GPL-2 vim"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="
	>=app-admin/eselect-1.2.13
	>=app-shells/bash-3.2:0
	dev-libs/libpcre:=[cxx]
	sys-apps/file:=
	pbins? ( >=app-arch/libarchive-3.1.2:= )
	python? (
		${PYTHON_DEPS}
		dev-libs/boost[python,${PYTHON_USEDEP}]
	)
	ruby? ( dev-lang/ruby:${RUBY_VER} )
	search-index? ( >=dev-db/sqlite-3:= )
	xml? ( >=dev-libs/libxml2-2.6:= )"

DEPEND="${COMMON_DEPEND}
	>=app-text/asciidoc-8.6.3
	app-text/htmltidy
	app-text/xmlto
	>=sys-devel/gcc-4.7
	doc? (
		app-doc/doxygen
		python? ( dev-python/sphinx[${PYTHON_USEDEP}] )
		ruby? ( dev-ruby/syntax[ruby_targets_ruby${RUBY_VER/./}] )
	)
	virtual/pkgconfig
	test? ( >=dev-cpp/gtest-1.6.0-r1 )"

RDEPEND="${COMMON_DEPEND}
	acct-user/paludisbuild
	acct-group/paludisbuild
	sys-apps/sandbox"

PDEPEND="app-eselect/eselect-package-manager"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
	ruby? ( ruby_targets_ruby${RUBY_VER/./} )
	?? ( eapi7 eapi8 )"
RESTRICT="!test? ( test )"

pkg_setup() {
	use python && python_setup -3
}
src_unpack() {
	if use eapi8; then
		# want experimental² EAPI8 support?
		EGIT_REPO_URI="https://github.com/Ionic/paludis-gentoo-patches.git"
		EGIT_BRANCH="feature/eapi8"
	elif use eapi7; then
		# want experimental EAPI7 support?
		EGIT_BRANCH="eapi7"
	else
		EGIT_BRANCH="master"
	fi
	git-r3_fetch
	git-r3_checkout
}

src_prepare() {
	# Fix the script shebang on Ruby scripts.
	# https://bugs.gentoo.org/show_bug.cgi?id=439372#c2
	sed -i -e "1s/ruby/&${RUBY_VER/./}/" ruby/demos/*.rb || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_DOXYGEN=$(usex doc)
		-DENABLE_GTEST=$(usex test)
		-DENABLE_PBINS=$(usex pbins)
		-DENABLE_PYTHON=$(usex python)
		-DENABLE_PYTHON_DOCS=$(usex doc) # USE=python implicit
		-DENABLE_RUBY=$(usex ruby)
		-DENABLE_RUBY_DOCS=$(usex doc) # USE=ruby implicit
		-DENABLE_SEARCH_INDEX=$(usex search-index)
		-DENABLE_VIM=ON
		-DENABLE_XML=$(usex xml)

		-DPALUDIS_COLOUR_PINK=$(usex pink)
		-DRUBY_VERSION=${RUBY_VER}
		-DPALUDIS_ENVIRONMENTS=all
		-DPALUDIS_DEFAULT_DISTRIBUTION=gentoo
		-DPALUDIS_CLIENTS=all
		-DCONFIG_FRAMEWORK=eselect

		# GNUInstallDirs
		-DCMAKE_INSTALL_DOCDIR="${EPREFIX}/usr/share/doc/${PF}"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	dobashcomp bash-completion/cave

	insinto /usr/share/zsh/site-functions
	doins zsh-completion/_cave

	cp "${FILESDIR}/portage2paludis.bash" portage2paludis
	dobin portage2paludis
}

pkg_postinst() {
	local pm
	if [[ -f ${ROOT}/etc/env.d/50package-manager ]] ; then
		pm=$( source "${ROOT}"/etc/env.d/50package-manager ; echo "${PACKAGE_MANAGER}" )
	fi

	if [[ ${pm} != paludis ]] ; then
		elog "If you are using paludis or cave as your primary package manager,"
		elog "you should consider running:"
		elog "    eselect package-manager set paludis"
	fi
}
