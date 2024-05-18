# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RHVOICE_LANG="English"
RHVOICE_LANG_TAG=${PV//./-}
inherit rhvoice-lang

LICENSE="LGPL-2.1+"
