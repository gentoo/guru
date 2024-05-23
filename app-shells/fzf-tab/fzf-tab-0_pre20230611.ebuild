# Copyright 2022,2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic readme.gentoo-r1

MY_COMMIT="c2b4aa5ad2532cca91f23908ac7f00efb7ff09c9"
DESCRIPTION="Replace zsh's default completion selection menu with fzf"
HOMEPAGE="https://github.com/Aloxaf/fzf-tab"
SRC_URI="https://github.com/Aloxaf/fzf-tab/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	app-shells/fzf
	app-shells/zsh
"
BDEPEND="
	test? (
		app-shells/zsh
		dev-vcs/git
	)
"

RESTRICT="!test? ( test )"

DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add
. /usr/share/zsh/site-functions/${PN}.zsh
to your ~/.zshrc after compinit, but before plugins which will wrap
widgets, such as zsh-autosuggestions or fast-syntax-highlighting"

src_configure() {
	# Test fails if we modify FZF_TAB_HOME in place
	sed -E "s|^(FZF_TAB_HOME=\"[^\"]+)\"$|\1/${PN}\"|" \
		${PN}.zsh > ${PN}-patched.zsh || die "Modifying FZF_TAB_HOME failed"

	pushd modules || die "Changing directory failed"
	append-cflags -Wno-error=implicit-function-declaration -Wno-error=implicit-int
	default_src_configure
}

src_compile() {
	pushd modules || die "Changing directory failed"
	default_src_compile
}

src_test() {
	pushd test || die "Changing directory failed"
	ZTST_verbose=1 zsh -f ./runtests.zsh fzftab.ztst || die "One or more tests failed"
}

src_install() {
	local zsh_libdir="/usr/share/zsh/site-functions"

	insinto ${zsh_libdir}
	newins ${PN}{-patched,}.zsh

	insinto ${zsh_libdir}/${PN}
	doins -r lib

	insinto ${zsh_libdir}/${PN}/modules/Src/aloxaf
	doins modules/Src/aloxaf/fzftab.so

	readme.gentoo_create_doc
	einstalldocs
}

pkg_postinst() {
	readme.gentoo_print_elog
}
