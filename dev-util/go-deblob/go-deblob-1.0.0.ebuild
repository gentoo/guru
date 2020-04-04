# Copyright 2019-2020 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="hacktivis.me/git/go-deblob"

inherit go-module

DESCRIPTION="remove binary blobs from a directory"
HOMEPAGE="https://hacktivis.me/git/go-deblob/"
# BSD: hacktivis.me/git/go-deblob, git.sr.ht/~sircmpwn/getopt, github.com/pmezard/go-difflib
# ISC: github.com/davecgh/go-spew
# MIT: github.com/stretchr/objx, github.com/stretchr/testify
LICENSE="BSD ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

EGO_SUM=(
	"git.sr.ht/~sircmpwn/getopt v0.0.0-20190808004552-daaf1274538b h1:da5JBQ6dcW14aWnEf/pFRIMV2PsqTQEWmR+V2sw5oxU="
	"git.sr.ht/~sircmpwn/getopt v0.0.0-20190808004552-daaf1274538b/go.mod h1:wMEGFFFNuPos7vHmWXfszqImLppbc0wEhh6JBfJIUgw="
	"github.com/davecgh/go-spew v1.1.0 h1:ZDRjVQ15GmhC3fiQ8ni8+OwkZQO4DARzQgrnXU1Liz8="
	"github.com/davecgh/go-spew v1.1.0/go.mod h1:J7Y8YcW2NihsgmVo/mv3lAwl/skON4iLHjSsI+c5H38="
	"github.com/pmezard/go-difflib v1.0.0 h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM="
	"github.com/pmezard/go-difflib v1.0.0/go.mod h1:iKH77koFhYxTK1pcRnkKkqfTogsbg7gZNVY4sRDYZ/4="
	"github.com/stretchr/objx v0.1.0/go.mod h1:HFkY916IF+rwdDfMAkV7OtwuqBVzrE8GR6GFx+wExME="
	"github.com/stretchr/testify v1.3.0 h1:TivCn/peBQ7UY8ooIcPgZFpTNSz0Q2U6UrFlUfqbe0Q="
	"github.com/stretchr/testify v1.3.0/go.mod h1:M5WIy9Dh21IEIfnGCwXGc5bZfKNJtfHm1UVUgZn+9EI="
)

go-module_set_globals

SRC_URI="https://hacktivis.me/releases/${P}.tar.gz
	${EGO_SUM_SRC_URI}"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	einstalldocs
}
