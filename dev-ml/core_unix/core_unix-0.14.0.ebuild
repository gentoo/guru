# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Unix-specific extensions to some of the modules defined in [core] and [core_kernel]"
HOMEPAGE="https://github.com/janestreet/core_unix"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/core_kernel
	dev-ml/expect_test_helpers_core
	dev-ml/core
	dev-ml/ppx_jane
	dev-ml/jane-street-headers
	dev-ml/jst-config
	dev-ml/ocaml_intrinsics
	dev-ml/sexplib
	dev-ml/timezone
	dev-ml/base-threads
	dev-ml/spawn
"
DEPEND="
	${RDEPEND}
	sys-kernel/linux-headers
"
