# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="An Async-pipe-based interface with OpenSSL"
HOMEPAGE="https://github.com/janestreet/async_ssl"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-libs/openssl:0=
	dev-ml/async
	dev-ml/base
	dev-ml/core
	dev-ml/ppx_jane
	dev-ml/stdio
	dev-ml/ocaml-ctypes
	dev-ml/dune-configurator
"
DEPEND="${RDEPEND}"
