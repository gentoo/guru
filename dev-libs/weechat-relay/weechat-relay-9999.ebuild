EAPI=7

inherit cmake

inherit git-r3
EGIT_REPO_URI="https://github.com/weechat/weechat-relay.git"

DESCRIPTION="Portable and multi-interface IRC client relay api"
HOMEPAGE="https://weechat.org/"
LANG="en fr"

LICENSE="GPL-3"
SLOT="0/${PV}"

IUSE="doc man test"

REQUIRED_USE="
"

RDEPEND="
	app-arch/zstd
	dev-libs/libgcrypt:0
	net-libs/gnutls
	sys-libs/ncurses:0
	sys-libs/zlib
	net-misc/curl[ssl]
"

DEPEND="${RDEPEND}
	test? ( dev-util/cpputest )
"

BDEPEND+="
	virtual/pkgconfig
	doc? ( >=dev-ruby/asciidoctor-1.5.4 )
	man? ( >=dev-ruby/asciidoctor-1.5.4 )
"

DOCS="AUTHORS.adoc ChangeLog.adoc Contributing.adoc ReleaseNotes.adoc README.adoc"

RESTRICT="!test? ( test )"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DPROJECT_NAME="${PF}"
	)
	use doc || mycmakeargs+=( -DBUILD_DOC=OFF )
	use man || mycmakeargs+=( -DBUILD_MAN=OFF )
	cmake_src_configure
}

src_test() {
	if $(locale -a | grep -iq "en_US\.utf.*8"); then
		cmake_src_test -V
	else
		eerror "en_US.UTF-8 locale is required to run ${PN}'s ${FUNCNAME}"
		die "required locale missing"
	fi
}
