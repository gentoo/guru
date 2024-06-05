# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

MY_PN=${PN/-/.}
COMMIT="8dbd9745f76fb284656711238e8cd42d021da85e"
DESCRIPTION="vim plugin: edit and work with APKBUILD files"
HOMEPAGE="https://gitlab.alpinelinux.org/Leo/apkbuild.vim"
SRC_URI="https://gitlab.alpinelinux.org/Leo/${MY_PN}/-/archive/${COMMIT}/${MY_PN}-${COMMIT}.tar.bz2"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="apkbuild-vim"
