# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A hackable text editor for the 21st Century"
HOMEPAGE="https://atom.io/"
SRC_URI="https://github.com/atom/atom/releases/download/v${PV}/atom-amd64.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
# Atom works only on amd64
KEYWORDS="-* ~amd64"
RESTRICT="test"

S="${WORKDIR}/atom-${PV}-amd64"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0
	app-crypt/libsecret
	dev-libs/nss
	dev-libs/openssl
	dev-libs/openssl-compat
	dev-vcs/git
	media-libs/alsa-lib
	net-print/cups
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	x11-libs/libnotify
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbfile
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
"

QA_PREBUILT="/opt/${PN}/*"
QA_PRESTRIPPED="/opt/${PN}/resources/*"  # Files are already stripped

src_prepare(){
	default

	# We do not install licenses
	rm resources/LICENSE.md || die "Failed to remove LICENSE"
}

src_install(){
	insinto /opt/"${PN}"
	doins -r "${S}"/*
	dosym ../../opt/"${PN}"/atom "${EPREFIX}"/usr/bin/atom
	fperms +x /opt/"${PN}"/atom

	# I will use only npm provided with package itself
	# as nodejs is not required to make it working (and it is really big).
	fperms +x /opt/"${PN}"/resources/app/apm/bin/{apm,node,npm}

	# Bug 798459
	fperms +x /opt/"${PN}"/resources/app.asar.unpacked/node_modules/{vscode-ripgrep/bin/rg,dugite/git/bin/git}

	doicon atom.png
	make_desktop_entry "/opt/atom-bin/atom %U" "Atom" "atom" \
		"GNOME;GTK;Utility;TextEditor;Development;" \
		"GenericName=Text Editor\nMimeType=text/plain;\nStartupNotify=true\nStartupWMClass=atom"

	einstalldocs

	find "${ED}" -name '*.la' -delete || die
}

pkg_postinst(){
	xdg_desktop_database_update
}
