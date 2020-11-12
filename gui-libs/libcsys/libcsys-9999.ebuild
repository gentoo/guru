# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QTV="5.15.1"

inherit eutils qmake-utils

DESCRIPTION="Library for managing the device"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/libcsys"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/coreapps/${PN}.git"
else
	SRC_URI="https://gitlab.com/cubocore/coreapps/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="udisks"

DEPEND="
	~dev-qt/qtcore-${QTV}:5=
	~dev-qt/qtdbus-${QTV}:5=
	~dev-qt/qtnetwork-${QTV}:5=
"
RDEPEND="
	${DEPEND}
	udisks? (
		sys-fs/udisks:2
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-lib.patch"
)

src_configure() {
	local lib="$(get_libdir)"
	# '^^' because we need to upcase the definition
	eqmake5 DEFINES+="${lib^^}"
}

src_install() {
	einstalldocs

	emake INSTALL_ROOT="${D}" install
}
