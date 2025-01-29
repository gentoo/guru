# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker xdg

DESCRIPTION="The simplest way to keep notes"
HOMEPAGE="https://simplenote.com"
SRC_URI="
	amd64? (
		https://github.com/Automattic/simplenote-electron/releases/download/v${PV}/Simplenote-linux-${PV}-amd64.deb\
			-> simplenote-${PV}-amd64.deb
	)
	arm64? (
		https://github.com/Automattic/simplenote-electron/releases/download/v${PV}/Simplenote-linux-${PV}-arm64.deb\
			-> simplenote-${PV}-arm64.deb
	)
"

S=${WORKDIR}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE="doc"
RESTRICT="bindist mirror"

RDEPEND="
	dev-libs/nss
	net-print/cups
	x11-libs/libXScrnSaver
"

PATCHES=(
	"${FILESDIR}/${PN}.desktop.patch"
)

QA_PREBUILT="*"

src_prepare() {
	default

	if use doc ; then
		unpack "usr/share/doc/simplenote/changelog.gz" || die "unpack failed"
		rm -f "usr/share/doc/simplenote/changelog.gz" || die "rm failed"
		mv "changelog" "usr/share/doc/simplenote" || die "mv failed"
	fi
}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	rm -r "${ED}/usr/share/doc/simplenote" || die "rm failed"

	if use doc ; then
		dodoc -r "usr/share/doc/simplenote/"* || die "dodoc failed"
	fi

	dosym ../../opt/Simplenote/simplenote "/usr/bin/simplenote" || die "dosym failed"
}
