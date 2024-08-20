# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Stremio is a modern media center for your video entertainment."
HOMEPAGE="https://github.com/Stremio/stremio-shell/ https://www.stremio.com/"
SRC_URI="
	https://github.com/Stremio/stremio-shell/archive/refs/tags/v${PV}.tar.gz -> ${PV}-stremio-shell.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/aede311d28d20179216c5419b581087be2a8409f.tar.gz -> ${PV}-singleapplication.tar.gz
	https://github.com/Ivshti/libmpv/archive/b0eae77cf6dc59aaf142b7d079cb13a0904fd3ee.tar.gz -> ${PV}-libmpv.tar.gz
	https://github.com/Ivshti/razerchroma/archive/99045142479ba0e2fc3b9cccb72e348c67cd5829.tar.gz -> ${PV}-razerchroma.tar.gz
	https://dl.strem.io/server/v4.20.8/desktop/server.js -> ${PV}-server.js
"

S="${WORKDIR}/${PN}-shell-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-video/ffmpeg[network]
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	gnome-base/librsvg
	dev-qt/qtbase[dbus]
	dev-qt/qtquickcontrols
	dev-qt/qtopengl
	dev-qt/qtwebengine:5
	media-video/mpv
	net-libs/nodejs[ssl]
"

src_prepare() {
	# Move dependencies to build dir
	mv ../SingleApplication* ../singleapplication || die
	mv ../libmpv* ../libmpv || die
	mv ../razerchroma* ../chroma || die

	mv -t deps \
	../singleapplication \
	../libmpv \
	../chroma || die

	cp "${DISTDIR}"/${PV}-server.js server.js || die

	default
}

src_compile() {
	emake -f release.makefile
}

src_install() {
	# I would prefer to install to /usr/bin but the server won't start unless placed in the same
	# directory as a node binary and the server.js file
	insinto /opt/stremio
	doins build/stremio
	doins server.js

	dosym -r /usr/bin/node /opt/stremio/node

	dosym -r /opt/stremio/stremio /usr/bin/${PN}
	domenu smartcode-stremio.desktop
	local x
	for x in 16 22 24 32 64 128; do
		newicon -s ${x} icons/smartcode-stremio_${x}.png smartcode-stremio.png
	done

	fperms +x /opt/stremio/stremio
}
