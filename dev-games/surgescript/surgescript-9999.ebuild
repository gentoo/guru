# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alemart/surgescript"
else
	SRC_URI="https://github.com/alemart/surgescript/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="scripting language made for opensurge"
HOMEPAGE="https://alemart.github.io/surgescript"
LICENSE="Apache-2.0"
SLOT="0"
# TODO: build documentation, needs dev-python/mkdocs-material
