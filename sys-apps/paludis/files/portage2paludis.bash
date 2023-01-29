#!/bin/bash
# vim: set et sw=4 sts=4 ts=4 ft=sh :

# Copyright (c) 2006-2008, 2010 Mike Kelly <pioto@pioto.org>
#
# This file is part of the Paludis package manager. Paludis is free software;
# you can redistribute it and/or modify it under the terms of the GNU General
# Public License, version 2, as published by the Free Software Foundation.
#
# Paludis is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307  USA

# FUNCTIONS #

# appends a line of the form key="value" to the given filename under
# $outputdir. For use on files like bashrc
function append_shell_var() {
    local key="${1}" value="${2}" filename="${outputdir}/${3}"

    [[ -f "${filename}" ]] || cat <<- EOF > "${filename}"
# $(basename ${filename})
# This file created by $(basename ${0})
EOF

    [[ -z "${value}" ]] \
        || echo "${key}=\"${value}\"" >> "${filename}"
}

# appends a line of the form pkgname value to the given filename under
# $outputdir. For use on files like use.conf
function append_pkg_var() {
    local pkgname="${1}" value="${2}" filename="${outputdir}/${3}"

    [[ -f "${filename}" ]] || cat <<- EOF > "${filename}"
# $(basename ${filename})
# This file created by $(basename ${0})
EOF

    [[ -z "${value}" ]] \
        || echo "${pkgname} ${value}" >> "${filename}"
}

# Given a file path, will attempt to determine a sync url for a paludis
# repository config file.
function get_sync_url() {
    local path="${1}"

    if [[ -d "${path}/.svn" ]] ; then
        url=$(env LANG=C svn info "${path}" | grep -i "^url" | cut -d" " -f2)
        case ${url} in
            http://*|https://*)
                echo "svn+${url}"
                ;;
            svn://*|svn+ssh://*)
                echo "${url}"
                ;;
            *)
                return 1
                ;;
        esac
    elif [[ -d "${path}/CVS" ]] ; then
        return 1
    elif [[ -d "${path}/.git" ]] ; then
        url=$(git config -f "${path}/.git/config" remote.origin.url)
        if [[ -z "${url}" ]]; then
            url=$(grep -i "^url:" "${path}/.git/remotes/origin" | cut -d" " -f2)
        fi
        case ${url} in
            http://*|file://*|https://*|rsync://*|ssh://*)
                echo "git+${url}"
                ;;
            /*)
                echo "git+file://${url}"
                ;;
            *)
                return 1
                ;;
            esac
    elif [[ -d "${path}/_darcs" ]] ; then
        url=$( < "${path}/_darcs/prefs/defaultrepo" )
        case ${url} in
            http://?*)
                echo "darcs+${url}"
                ;;
            # some other kind of URL, not supported
            ?*://?*)
                return 1
                ;;
            # needs at least two chars before the colon, otherwise
            # Darcs thinks it's a Windowsesque filename
            ??*:*)
                echo "darcs+ssh://${url}"
                ;;
            # local file
            *)
                return 1
                ;;
        esac
    else
        return 1
    fi
}

# Given a file path, will separate comments from the rest
# and output the result on stdout
function split_comments() {
    sed 's/^\([^#]\+\)#\(.\+\)$/#\2\n\1/' $1
}

# needs 3 params, value to test, var to show if true, var to show if false
# basically, acts like the ? ... : ... operator in C
qmark_oper() {
    if [[ "${1}" == "y" ]] ; then
        echo "${2}"
    else
        echo "${3}"
    fi
}

canonicalise() {
    case $(uname -s) in
        FreeBSD) realpath $@ ;;
        *) readlink -f $@ ;;
    esac
}

# MAIN #

bad=

# Ask the user for an output directory.

echo "Portage2Paludis:"
echo
echo "This script will attempt to convert an existing portage configuration to"
echo "a paludis configuration. It assumes that the portage configuration can"
echo "be found via /etc/make.conf, /etc/make.profile, and /etc/portage/*"
echo
echo "WARNING: This script is still a work in progress. Do not expect it to"
echo "make completely sane decisions when migrating. Always check the produced"
echo "output yourself afterwards. Report any bugs you find to:"
echo "    Mike Kelly <pioto@pioto.org>"

if [[ "$(id -u)" -ne 0 ]] ; then
    echo
    echo "WARNING: This script will touch some of the repositories directly."
    echo "It is highly recommended that you run it as root."
fi

echo
echo "Please enter where you would like your new paludis configuration to be"
echo "created, or press enter to use the default."
echo
read -e -p "Paludis Config Directory [/etc/paludis]: " outputdir
echo
outputdir="${outputdir:-/etc/paludis}"

if [[ -d "${outputdir}" ]] ; then
    echo "An existing paludis config was found at ${outputdir}." 1>&2
    echo "Aborting." 1>&2
    exit 1
elif [[ -e "${outputdir}" ]] ; then
    echo "A file already exists where you wanted to install your paludis" 1>&2
    echo "configuration. Please remove it and try again. Aborting." 1>&2
    exit 1
fi
mkdir -p "${outputdir}" || exit 1

echo "Starting with Paludis 0.12.0, 3 optional caches were added:"
echo
echo "  A names cache, which makes finding a category/package name faster when"
echo "  just given the package name."
echo
echo "  A provides cache, which makes searching for which packages provide"
echo "  a given virtual faster."
echo
echo "  A locally-generated metadata cache. Before, Paludis could use a"
echo "  metadata cache that already existed, but now it can also generate"
echo "  one on-the-fly, caching metadata for subsequent runs." 
echo
echo "Before enabling any of these, read: http://paludis.pioto.org/overview/gettingstarted.html#repositories"
echo

read -n1 -p "Enable names cache? [y/N] " names_cache
echo
names_cache=${names_cache:-n}

read -n1 -p "Enable provides cache? [y/N] " provides_cache
echo
provides_cache=${provides_cache:-n}

read -n1 -p "Enable local metadata cache (write_cache)? [y/N] " write_cache
echo
write_cache=${write_cache:-n}
[[ "${write_cache}" == "y" ]] && mkdir -p "/var/cache/paludis/metadata"

echo "* Configuration Files:"

source_make_conf() {
    [[ -e /etc/make.conf ]] && source /etc/make.conf
    [[ -e /etc/portage/make.conf ]] && source /etc/portage/make.conf
}

echo -n "Generating use.conf (Pass 1 of 3)... "
append_pkg_var "*/*" "$(source_make_conf ; echo ${USE})" "use.conf"
echo "done."

echo -n "Generating use.conf (Pass 2 of 3)... "
for x in $(portageq envvar USE_EXPAND) ; do
    val_x=$(source_make_conf ; echo ${!x})
    if [[ -n "${val_x}" ]] ; then
        append_pkg_var "*/*" "${x}: -* ${val_x}" "use.conf"
    fi
done
echo "done."

echo -n "Generating use.conf (Pass 3 of 3)... "
if [[ -f "/etc/portage/package.use" ]]; then
    split_comments "/etc/portage/package.use" >>"${outputdir}/use.conf"
elif [[ -d "/etc/portage/package.use" ]]; then
    mkdir -p "${outputdir}/use.conf.d"
    for f in $(cd /etc/portage/package.use/; find -type f)
    do
        mkdir -p "${outputdir}/use.conf.d/$(dirname ${f})"
        split_comments "/etc/portage/package.use/${f}" >>"${outputdir}/use.conf.d/${f}.conf"
    done
fi
echo "done."

echo -n "Generating bashrc (Pass 1 of 1)... "
cflags="$(portageq envvar CFLAGS)"
cxxflags="$(portageq envvar CXXFLAGS)"
[[ "${cxxflags}" == "${cflags}" ]] && cxxflags="\${CFLAGS}"
append_shell_var "CHOST" "$(portageq envvar CHOST)" "bashrc"
append_shell_var "CFLAGS" "${cflags}" "bashrc"
append_shell_var "CXXFLAGS" "${cxxflags}" "bashrc"
append_shell_var "LDFLAGS" "$(portageq envvar LDFLAGS)" "bashrc"
append_shell_var "MAKEOPTS" "$(portageq envvar MAKEOPTS)" "bashrc"
append_shell_var "KBUILD_OUTPUT" "$(portageq envvar KBUILD_OUTPUT)" "bashrc"
echo "done."

echo -n "Generating keywords.conf (Pass 1 of 2)... "
append_pkg_var "*/*" "$(portageq envvar ACCEPT_KEYWORDS)" "keywords.conf"
echo "done."

echo -n "Generating keywords.conf (Pass 2 of 2)... "
for keywords_path in /etc/portage/package.{,accept_}keywords
do
    if [[ -f "${keywords_path}" ]]; then
        split_comments "${keywords_path}" \
        | sed 's,\*\*,*,' \
        | sed 's/^\([^#].*\/[^[:space:]]*\)$/\1 ~'$(portageq envvar ARCH)'/' \
        >>"${outputdir}/keywords.conf"
    elif [[ -d "${keywords_path}" ]]; then
        [[ -e "${outputdir}/keywords.conf.d" ]] \
            || mkdir "${outputdir}/keywords.conf.d"
        for f in $(cd "${keywords_path}/" ; find -type f)
        do
            mkdir -p "${outputdir}/keywords.conf.d/$(dirname ${f})"
            split_comments "${keywords_path}/${f}" \
            | sed 's,\*\*,*,' \
            >>"${outputdir}/keywords.conf.d/${f}.conf"
        done
    fi
done
echo "done."

echo -n "Generating mirrors.conf (Pass 1 of 1)... "
mirrors=
for m in $(portageq envvar GENTOO_MIRRORS) ; do
    mirrors="${mirrors} ${m}/distfiles"
done
append_pkg_var "*" "${mirrors}" "mirrors.conf"
echo "done."

echo -n "Generating package_mask.conf (Pass 1 of 1)... "
cat << EOF >"${outputdir}/package_mask.conf"
# package_mask.conf
# This file created by $(basename ${0})
EOF
if [[ -f "/etc/portage/package.mask" ]]; then
    split_comments "/etc/portage/package.mask" >>"${outputdir}/package_mask.conf"
elif [[ -d "/etc/portage/package.mask" ]]; then
    [[ -e "${outputdir}/package_mask.conf.d" ]] \
        || mkdir "${outputdir}/package_mask.conf.d"
    for f in $(cd /etc/portage/package.mask/ ; find -type f)
    do
        mkdir -p "${outputdir}/package_mask.conf.d/$(dirname ${f})"
        split_comments "/etc/portage/package.mask/${f}" >>"${outputdir}/package_mask.conf.d/${f}.conf"
    done
fi
echo "done."

echo -n "Generating package_unmask.conf (Pass 1 of 1)... "
cat << EOF >"${outputdir}/package_unmask.conf"
# package_unmask.conf
# This file created by $(basename ${0})
EOF
if [[ -f "/etc/portage/package.unmask" ]]; then
    split_comments "/etc/portage/package.unmask" >>"${outputdir}/package_unmask.conf"
elif [[ -d "/etc/portage/package.unmask" ]]; then
    [[ -e "${outputdir}/package_unmask.conf.d" ]] \
        || mkdir "${outputdir}/package_unmask.conf.d"
    for f in $(cd /etc/portage/package.unmask/ ; find -type f)
    do
        mkdir -p "${outputdir}/package_unmask.conf.d/$(dirname ${f})"
        split_comments "/etc/portage/package.unmask/${f}" >>"${outputdir}/package_unmask.conf.d/${f}.conf"
    done
fi
echo "done."

echo -n "Generating licenses.conf stub (Pass 1 of 1)... "
cat << EOF >"${outputdir}/licenses.conf"
# licenses.conf
# This is a stub, it accepts all licenses.
# This file created by $(basename ${0})
*/* *
EOF
echo "done."

echo
echo "* Standard Repositories:"
mkdir "${outputdir}/repositories"

portdir="$(portageq envvar PORTDIR)"
echo -n "Generating gentoo.conf (${portdir}) (Pass 1 of 1)... "
if [[ -e /etc/portage/make.profile ]]; then
    profile="$(canonicalise /etc/portage/make.profile)"
else
    profile="$(canonicalise /etc/make.profile)"
fi
cat << EOF >"${outputdir}/repositories/gentoo.conf"
location = ${portdir}
sync = $(portageq envvar SYNC)
profiles = ${profile}
distdir = $(portageq envvar DISTDIR)
format = e
names_cache = $(qmark_oper "${names_cache}" "\${location}/.cache/names" "/var/empty")
write_cache = $(qmark_oper "${write_cache}" "/var/cache/paludis/metadata" "/var/empty")
EOF
echo "done."

echo -n "Generating installed.conf (/var/db/pkg) (Pass 1 of 1)... "
cat << EOF >"${outputdir}/repositories/installed.conf"
location = /var/db/pkg/
format = vdb
names_cache = $(qmark_oper "${names_cache}" "\${location}/.cache/names" "/var/empty")
provides_cache = $(qmark_oper "${provides_cache}" "\${location}/.cache/provides" "/var/empty")
EOF
echo "done."

if [[ ! -e /var/db/pkg/world ]] ; then
    echo -n "Creating /var/db/pkg/world -> /var/lib/portage/world symlink..."
    ln -s /var/lib/portage/world /var/db/pkg/world
    echo "done."
fi
echo -n "Configuring paludis environment to look for world in /var/db/pkg/world... "
append_shell_var "world" "/var/db/pkg/world" "general.conf"
echo "done."

portdir_overlay="$(portageq envvar PORTDIR_OVERLAY)"

echo
echo "* Overlays:"

echo -n "Creating unavailable layman repo... "
cat << EOF >"${outputdir}/repositories/layman.conf"
format = unavailable
name = layman
location = /var/db/paludis/repositories/layman
sync = tar+http://git.exherbo.org/layman_repositories.tar.bz2
importance = -100
EOF
echo "done."

echo -n "Creating repository repo... "
cat << EOF >"${outputdir}/repositories/repository.conf"
format = repository
config_filename = ${outputdir}/repositories/%{repository_template_name}.conf
config_template = ${outputdir}/repository.template
EOF
echo "done."

echo -n "Creating repository repo template... "
cat << EOF >"${outputdir}/repository.template"
format = %{repository_template_format}
location = /var/db/paludis/repositories/%{repository_template_name}
sync = %{repository_template_sync}
master_repository = gentoo
EOF
echo "done."

[[ -z "${portdir_overlay}" ]] && echo "No overlays to configure."

# Needed for repo_name matching
shopt -s extglob

for o in ${portdir_overlay}; do
    # Make sure we don't reuse the last repo's name
    repo_name=

    # Get our repo_name
    [[ -f "${o}/profiles/repo_name" ]] \
        && repo_name=$(< "${o}/profiles/repo_name")

    if [[ -z "${repo_name}" ]] ; then
        mkdir -p "${o}/profiles"
        echo
        echo "The repository at \"${o}\""
        echo "is not complete. It needs to have a name. (Set in the"
        echo "profiles/repo_name file). Please enter one now."
        echo
        echo "Legal characters are: The letters A-Z (upper and lower case),"
        echo "the digits 0-9, and the symbols - (\"dash\"), + (\"plus\"),"
        echo "and _ (\"underscore\")."
        echo
        read -e -p "Name for ${o}: " repo_name
        # echo "${repo_name}" > "${o}/profiles/repo_name"
    fi
    while [[ "${repo_name}" != +([A-Za-z0-9+_-]) ]] ; do
        echo
        echo "Invalid name; try again."
        read -e -p "Name for ${o}: " repo_name
        # echo "${repo_name}" > "${o}/profiles/repo_name"
    done

    if [[ -f "${outputdir}/repositories/${repo_name}.conf" ]] ; then
        echo "While trying to generate a config for the repo called" 1>&2
        echo "\"${repo_name}\", we found we had already generated a config" 1>&2
        echo "for a config of the same name. You will have to finish" 1>&2
        echo "configuring your overlays on your own. For more info, see:" 1>&2
        echo "http://paludis.pioto.org/configuration/erepository.html" 1>&2
        bad=yes
        continue
    fi

    echo -n "Generating ${repo_name}.conf (${o}) (Pass 1 of 1)... "

    sync_url=$(get_sync_url "${o}")

    eclassdirs="${portdir}/eclass"
    [[ -d "${o}/eclass" ]] && eclassdirs="${eclassdirs} ${o}/eclass"

    cat << EOF >"${outputdir}/repositories/${repo_name}.conf"
location = ${o}
sync = ${sync_url}
#profiles = ${profile}
#eclassdirs = ${eclassdirs}
#distdir = $(portageq envvar DISTDIR)
master_repository = gentoo
format = e
names_cache = $(qmark_oper "${names_cache}" "\${location}/.cache/names" "/var/empty")
write_cache = $(qmark_oper "${write_cache}" "/var/cache/paludis/metadata" "/var/empty")
EOF
    echo "done."
done

# Not needed anymore
shopt -u extglob

if [[ -f "/etc/portage/bashrc" ]] ; then
    echo "This script did not copy your customized Portage bashrc." 1>&2
    echo "You must make any desired changes to Paludis' bashrc yourself." 1>&2
fi

echo
echo 'Complete!'
echo "You now have a new paludis config in: ${outputdir}"
echo
echo "Don't forget to double check the configuration yourself before using it."
if [[ "${names_cache}" == "y" ]] ; then
    echo
    echo "Your names caches will be created the next time you run:"
    echo
    echo "  cave sync"
    echo "    or"
    echo "  paludis --sync"
    echo "    or"
    echo "  cave fix-cache"
    echo "    or"
    echo "  paludis --regenerate-installable-cache"
    echo
    echo "You will have to create a \${location}/.cache/ directory for each of your"
    echo "repositories."
    echo "For more info, see: http://paludis.pioto.org/faq/different.html#mkdir"
fi
if [[ "${provides_cache}" == "y" ]] ; then
    echo
    echo "Your provides cache will be created the next time you run:"
    echo
    echo "  cave fix-cache"
    echo "    or"
    echo "  paludis --regenerate-installed-cache"
    echo
    echo "You will need to create the /var/db/pkg/.cache/ directory."
    echo "For more info, see: http://paludis.pioto.org/faq/different.html#mkdir"
fi

if [[ -n "${bad}" ]]; then
    echo "!!! Some errors were encountered. Check the generated configuration." >&2
    exit 1
fi
