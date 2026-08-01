# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit python-single-r1

DESCRIPTION="VanillaGreen desktop shell for Hyprland and Niri"
HOMEPAGE="https://github.com/vanillagreencom/vgs"
SRC_URI="https://github.com/vanillagreencom/vgs/releases/download/v${PV}/vgs-${PV}-source.tar.gz"
S="${WORKDIR}/vgs-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	app-misc/jq
	gui-apps/quickshell
"
BDEPEND="dev-lang/go"

src_prepare() {
	default
	sed -i 's|^#!/bin/env bash$|#!/usr/bin/env bash|' \
		config/vshell/nvim/colorschemes/tokyonight.nvim/scripts/{build,docs} || die
}

src_compile() {
	cd backend || die
	go build -mod=vendor -buildvcs=false -trimpath \
		-ldflags="-s -w -X vshell/backend/internal/registry.cliVersion=${PV}" \
		-o "${T}/vshell-backend" ./cmd/vshell-backend || die
}

src_install() {
	DESTDIR="${D}" PREFIX=/usr \
		VGS_BACKEND_BINARY="${T}/vshell-backend" \
		"${S}/packaging/install-system.sh" || die
}
