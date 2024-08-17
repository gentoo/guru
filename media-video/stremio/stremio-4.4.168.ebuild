# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils xdg

DESCRIPTION="Stremio is a modern media center for your video entertainment."
HOMEPAGE="https://github.com/Stremio/stremio-shell/ https://www.stremio.com/"
SRC_URI="
	https://github.com/Stremio/stremio-shell/archive/refs/tags/v${PV}.tar.gz -> stremio-shell.gh.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/aede311d28d20179216c5419b581087be2a8409f.tar.gz -> singleapplication.gh.tar.gz
	https://github.com/Ivshti/libmpv/archive/b0eae77cf6dc59aaf142b7d079cb13a0904fd3ee.tar.gz -> libmpv.gh.tar.gz
	https://github.com/Ivshti/razerchroma/archive/99045142479ba0e2fc3b9cccb72e348c67cd5829.tar.gz -> razerchroma.gh.tar.gz
	https://dl.strem.io/server/v4.20.8/desktop/server.js
"

S="${WORKDIR}/${PN}-shell-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror test strip"

RDEPEND="
	gnome-base/librsvg
	dev-qt/qtquickcontrols
	dev-qt/qtopengl
	dev-qt/qtwebengine:5
	media-video/ffmpeg[network]
	media-video/mpv
	net-libs/nodejs[ssl]
"

src_compile() {
	mv ../SingleApplication* ../singleapplication || die
	mv ../libmpv* ../libmpv || die
	mv ../razerchroma* ../chroma || die

	mv -t deps \
	../singleapplication \
	../libmpv \
	../chroma || die

	eqmake5
	emake -f release.makefile
}

src_install() {
	insinto /opt/stremio
	doins build/stremio
	doins "${DISTDIR}"/server.js

	dosym -r /usr/bin/node /opt/stremio/node

	dosym -r /opt/stremio/stremio /usr/bin/${PN}
	domenu smartcode-stremio.desktop
	local x
	for x in 16 22 24 32 64 128; do
		newicon -s ${x} icons/smartcode-stremio_${x}.png smartcode-stremio.png
	done

	fperms +x /opt/stremio/stremio
}

pkg_postinst() {
	xdg_pkg_postinst
}
