# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Static website generator based on HTML rewriting"
HOMEPAGE="https://soupault.net"
SRC_URI="https://codeberg.org/PataphysicalSociety/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="
	>=dev-lang/ocaml-4.13:=[ocamlopt?]
	>=dev-ml/dune-2.0.0
	>=dev-ml/camomile-2.0.0:=[ocamlopt?]
	>=dev-ml/ocaml-tsort-2.1.0:=[ocamlopt?]
	>=dev-ml/lua-ml-0.9.3:=[ocamlopt?]
	dev-ml/digestif:=[ocamlopt?]
	>=dev-ml/ocaml-base64-3.0.0:=[ocamlopt?]
	>=dev-ml/jingoo-1.4.2:=[ocamlopt?]
	>=dev-ml/spelll-0.4:=[ocamlopt?]
	>=dev-ml/ocaml-yaml-2.0.0:=[ocamlopt?]
	>=dev-ml/ocaml-csv-2.4:=[ocamlopt?]
	>=dev-ml/ezjsonm-1.2.0:=[ocamlopt?]
	>=dev-ml/re-1.9.0:=[ocamlopt?]
	>=dev-ml/otoml-1.0.5:=[ocamlopt?]
	>=dev-ml/ocaml-fileutils-0.6.3:=[ocamlopt?]
	>=dev-ml/ocaml-containers-3.6:=[ocamlopt?]
	>=dev-ml/markup-1.0.0:=[ocamlopt?]
	>=dev-ml/lambdasoup-1.1.1:=[ocamlopt?]
	>=dev-ml/logs-0.7.0:=[ocamlopt?]
	>=dev-ml/fmt-0.8.9:=[ocamlopt?]
	>=dev-ml/odate-0.6:=[ocamlopt?]
	>=dev-ml/cmarkit-0.3.0:=[ocamlopt?]
	!www-apps/soupault-bin
"

DEPEND="${RDEPEND}"
