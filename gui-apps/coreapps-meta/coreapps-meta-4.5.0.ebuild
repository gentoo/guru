# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for coreapps"
HOMEPAGE="https://gitlab.com/cubocore/coreapps"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="
	location
	pulseaudio
	udisks
"

RDEPEND="
	~gui-apps/coreaction-${PV}
	~gui-apps/coreapps-meta-${PV}
	~gui-apps/corearchiver-${PV}
	~gui-apps/corefm-${PV}
	~gui-apps/coregarage-${PV}
	~gui-apps/corehunt-${PV}
	~gui-apps/coreimage-${PV}
	~gui-apps/coreinfo-${PV}
	~gui-apps/corekeyboard-${PV}
	~gui-apps/corepad-${PV}
	~gui-apps/corepaint-${PV}
	~gui-apps/corepdf-${PV}
	~gui-apps/corepins-${PV}
	~gui-apps/corerenamer-${PV}
	~gui-apps/coreshot-${PV}
	~gui-apps/corestats-${PV}
	~gui-apps/corestuff-${PV}
	~gui-apps/coreterminal-${PV}
	~gui-apps/coretime-${PV}
	~gui-apps/coretoppings-${PV}[location?,pulseaudio?]
	~gui-apps/coreuniverse-${PV}
	~gui-libs/libcprime-${PV}
	~gui-libs/libcsys-${PV}[udisks?]
"
