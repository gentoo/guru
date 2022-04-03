# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION=" Mutable doubly-linked list with Lwt iterators "
HOMEPAGE="https://github.com/mirage/lwt-dllist"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${PN}-v${PV}.tbz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND=""
RDEPEND="${DEPEND}"
