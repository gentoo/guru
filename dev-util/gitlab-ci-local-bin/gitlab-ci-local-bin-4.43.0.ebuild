# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="Run gitlab pipelines locally as shell executor or docker executor"
HOMEPAGE="https://github.com/firecow/gitlab-ci-local"
SRC_URI="https://github.com/firecow/gitlab-ci-local/releases/download/${PV}/linux.gz -> ${P}.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# gitlab-ci-local requires debug information to run, as it performs a
# sort of self-introspection.
RESTRICT="strip"

S="${WORKDIR}"

MY_PN="${PN/-bin/}"

QA_PREBUILT="usr/bin/gitlab-ci-local"

src_prepare() {
	default

	chmod 755 ${P} || die
}

src_compile() {
	# Generate zsh completion.
	./${P} --completion > _${MY_PN} || die
}

src_install() {
	newbin ${P} ${MY_PN}

	dozshcomp _${MY_PN}
}
