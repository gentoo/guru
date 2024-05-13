# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/allan-simon/go-singleinstance v0.0.0-20210120080615-d0997106ab37"
	"github.com/allan-simon/go-singleinstance v0.0.0-20210120080615-d0997106ab37/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/dlasky/gotk3-layershell v0.0.0-20210827021656-e6ecab2731f7"
	"github.com/dlasky/gotk3-layershell v0.0.0-20210827021656-e6ecab2731f7/go.mod"
	"github.com/dlasky/gotk3-layershell v0.0.0-20230802002603-b0c42cd8474f"
	"github.com/dlasky/gotk3-layershell v0.0.0-20230802002603-b0c42cd8474f/go.mod"
	"github.com/gotk3/gotk3 v0.6.1"
	"github.com/gotk3/gotk3 v0.6.1/go.mod"
	"github.com/gotk3/gotk3 v0.6.2"
	"github.com/gotk3/gotk3 v0.6.2/go.mod"
	"github.com/joshuarubin/go-sway v0.0.4"
	"github.com/joshuarubin/go-sway v0.0.4/go.mod"
	"github.com/joshuarubin/go-sway v1.2.0"
	"github.com/joshuarubin/go-sway v1.2.0/go.mod"
	"github.com/joshuarubin/lifecycle v1.0.0"
	"github.com/joshuarubin/lifecycle v1.0.0/go.mod"
	"github.com/joshuarubin/lifecycle v1.1.4"
	"github.com/joshuarubin/lifecycle v1.1.4/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"go.uber.org/atomic v1.3.2"
	"go.uber.org/atomic v1.3.2/go.mod"
	"go.uber.org/atomic v1.11.0"
	"go.uber.org/atomic v1.11.0/go.mod"
	"go.uber.org/multierr v1.1.0"
	"go.uber.org/multierr v1.1.0/go.mod"
	"go.uber.org/multierr v1.11.0"
	"go.uber.org/multierr v1.11.0/go.mod"
	"golang.org/x/sync v0.0.0-20190412183630-56d357773e84"
	"golang.org/x/sync v0.0.0-20190412183630-56d357773e84/go.mod"
	"golang.org/x/sync v0.0.0-20220513210516-0976fa681c29"
	"golang.org/x/sync v0.0.0-20220513210516-0976fa681c29/go.mod"
	"golang.org/x/sync v0.6.0"
	"golang.org/x/sync v0.6.0/go.mod"
)
go-module_set_globals

DESCRIPTION="enuStart plugin to nwg-panel, also capable of working standalone"
HOMEPAGE="https://github.com/nwg-piotr/nwg-menu"
SRC_URI="https://github.com/nwg-piotr/nwg-menu/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	gui-libs/gtk-layer-shell
	media-libs/fontconfig
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
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
	insinto /usr/share/nwg-menu
	doins -r desktop-directories
	doins menu-start.css
	dobin bin/nwg-menu
}
