# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_PN="github.com/x-motemen/ghq"
EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1/go.mod h1:xHWCNGjB5oqiDr8zfno3MHue2Ht5sIBksp03qcyfWMU="
	"github.com/Songmu/gitconfig v0.0.3 h1:mLLrCol+zLOxbX/0Pp+O8VgEjBPEMu3bZyw+vs/wBY8="
	"github.com/Songmu/gitconfig v0.0.3/go.mod h1:0b3ML3J86L0tp1SB7qU4vZfezHS2s+PIczPsf23GAdk="
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d h1:U+s90UTSYgptZMwQh2aRr3LuazLJIa+Pg3Kc1ylSYVY="
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d/go.mod h1:maD7wRr/U5Z6m/iR4s+kqSMx2CaBsrgA7czyZG/E6dU="
	"github.com/cpuguy83/go-md2man/v2 v2.0.0 h1:EoUDS0afbrsXAZ9YQ9jdu/mZ2sXgT1/2yyNng4PGlyM="
	"github.com/cpuguy83/go-md2man/v2 v2.0.0/go.mod h1:maD7wRr/U5Z6m/iR4s+kqSMx2CaBsrgA7czyZG/E6dU="
	"github.com/daviddengcn/go-colortext v0.0.0-20180409174941-186a3d44e920 h1:d/cVoZOrJPJHKH1NdeUjyVAWKp4OpOT+Q+6T1sH7jeU="
	"github.com/daviddengcn/go-colortext v0.0.0-20180409174941-186a3d44e920/go.mod h1:dv4zxwHi5C/8AeI+4gX4dCWOIvNi7I6JCSX0HvlKPgE="
	"github.com/golangplus/bytes v0.0.0-20160111154220-45c989fe5450 h1:7xqw01UYS+KCI25bMrPxwNYkSns2Db1ziQPpVq99FpE="
	"github.com/golangplus/bytes v0.0.0-20160111154220-45c989fe5450/go.mod h1:Bk6SMAONeMXrxql8uvOKuAZSu8aM5RUGv+1C6IJaEho="
	"github.com/golangplus/fmt v0.0.0-20150411045040-2a5d6d7d2995 h1:f5gsjBiF9tRRVomCvrkGMMWI8W1f2OBFar2c5oakAP0="
	"github.com/golangplus/fmt v0.0.0-20150411045040-2a5d6d7d2995/go.mod h1:lJgMEyOkYFkPcDKwRXegd+iM6E7matEszMG5HhwytU8="
	"github.com/golangplus/testing v0.0.0-20180327235837-af21d9c3145e h1:KhcknUwkWHKZPbFy2P7jH5LKJ3La+0ZeknkkmrSgqb0="
	"github.com/golangplus/testing v0.0.0-20180327235837-af21d9c3145e/go.mod h1:0AA//k/eakGydO4jKRoRL2j92ZKSzTgj9tclaCrvXHk="
	"github.com/mattn/go-isatty v0.0.12 h1:wuysRhFDzyxgEmMf5xjvJ2M9dZoWAXNNr5LSBS7uHXY="
	"github.com/mattn/go-isatty v0.0.12/go.mod h1:cbi8OIDigv2wuxKPP5vlRcQ1OAZbq2CE4Kysco4FUpU="
	"github.com/motemen/go-colorine v0.0.0-20180816141035-45d19169413a h1:CONqI/36EjYzkAzrMD0UWuL/lRDr7UdoID4fDGke+Yc="
	"github.com/motemen/go-colorine v0.0.0-20180816141035-45d19169413a/go.mod h1:PU2urRC7j30rrabSyp1MGGhyoiWSninPD8ckjzBSgkU="
	"github.com/pmezard/go-difflib v1.0.0 h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM="
	"github.com/pmezard/go-difflib v1.0.0/go.mod h1:iKH77koFhYxTK1pcRnkKkqfTogsbg7gZNVY4sRDYZ/4="
	"github.com/russross/blackfriday/v2 v2.0.1 h1:lPqVAte+HuHNfhJ/0LC98ESWRz8afy9tM/0RK8m9o+Q="
	"github.com/russross/blackfriday/v2 v2.0.1/go.mod h1:+Rmxgy9KzJVeS9/2gXHxylqXiyQDYRxCVz55jmeOWTM="
	"github.com/saracen/walker v0.0.0-20191201085201-324a081bae7e h1:NO86zOn5ScSKW8wRbMaSIcjDZUFpWdCQQnexRqZ9h9A="
	"github.com/saracen/walker v0.0.0-20191201085201-324a081bae7e/go.mod h1:G0Z6yVPru183i2MuRJx1DcR4dgIZtLcTdaaE/pC1BJU="
	"github.com/shurcooL/sanitized_anchor_name v1.0.0 h1:PdmoCO6wvbs+7yrJyMORt4/BmY5IYyJwS/kOiWx8mHo="
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod h1:1NzhyTcUVG4SuEtjjoZeVRXNmyL/1OwPU0+IJeTBvfc="
	"github.com/urfave/cli/v2 v2.1.1 h1:Qt8FeAtxE/vfdrLmR3rxR6JRE0RoVmbXu8+6kZtYU4k="
	"github.com/urfave/cli/v2 v2.1.1/go.mod h1:SE9GqnLQmjVa0iPEY0f1w3ygNIYcIJ0OKPMoW2caLfQ="
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod h1:djNgcEr1/C05ACkg1iLfiJU5Ep61QUkGW8qpdssI0+w="
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod h1:z5CRVTTTmAJ677TzLLGU+0bjPO0LkuOLi4/5GtJWs/s="
	"golang.org/x/net v0.0.0-20200114155413-6afb5195e5aa h1:F+8P+gmewFQYRk6JoLQLwjBCTu3mcIURZfNkVweuRKA="
	"golang.org/x/net v0.0.0-20200114155413-6afb5195e5aa/go.mod h1:z5CRVTTTmAJ677TzLLGU+0bjPO0LkuOLi4/5GtJWs/s="
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM="
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e h1:vcxGaoTs7kV8m5Np9uUNQin4BrLOthgV7252N8V+FwY="
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM="
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY="
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42 h1:vEOn+mP2zCOVzKckCZy6YsCtDblrpj/w7B9nxGNELpg="
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"golang.org/x/sys v0.0.0-20200121082415-34d275377bf9 h1:N19i1HjUnR7TF7rMt8O4p3dLvqvmYyzB6ifMFmrbY50="
	"golang.org/x/sys v0.0.0-20200121082415-34d275377bf9/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"golang.org/x/text v0.3.0/go.mod h1:NqM8EUOU14njkJ3fqMW+pc6Ldnwhi/IjpwHt7yyuwOQ="
	"golang.org/x/tools v0.0.0-20191011211836-4c025a95b26e h1:1o2bDs9pCd2xFhdwqJTrCIswAeEsn4h/PCNelWpfcsI="
	"golang.org/x/tools v0.0.0-20191011211836-4c025a95b26e/go.mod h1:b+2E5dAYhXwXZwtnZ6UAqBI28+e2cm9otk0dWdXHAEo="
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod h1:I/5z698sn9Ka8TeJc9MKroUUfqBBauWjQqLJ2OPfmY0="
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405 h1:yhCVgyC4o1eVCa2tZl7eS0r+SDo693bJlVdllGtEeKM="
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod h1:Co6ibVJAznAaIkqp8huTwlJQCZ016jof/cbN4VW5Yz0="
	"gopkg.in/yaml.v2 v2.2.2 h1:ZCJp+EgiOT7lHqUV2J862kp8Qj64Jo6az82+3Td9dZw="
	"gopkg.in/yaml.v2 v2.2.2/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI="
	"gopkg.in/yaml.v2 v2.2.7 h1:VUgggvou5XRW9mHwD/yXxIYSMtY0zoKQf/v226p2nyo="
	"gopkg.in/yaml.v2 v2.2.7/go.mod h1:hI93XBmqTisBFMUTm0b8Fm+jr3Dg1NNxqwp+5A1VGuI="
)

go-module_set_globals

DESCRIPTION="Remote repository management made easy"
HOMEPAGE="https://github.com/x-motemen/ghq"
SRC_URI="https://github.com/x-motemen/ghq/archive/v${PV}.tar.gz -> ${P}.tar.gz
			${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	go build -work -o "bin/${PN}" ./ || die
}

src_install() {
	dobin bin/${PN}
	dodoc README.adoc
}
