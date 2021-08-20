# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

MY_PN=${PN/-/.}
COMMIT="423e6948efcbec2d708345ae21d9566cad3ad304"
DESCRIPTION="vim plugin: edit and work with APKBUILD files"
HOMEPAGE="https://gitlab.alpinelinux.org/Leo/apkbuild.vim"
SRC_URI="https://gitlab.alpinelinux.org/Leo/${MY_PN}/-/archive/${COMMIT}/${MY_PN}-${COMMIT}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="apkbuild-vim"
