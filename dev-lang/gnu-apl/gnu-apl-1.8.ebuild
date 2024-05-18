# Copyright 2022-2023 Laura Aléanor
# Distributed under the terms of the GNU General Public License v3 or later

EAPI=8

DESCRIPTION="GNU interpreter for the APL programming language"
HOMEPAGE="https://www.gnu.org/software/apl/"
SRC_URI="mirror://gnu/apl/apl-${PV}.tar.gz"

S="${WORKDIR}/apl-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="static-libs erlang libapl python gtk3 pcre2 sqlite3 postgresql"

BDEPEND="dev-vcs/subversion"

RDEPEND="gtk3? ( >=gui-libs/gtk-3.0.0 )
		 sqlite3? ( >=dev-db/sqlite-3.0.0 )
		 postgresql? ( dev-db/postgresql )
		 pcre2? ( dev-libs/libpcre2 )"

src_configure () {
	econf $(use_enable static-libs static)\
		  $(use erlang && echo --with-erlang)\
		  $(use libapl && echo --with-libapl)\
		  $(use python && echo --with-python)\
		  $(use gtk3 && echo --with-gtk3)\
		  $(use pcre2 && echo --with-pcre)\
		  $(use sqlite3 && echo --with-sqlite3)\
		  $(use postgresql && echo --with-postgresql)\
		  CXX_WERROR=no
}
