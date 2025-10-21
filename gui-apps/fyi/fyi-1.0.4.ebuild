# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A notify-send alternative"
HOMEPAGE="https://codeberg.org/dnkl/fyi"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://codeberg.org/dnkl/fyi.git"
else
	SRC_URI="https://codeberg.org/dnkl/fyi/archive/${PV}.tar.gz
		-> ${P}.tar.gz"

	S="${WORKDIR}/fyi"

	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="sys-apps/dbus"
BDEPEND="
	${RDEPEND}
	dev-build/meson
	dev-build/ninja
	app-text/scdoc
"

PATCHES=("${FILESDIR}/meson-doc-subdir.patch")

src_configure() {
	append-flags -fno-exceptions
	EMESON_BUILDTYPE="minsize"
	local emesonargs=(
		-Ddocsdir="doc/${P}"
	)
	meson_src_configure
}
