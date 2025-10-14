# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module xdg desktop

DESCRIPTION="GTK client for Music Player Daemon (MPD) written in Go"
HOMEPAGE="https://github.com/yktoo/ymuse"

#Check go.sum and sync with this
# Use e.g.: cat go.sum | cut -d" " -f1,2 | awk '{print "\t\"" $0 "\""}'
# (Could maybe use dev-go/get-ego-vendor?)
EGO_SUM=(
	"github.com/fhs/gompd/v2 v2.3.0"
	"github.com/fhs/gompd/v2 v2.3.0/go.mod"
	"github.com/gotk3/gotk3 v0.6.2"
	"github.com/gotk3/gotk3 v0.6.2/go.mod"
	"github.com/op/go-logging v0.0.0-20160315200505-970db520ece7"
	"github.com/op/go-logging v0.0.0-20160315200505-970db520ece7/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/yktoo/ymuse/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	x11-libs/gtk+:3
	>=dev-lang/go-1.21
"
RDEPEND="${DEPEND}"
BDEPEND="
	${DEPEND}
	virtual/libc
	x11-libs/gdk-pixbuf
	dev-libs/glib
	sys-devel/gettext
"

src_unpack() {
	default
	go-module_src_unpack
}

src_compile() {
	for file in "${S}/resources/i18n/"*.po; do
		msgfmt "${file}" -o "${file%.po}.mo" || die
	done
	go build || die
}

src_install() {
	for x in 16 24 32 48 64 128 256 512; do
		doicon -s ${x} resources/icons/hicolor/${x}x${x}/apps/com.yktoo.ymuse.png
	done
	doicon --size scalable resources/icons/hicolor/scalable/*/*
	make_desktop_entry "ymuse" "Ymuse" "com.yktoo.ymuse.png" "AudioVideo;Player;Music;"
	domo "${S}/resources/i18n/"*.mo
	dobin ymuse
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
}
