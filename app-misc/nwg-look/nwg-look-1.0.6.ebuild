# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module xdg

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/gotk3/gotk3 v0.6.5-0.20240618185848-ff349ae13f56"
	"github.com/gotk3/gotk3 v0.6.5-0.20240618185848-ff349ae13f56/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.29.0"
	"golang.org/x/sys v0.29.0/go.mod"
	"golang.org/x/sys v0.31.0"
	"golang.org/x/sys v0.31.0/go.mod"
	"golang.org/x/sys v0.33.0"
	"golang.org/x/sys v0.33.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
)
go-module_set_globals

DESCRIPTION="GTK settings editor adapted to work on wlroots-based compositors"
HOMEPAGE="https://github.com/nwg-piotr/nwg-look"
SRC_URI="
	https://github.com/nwg-piotr/nwg-look/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-accessibility/at-spi2-core
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	x11-apps/xcur2png
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/pango
"
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_compile() {
	emake build
}

src_install() {
	insinto /usr/share/nwg-look
	doins stuff/main.glade
	doins -r langs

	doicon -s scalable stuff/nwg-look.svg
	domenu stuff/nwg-look.desktop

	dobin bin/nwg-look

	einstalldocs
}
