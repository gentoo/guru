# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ls but with io_uring"
HOMEPAGE="https://tangled.org/rockorager.dev/lsr"

declare -g -r -A ZBS_DEPENDENCIES=(
	[ourio-0.0.0-_s-z0dAWAgD3XNod2pTh0H8X-a3CjtpAwduh7jcgBz0G.tar.gz]='https://github.com/rockorager/ourio/archive/ed8a67650e5dbb0a6dca811c9d769187e306ad94.tar.gz'
	[tls-0.1.0-ER2e0pU3BQB-UD2_s90uvppceH_h4KZxtHCrCct8L054.tar.gz]='https://github.com/ianic/tls.zig/archive/8250aa9184fbad99983b32411bbe1a5d2fd6f4b7.tar.gz'
	[zeit-0.6.0-5I6bk1J1AgA13rteb6E0steXiOUKBYTzJZMMIuK9oEmb.tar.gz]='https://github.com/rockorager/zeit/archive/4496d1c40b2223c22a1341e175fc2ecd94cc0de9.tar.gz'
	[zzdoc-0.0.0-tzT1PuPZAACr1jIJxjTrdOsLbfXS6idWFGfTq0gwxJiv.tar.gz]='https://github.com/rockorager/zzdoc/archive/57e86eb4e621bc4a96fbe0dd89ad0986db6d0483.tar.gz'
)

ZIG_SLOT="0.14"
inherit zig

SRC_URI="
	https://tangled.org/rockorager.dev/lsr/archive/refs%2Ftags%2Fv1.0.0
	${ZBS_DEPENDENCIES_SRC_URI}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( "README.md" )

src_unpack() {
	tar -xzf "${DISTDIR}/refs%2Ftags%2Fv${PV}" \
		--transform="s|^${PN}-v${PV}|${P}|" || die "Failed to unpack ${DISTDIR}/refs%2Ftags%2Fv${PV}"
	zig_src_unpack
}
