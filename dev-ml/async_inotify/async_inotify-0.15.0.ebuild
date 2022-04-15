# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Async wrapper for inotify"
HOMEPAGE="https://github.com/janestreet/async_inotify"
SRC_URI="https://github.com/janestreet/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/core_unix
	dev-ml/async
	dev-ml/async_find
	dev-ml/core
	dev-ml/ppx_jane
	dev-ml/inotify
"
RDEPEND="${DEPEND}"
