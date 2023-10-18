# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/allan-simon/go-singleinstance v0.0.0-20210120080615-d0997106ab37"
	"github.com/allan-simon/go-singleinstance v0.0.0-20210120080615-d0997106ab37/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dlasky/gotk3-layershell v0.0.0-20230802002603-b0c42cd8474f"
	"github.com/dlasky/gotk3-layershell v0.0.0-20230802002603-b0c42cd8474f/go.mod"
	"github.com/gotk3/gotk3 v0.6.1/go.mod"
	"github.com/gotk3/gotk3 v0.6.2"
	"github.com/gotk3/gotk3 v0.6.2/go.mod"
	"github.com/joshuarubin/go-sway v1.2.0"
	"github.com/joshuarubin/go-sway v1.2.0/go.mod"
	"github.com/joshuarubin/lifecycle v1.0.0/go.mod"
	"github.com/joshuarubin/lifecycle v1.1.4"
	"github.com/joshuarubin/lifecycle v1.1.4/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"go.uber.org/atomic v1.3.2/go.mod"
	"go.uber.org/multierr v1.1.0/go.mod"
	"go.uber.org/multierr v1.11.0"
	"go.uber.org/multierr v1.11.0/go.mod"
	"golang.org/x/sync v0.0.0-20190412183630-56d357773e84/go.mod"
	"golang.org/x/sync v0.3.0"
	"golang.org/x/sync v0.3.0/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.11.0"
	"golang.org/x/sys v0.11.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

SRC_URI="https://github.com/nwg-piotr/nwg-dock/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
KEYWORDS="~amd64"

DESCRIPTION="GTK3-based dock for sway"
HOMEPAGE="https://github.com/nwg-piotr/nwg-dock"
LICENSE="MIT"

SLOT="0"

RDEPEND="
	gui-libs/gtk-layer-shell
	gui-wm/sway
	x11-libs/gtk+:3
"
DEPEND="
	>=dev-lang/go-1.20
	app-accessibility/at-spi2-core:2
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	${RDEPEND}
"

src_compile() {
	emake build
}

src_install() {
	insinto /usr/share/nwg-dock
	doins -r images
	doins config/*
	dobin bin/nwg-dock
}
