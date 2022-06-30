# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="A loose direct to object json parser with hooks"
HOMEPAGE="
	https://github.com/treeform/jsony
	https://nimble.directory/pkg/jsony
"
SRC_URI="https://github.com/treeform/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

set_package_url "https://github.com/treeform/jsony"
