# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Bindings for GObject Introspection and libgirepository for Guile"
HOMEPAGE="https://spk121.github.io/guile-gi/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/spk121/${PN}.git"
else
	SRC_URI="https://github.com/spk121/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

# Tests fail
RESTRICT="strip test"
LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	sys-apps/texinfo
"
DEPEND="
	>=dev-scheme/guile-2.0.9
	dev-libs/gobject-introspection
	x11-libs/gtk+:3[introspection]
"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED=".*"

src_prepare() {
	default

	find "${S}" -name "*.scm" -exec touch {} + || die
}

src_configure() {
	sh ./bootstrap || die

	local myconf=(
		--enable-introspection="yes"
		--enable-hardening
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	mv "${D}/usr/share/doc/${PN}"/* "${D}/usr/share/doc/${PF}" || die
	rm -r "${D}/usr/share/doc/${PN}" || die
}
