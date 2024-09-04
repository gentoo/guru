# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="linux port of OpenBSD imsg"

HOMEPAGE="https://man.openbsd.org/imsg_init.3
	https://github.com/bsd-ac/imsg-compat
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bsd-ac/imsg-compat.git"
else
	SRC_URI="https://github.com/bsd-ac/imsg-compat/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"
