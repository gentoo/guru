# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: "
HOMEPAGE="https://jasoncarloscox.com/creations/vim-wayland-clipboard/"
SRC_URI="https://github.com/jasonccox/vim-${PN}/archive/refs/tags/v${PV}.tar.gz -> vim-${P}.tar.gz"
S="${WORKDIR}/vim-${P}"

LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="gui-apps/wl-clipboard"
