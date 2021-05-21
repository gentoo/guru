# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="994e4f141759a1070d7b0c8fbe5fad2cc7ee7d45"

GOLANG_PKG_IMPORTPATH="github.com/schachmat"
GOLANG_PKG_HAVE_TEST=1
GOLANG_PKG_VERSION="${COMMIT}"
GOLANG_PKG_DEPENDENCIES=(
	"github.com/mattn/go-runewidth:43a826dcfbd"
	"github.com/mattn/go-colorable:2e1b0c1546e01"
	"github.com/schachmat/ingo:a4bdc0729a3f"
	"github.com/mattn/go-isatty:7b513a986450"
	"github.com/rivo/uniseg:f8f8f751c732"
	"github.com/golang/sys:d5e6a3e2c0ae -> golang.org/x"
)

inherit golang-single

DESCRIPTION="Wego is a weather client for the terminal"
#SRC_URI="https://github.com/schachmat/wego/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
#S="${WORKDIR}/${PN}-${COMMIT}"
LICENSE="BSD ISC"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="!test? ( test )"
