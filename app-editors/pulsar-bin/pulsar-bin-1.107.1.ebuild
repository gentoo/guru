# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A Community-led Hyper-Hackable Text Editor"
HOMEPAGE="https://pulsar-edit.dev/"

SRC_URI="
	amd64? ( https://github.com/pulsar-edit/pulsar/releases/download/v${PV}/Linux.pulsar-${PV}.tar.gz -> ${P}-amd64.tar.gz )
	arm64? ( https://github.com/pulsar-edit/pulsar/releases/download/v${PV}/ARM.Linux.pulsar-${PV}-arm64.tar.gz -> ${P}-arm64.tar.gz )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

# binary package; no tests available
RESTRICT="test"

S="${WORKDIR}/pulsar-${PV}"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/nspr
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib
	dev-libs/nss
	dev-libs/openssl-compat
	dev-vcs/git
	media-libs/alsa-lib
	media-libs/mesa
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[X]
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/libxshmfence
	x11-libs/libXrandr
	x11-libs/pango
"

QA_PREBUILT="opt/Pulsar/*"
QA_PRESTRIPPED="opt/Pulsar/resources/*"  # Files are already stripped

src_unpack(){
	default

	if use arm64; then
		mv "pulsar-${PV}-arm64" "pulsar-${PV}" || die
	fi
}

src_prepare(){
	default

	# We do not install licenses
	rm resources/LICENSE.md || die "Failed to remove LICENSE"
}

src_install(){
	dodir /opt/Pulsar
	mv "${S}"/* "${ED}"/opt/Pulsar

	dosym -r /opt/Pulsar/resources/pulsar.sh /usr/bin/pulsar

	# Bug #906939
	if use amd64; then
		rm "${ED}"/opt/Pulsar/resources/app.asar.unpacked/node_modules/tree-sitter-bash/build/node_gyp_bins/python3 || die
		rmdir "${ED}"/opt/Pulsar/resources/app.asar.unpacked/node_modules/tree-sitter-bash/build/node_gyp_bins || die
	fi

	doicon "${ED}"/opt/Pulsar/resources/pulsar.png
	make_desktop_entry "/usr/bin/pulsar %F" "Pulsar" "pulsar" \
		"GNOME;GTK;Utility;TextEditor;Development;" \
		"GenericName=Text Editor\nStartupNotify=true\nStartupWMClass=pulsar\n" \
		"MimeType=application/javascript;application/json;application/x-httpd-eruby;" \
			"application/x-httpd-php;application/x-httpd-php3;application/x-httpd-php4;" \
			"application/x-httpd-php5;application/x-ruby;application/x-bash;application/x-csh;" \
			"application/x-sh;application/x-zsh;application/x-shellscript;application/x-sql;" \
			"application/x-tcl;application/xhtml+xml;application/xml;application/xml-dtd;" \
			"application/xslt+xml;text/coffeescript;text/css;text/html;text/plain;text/xml;" \
			"text/xml-dtd;text/x-bash;text/x-c++;text/x-c++hdr;text/x-c++src;text/x-c;text/x-chdr;" \
			"text/x-csh;text/x-csrc;text/x-dsrc;text/x-diff;text/x-go;text/x-java;text/x-java-source;" \
			"text/x-makefile;text/x-markdown;text/x-objc;text/x-perl;text/x-php;text/x-python;" \
			"text/x-ruby;text/x-sh;text/x-zsh;text/yaml;inode/directory"

	einstalldocs

	find "${ED}" -name '*.la' -delete || die
}

pkg_postinst(){
	xdg_desktop_database_update

	elog "To migrate configurations & saved state from Atom Editor, execute:"
	elog "    cp -a \$HOME/.atom \$HOME/.pulsar"
	elog "    cp -a \$HOME/.config/Atom \$HOME/.config/Pulsar"
}
