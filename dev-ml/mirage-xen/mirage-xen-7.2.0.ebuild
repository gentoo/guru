# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Xen core platform libraries for MirageOS"
HOMEPAGE="https://github.com/mirage/mirage-xen"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/bheap
	dev-ml/cstruct
	dev-ml/duration
	dev-ml/fmt
	dev-ml/io-page
	dev-ml/logs
	dev-ml/lwt
	dev-ml/lwt-dllist
	dev-ml/mirage
	dev-ml/mirage-profile
	dev-ml/shared-memory-ring
	dev-ml/xenstore
"
DEPEND="${RDEPEND}"
