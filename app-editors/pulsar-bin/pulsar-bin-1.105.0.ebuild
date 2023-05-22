# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A Community-led Hyper-Hackable Text Editor"
HOMEPAGE="https://pulsar-edit.dev/"
SRC_URI="https://github.com/pulsar-edit/pulsar/releases/download/v${PV}/Linux.pulsar-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
# Need different downloads for other architectures; untested
KEYWORDS="-* ~amd64"
RESTRICT="test"

S="${WORKDIR}/pulsar-${PV}"

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
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
"

QA_PREBUILT="/opt/Pulsar/*"
QA_PRESTRIPPED="/opt/Pulsar/resources/*"  # Files are already stripped

src_prepare(){
	default

	# We do not install licenses
	rm resources/LICENSE.md || die "Failed to remove LICENSE"
}

src_install(){
	insinto /opt/Pulsar
	doins -r "${S}"/*
	dosym ../../opt/Pulsar/resources/pulsar.sh "${EPREFIX}"/usr/bin/pulsar
	fperms +x /opt/Pulsar/resources/pulsar.sh
	fperms +x /opt/Pulsar/pulsar

	# I will use only npm provided with package itself
	# as nodejs is not required to make it working (and it is really big).
	fperms +x /opt/Pulsar/resources/app/ppm/bin/{apm,node,npm}

	# Bug 798459
	fperms +x /opt/Pulsar/resources/app.asar.unpacked/node_modules/{vscode-ripgrep/bin/rg,dugite/git/bin/git}
	fperms +x /opt/Pulsar/resources/app.asar.unpacked/node_modules/fuzzy-finder/node_modules/vscode-ripgrep/bin/rg
	fperms +x /opt/Pulsar/resources/app.asar.unpacked/node_modules/whats-my-line/node_modules/dugite/git/bin/git

	# Bug #906939
	rm "${ED}"/opt/Pulsar/resources/app.asar.unpacked/node_modules/tree-sitter-bash/build/node_gyp_bins/python3
	rmdir "${ED}"/opt/Pulsar/resources/app.asar.unpacked/node_modules/tree-sitter-bash/build/node_gyp_bins

	doicon resources/pulsar.png
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
