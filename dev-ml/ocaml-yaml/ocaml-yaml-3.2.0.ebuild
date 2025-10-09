# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="yaml"
inherit dune

DESCRIPTION="Parse and generate YAML 1.1/1.2 files"
HOMEPAGE="https://github.com/avsm/ocaml-yaml"
SRC_URI="https://github.com/avsm/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-ml/ocaml-ctypes-0.14.0:=[ocamlopt?]
	dev-ml/bos
	dev-ml/sexplib:=[ocamlopt?]
	dev-ml/ppx_sexp_conv:=[ocamlopt?]
	>=dev-ml/dune-2.0
	>=dev-lang/ocaml-4.13.0:=[ocamlopt?]
"
DEPEND="${RDEPEND}"
