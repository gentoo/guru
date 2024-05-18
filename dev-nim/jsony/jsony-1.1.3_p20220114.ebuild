# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

COMMIT="d0e69bddf83874e15b5c2f52f8b1386ac080b443"
DESCRIPTION="A loose direct to object json parser with hooks"
HOMEPAGE="
	https://github.com/treeform/jsony
	https://nimble.directory/pkg/jsony
"
SRC_URI="https://github.com/treeform/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="${PV%_*}"
KEYWORDS="~amd64"

set_package_url "https://github.com/treeform/jsony"
