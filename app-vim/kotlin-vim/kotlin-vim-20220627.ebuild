# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

SHA="1261f851e5fb2192b3a5e1691650597c71dfce2f"

DESCRIPTION="Kotlin plugin for Vim."
HOMEPAGE="https://github.com/udalov/kotlin-vim"
SRC_URI="https://github.com/udalov/kotlin-vim/archive/${SHA}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${SHA}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~ppc64 ~x86"

VIM_PLUGIN_HELPFILES="README.md"
VIM_PLUGIN_HELPURI="https://github.com/udalov/kotlin-vim"
