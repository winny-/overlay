# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-r3 savedconfig toolchain-funcs multilib

DESCRIPTION='a fast, lightweight, vim-like browser based on webkit'
HOMEPAGE='http://fanglingsu.github.io/vimb/'
SRC_URI=''
EGIT_REPO_URI="https://github.com/fanglingsu/${PN}.git"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS=''
IUSE='savedconfig'

RDEPEND='
	>=net-libs/webkit-gtk-2.8.0:4
'
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	sed -i "s,/lib/,/$(get_libdir)/," config.mk || \
		die 'unable to fix lib install prefix'

	use savedconfig && restore_config src/config.def.h

	default
}

src_compile() {
	emake PREFIX="${ROOT}/usr" CC="$(tc-getCC)"
}

src_install() {
	emake PREFIX="${ROOT}/usr" DESTDIR="${D}" install

	use savedconfig && save_config src/config.def.h
}
