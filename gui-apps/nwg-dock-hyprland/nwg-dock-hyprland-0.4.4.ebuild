# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/KarpelesLab/weak v0.1.1"
	"github.com/KarpelesLab/weak v0.1.1/go.mod"
	"github.com/allan-simon/go-singleinstance v0.0.0-20210120080615-d0997106ab37"
	"github.com/allan-simon/go-singleinstance v0.0.0-20210120080615-d0997106ab37/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/diamondburned/gotk4-layer-shell/pkg v0.0.0-20240109211357-6efa9f6dc438"
	"github.com/diamondburned/gotk4-layer-shell/pkg v0.0.0-20240109211357-6efa9f6dc438/go.mod"
	"github.com/diamondburned/gotk4/pkg v0.3.1"
	"github.com/diamondburned/gotk4/pkg v0.3.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"go4.org/unsafe/assume-no-moving-gc v0.0.0-20231121144256-b99613f794b6"
	"go4.org/unsafe/assume-no-moving-gc v0.0.0-20231121144256-b99613f794b6/go.mod"
	"golang.org/x/sync v0.8.0"
	"golang.org/x/sync v0.8.0/go.mod"
	"golang.org/x/sync v0.10.0"
	"golang.org/x/sync v0.10.0/go.mod"
	"golang.org/x/sync v0.12.0"
	"golang.org/x/sync v0.12.0/go.mod"
	"golang.org/x/sync v0.13.0"
	"golang.org/x/sync v0.13.0/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.26.0"
	"golang.org/x/sys v0.26.0/go.mod"
	"golang.org/x/sys v0.28.0"
	"golang.org/x/sys v0.28.0/go.mod"
	"golang.org/x/sys v0.29.0"
	"golang.org/x/sys v0.29.0/go.mod"
	"golang.org/x/sys v0.31.0"
	"golang.org/x/sys v0.31.0/go.mod"
	"golang.org/x/sys v0.32.0"
	"golang.org/x/sys v0.32.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
)
go-module_set_globals

DESCRIPTION="GTK3-based dock for Hyprland"
HOMEPAGE="https://github.com/nwg-piotr/nwg-dock-hyprland"
SRC_URI="https://github.com/nwg-piotr/nwg-dock-hyprland/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-libs/gtk-layer-shell
	gui-wm/hyprland
	x11-libs/gtk+:3
	app-accessibility/at-spi2-core:2
	>=dev-libs/glib-2.82.2:2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
"
DEPEND="
	>=dev-lang/go-1.20
	${RDEPEND}
"

src_compile() {
	emake build
}

src_install() {
	insinto /usr/share/nwg-dock-hyprland
	doins -r images
	doins config/*
	dobin bin/nwg-dock-hyprland
}
