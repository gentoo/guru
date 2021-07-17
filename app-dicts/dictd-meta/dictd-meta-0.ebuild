# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="dictd english dictionaries metapackage"

SLOT="0"
LICENSE="GPL-2"
HOMEPAGE="http://www.dict.org"
KEYWORDS="~amd64"

RDEPEND="
	app-dicts/dictd-devils
	app-dicts/dictd-elements
	app-dicts/dictd-foldoc
	app-dicts/dictd-gazetteer
	app-dicts/dictd-jargon
	app-dicts/dictd-vera
	app-dicts/dictd-wn

	|| ( app-dicts/dictd-gcide app-dicts/dictd-web1913 )
"
