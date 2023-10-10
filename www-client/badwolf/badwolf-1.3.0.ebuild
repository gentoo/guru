# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg ninja-utils

if [[ "${PV}" == "9999" ]]
then
	EGIT_REPO_URI="https://hacktivis.me/git/badwolf.git"
	inherit git-r3
else
	MY_P="${PN}-$(ver_rs 3 - 4 .)"
	SRC_URI="https://hacktivis.me/releases/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_P}"
	inherit savedconfig
fi

DESCRIPTION="Minimalist and privacy-oriented WebKitGTK+ browser"
HOMEPAGE="https://hacktivis.me/projects/badwolf"
LICENSE="BSD"
SLOT="0"

DOCS=("README.md" "KnowledgeBase.md")

IUSE="+webkit41 test"
RESTRICT="!test? ( test )"

DEPEND="
	x11-libs/gtk+:3
	webkit41? ( net-libs/webkit-gtk:4.1= )
	!webkit41? ( net-libs/webkit-gtk:4= )
"
RDEPEND="${DEPEND}"
BDEPEND="test? ( app-text/mandoc )"

PATCHES=(
	"${FILESDIR}/badwolf-1.3.0-configure_missing_ed.patch"
)

src_configure() {
	[[ "${PV}" == "9999" ]] || restore_config config.h

	CC="${CC:-cc}" \
	ED="false" \
	CFLAGS="${CFLAGS:--02 -Wall -Wextra}" \
	LDFLAGS="${LDFLAGS}" \
	DOCDIR="/usr/share/doc/${PF}" \
	WITH_WEBKITGTK=$(usex webkit41 4.1 4.0) \
	PREFIX="/usr" \
	./configure
}

src_compile() {
	eninja
}

src_test() {
	eninja test
}

src_install() {
	DESTDIR="${ED}" eninja install

	[[ "${PV}" == "9999" ]] || save_config config.h
}
