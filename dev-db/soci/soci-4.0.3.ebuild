
EAPI=8

inherit cmake

DESCRIPTION="SOCI - The C++ Database Access Library"
HOMEPAGE="https://sourceforge.net/projects/soci/"
SRC_URI="https://sourceforge.net/projects/soci/files/soci/soci-4.0.3/${P}.tar.gz/download -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CMAKE_SKIP_TESTS=(
	soci_odbc_test_mssql
	soci_odbc_test_mssql_static
	soci_odbc_test_mysql
	soci_odbc_test_mysql_static
	soci_odbc_test_postgresql
	soci_odbc_test_postgresql_static
	soci_postgresql_test
	soci_postgresql_test_static
)

RDEPEND=">=dev-libs/boost-1.85.0-r1 >=dev-db/unixODBC-2.3.12 >=dev-db/sqlite-3.46.1"
DEPEND="${RDEPEND}"

