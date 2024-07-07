# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mjakeman/text-engine.git"
else
	SRC_URI="https://github.com/mjakeman/text-engine/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A lightweight rich-text framework for GTK 4"
HOMEPAGE="https://github.com/mjakeman/text-engine"

LICENSE="LGPL-3+"
SLOT="0"

BDEPEND="
	virtual/pkgconfig
"

COMMON_DEPEND="
	dev-libs/glib:2
	dev-libs/libxml2:2
	gui-libs/gtk:4
"

DEPEND="
	${COMMON_DEPEND}
	dev-libs/json-glib
"

RDEPEND="
	${COMMON_DEPEND}
	x11-libs/pango
"

PATCHES=(
	"${FILESDIR}/${P}-fix-package-version.patch"
	"${FILESDIR}/${P}-fix-Wreturn-type.patch"
	"${FILESDIR}/${P}-fix-Wincompatible-pointer-types.patch"
)

src_prepare() {
	default
	sed -i -e "/subdir('demo')/d" meson.build ||
		die "Failed to modify meson.build to exclude the demo program"
}
