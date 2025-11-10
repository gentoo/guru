# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Open source monospace font with round corners"
HOMEPAGE="https://font.subf.dev/"
SRC_URI="!normal? ( ligature? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMono-TTF.zip -> ${P}-ligature-tff.zip
                                nerd? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMono-NF-unhinted.zip -> ${P}-ligature-nerd.zip )
                                cn? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMono-CN-unhinted.zip -> ${P}-ligature-cn.zip ) )
                    !ligature? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMonoNL-TTF.zip -> ${P}-tff.zip
                                nerd? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMonoNL-NF-unhinted.zip -> ${P}-nerd.zip )
                                cn? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMonoNL-CN-unhinted.zip -> ${P}-cn.zip ) ) )
         normal? ( ligature? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMonoNormal-TTF.zip -> ${P}-normal-ligature-tff.zip
                                nerd? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMonoNormal-NF-unhinted.zip -> ${P}-normal-ligature-nerd.zip )
                                cn? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMonoNormal-CN-unhinted.zip -> ${P}-normal-ligature-cn.zip ) )
                    !ligature? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMonoNormalNL-TTF.zip -> ${P}-normal-tff.zip
                                nerd? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMonoNormalNL-NF-unhinted.zip -> ${P}-normal-nerd.zip )
                                cn? ( https://github.com/subframe7536/maple-font/releases/download/v${PV}/MapleMonoNormalNL-CN-unhinted.zip -> ${P}-normal-cn.zip ) ) )"

S=${WORKDIR}

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86 ~amd64-linux ~x86-linux ~x64-macos"

BDEPEND="app-arch/unzip"

IUSE="normal ligature nerd cn"

FONT_SUFFIX="ttf"
FONT_S="${WORKDIR}"
