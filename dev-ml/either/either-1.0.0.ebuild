# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Compatibility module for Either in OCaml 4.12 "
HOMEPAGE="https://github.com/mirage/either"
SRC_URI="https://github.com/mirage/either/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"
