# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="A hackable text editor for the 21st Century"
HOMEPAGE="https://atom.io/"
SRC_URI="https://github.com/atom/atom/releases/download/v${PV}/atom-amd64.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa cups nodejs ssl test X"
RESTRICT="!test? ( test )"

S="${WORKDIR}/atom-${PV}-amd64"

RDEPEND="
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/atk
	dev-libs/nss
	dev-vcs/git
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	nodejs? ( net-libs/nodejs[npm] )
	ssl? (
		dev-libs/openssl
		dev-libs/openssl-compat
	)
	X? (
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
	)
"

QA_PREBUILT="/opt/atom-bin/*"
QA_PRESTRIPPED="/opt/atom-bin/resources/*"  # Files are already stripped

DOCS=( resources/LICENSE.md )
src_prepare(){
	default
}

src_install(){
	insinto /opt/"${PN}"
	doins -r "${S}"/*
	dosym ../../opt/"${PN}"/atom "${EPREFIX}"/usr/bin/atom
	fperms +x /opt/"${PN}"/atom

	if use nodejs; then
		rm resources/app/apm/bin/npm
		rm resources/app/apm/BUNDLED_NODE_VERSION

		#Fix apm to use nodejs binary
		sed -i "s#\$binDir\/\$nodeBin#\$\(which \$nodeBin\)#" resources/app/apm/bin/apm
	else
		fperms +x /opt/"${PN}"/resources/app/apm/bin/npm
	fi

	fperms +x /opt/"${PN}"/resources/app/apm/bin/node
	fperms +x /opt/"${PN}"/resources/app/apm/bin/apm

	doicon atom.png
	make_desktop_entry "/opt/atom-bin/atom %U" "atom" "atom" \
		"GNOME;GTK;Utility;TextEditor;Development;" \
		"GenericName=Text Editor\nMimeType=text/plain;\nStartupNotify=true\nStartupWMClass=atom"

	einstalldocs

	find "${ED}" -name '*.la' -delete || die
}
