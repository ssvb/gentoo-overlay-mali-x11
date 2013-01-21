# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit xorg-2 toolchain-funcs versionator

EGIT_REPO_URI="git://github.com/robclark/libdri2.git"
DESCRIPTION="Library for the DRI2 extension to the X Window System"

KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libdrm
	x11-proto/xproto
"
DEPEND="${RDEPEND}"
