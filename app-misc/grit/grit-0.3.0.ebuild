# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/climech/naturalsort v0.1.0 h1:RerFYAgz3gxoSGTsvbecDKrv5BJkDDj6D6BQiykhHu8="
	"github.com/climech/naturalsort v0.1.0/go.mod h1:QHbmEAQ0dpDa3j+BX6rM1t24knxySiHH+ef3ziY79K4="
	"github.com/davecgh/go-spew v1.1.0/go.mod h1:J7Y8YcW2NihsgmVo/mv3lAwl/skON4iLHjSsI+c5H38="
	"github.com/davecgh/go-spew v1.1.1 h1:vj9j/u1bqnvCEfJOwUhtlOARqs3+rkHYY13jYWTU97c="
	"github.com/davecgh/go-spew v1.1.1/go.mod h1:J7Y8YcW2NihsgmVo/mv3lAwl/skON4iLHjSsI+c5H38="
	"github.com/fatih/color v1.10.0 h1:s36xzo75JdqLaaWoiEHk767eHiwo0598uUxyfiPkDsg="
	"github.com/fatih/color v1.10.0/go.mod h1:ELkj/draVOlAH/xkhN6mQ50Qd0MPOk5AAr3maGEBuJM="
	"github.com/jawher/mow.cli v1.2.0 h1:e6ViPPy+82A/NFF/cfbq3Lr6q4JHKT9tyHwTCcUQgQw="
	"github.com/jawher/mow.cli v1.2.0/go.mod h1:y+pcA3jBAdo/GIZx/0rFjw/K2bVEODP9rfZOfaiq8Ko="
	"github.com/kirsle/configdir v0.0.0-20170128060238-e45d2f54772f h1:dKccXx7xA56UNqOcFIbuqFjAWPVtP688j5QMgmo6OHU="
	"github.com/kirsle/configdir v0.0.0-20170128060238-e45d2f54772f/go.mod h1:4rEELDSfUAlBSyUjPG0JnaNGjf13JySHFeRdD/3dLP0="
	"github.com/mattn/go-colorable v0.1.8 h1:c1ghPdyEDarC70ftn0y+A/Ee++9zz8ljHG1b13eJ0s8="
	"github.com/mattn/go-colorable v0.1.8/go.mod h1:u6P/XSegPjTcexA+o6vUJrdnUu04hMope9wVRipJSqc="
	"github.com/mattn/go-isatty v0.0.12 h1:wuysRhFDzyxgEmMf5xjvJ2M9dZoWAXNNr5LSBS7uHXY="
	"github.com/mattn/go-isatty v0.0.12/go.mod h1:cbi8OIDigv2wuxKPP5vlRcQ1OAZbq2CE4Kysco4FUpU="
	"github.com/mattn/go-sqlite3 v2.0.3+incompatible h1:gXHsfypPkaMZrKbD5209QV9jbUTJKjyR5WD3HYQSd+U="
	"github.com/mattn/go-sqlite3 v2.0.3+incompatible/go.mod h1:FPy6KqzDD04eiIsT53CuJW3U88zkxoIYsOqkbpncsNc="
	"github.com/pmezard/go-difflib v1.0.0 h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM="
	"github.com/pmezard/go-difflib v1.0.0/go.mod h1:iKH77koFhYxTK1pcRnkKkqfTogsbg7gZNVY4sRDYZ/4="
	"github.com/stretchr/objx v0.1.0/go.mod h1:HFkY916IF+rwdDfMAkV7OtwuqBVzrE8GR6GFx+wExME="
	"github.com/stretchr/objx v0.2.0/go.mod h1:qt09Ya8vawLte6SNmTgCsAVtYtaKzEcn8ATUoHMkEqE="
	"github.com/stretchr/testify v1.3.0/go.mod h1:M5WIy9Dh21IEIfnGCwXGc5bZfKNJtfHm1UVUgZn+9EI="
	"github.com/stretchr/testify v1.4.0 h1:2E4SXV/wtOkTonXsotYi4li6zVWxYlZuYNCXe9XRJyk="
	"github.com/stretchr/testify v1.4.0/go.mod h1:j7eGeouHqKxXV5pUuKE4zz7dFj8WfuZ+81PSLYec5m4="
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae h1:/WDfKMnPU+m5M4xB+6x4kaepxRw6jWvR5iDRdvjHgy8="
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405 h1:yhCVgyC4o1eVCa2tZl7eS0r+SDo693bJlVdllGtEeKM="
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod h1:Co6ibVJAznAaIkqp8huTwlJQCZ016jof/cbN4VW5Yz0="
	"gopkg.in/yaml.v2 v2.2.2/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI="
	"gopkg.in/yaml.v2 v2.2.5 h1:ymVxjfMaHvXD8RqPRmzHHsB3VvucivSkIAvJFDI5O3c="
	"gopkg.in/yaml.v2 v2.2.5/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI="
)

go-module_set_globals

DESCRIPTION="An personal task manager that represents tasks as multitree nodes"
HOMEPAGE="https://github.com/climech/grit"
SRC_URI="
	https://github.com/climech/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="MIT ISC BSD BSD-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/go-1.14
"

src_install() {
	emake DESTDIR="${D}" PREFIX='/usr' install
}
