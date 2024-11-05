# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

MY_PN="rime-japanese"
MY_COMMIT="4c1e65135459175136f380e90ba52acb40fdfb2d"

DESCRIPTION="input method for typing Japanese with RIME"
HOMEPAGE="https://rime.im/ https://github.com/gkovacs/rime-japanese"
SRC_URI="https://github.com/gkovacs/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

DOCS=(
	README.md
)

src_install() {
	insinto /usr/share/rime-data
	doins *.yaml

	einstalldocs
}
