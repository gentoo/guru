# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GOLANG_PKG_IMPORTPATH="github.com/schachmat"
GOLANG_PKG_HAVE_TEST=1
GOLANG_PKG_USE_CGO=1

GOLANG_PKG_DEPENDENCIES=(
	"github.com/mattn/go-colorable:9fdad7c"
	"github.com/mattn/go-runewidth:d037b52"
	"github.com/schachmat/ingo:fab41e4"
)

inherit golang-single

DESCRIPTION="Wego is a weather client for the terminal"

LICENSE="BSD ISC"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="!test? ( test )"
