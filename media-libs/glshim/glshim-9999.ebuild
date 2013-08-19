# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libraries/openvas-libraries-6.0.0.ebuild,v 1.1 2013/07/01 10:19:17 hanno Exp $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="Runtime translation from GL 1.x to GL ES 1.x"
HOMEPAGE="https://github.com/lunixbochs/glshim"
EGIT_REPO_URI="https://github.com/ssvb/glshim.git"

SLOT="0"
LICENSE="MIT"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/opengl
	>=media-libs/mesa-9[egl,gles1,gles2]
	media-libs/glues"
DEPEND="${RDEPEND}
	dev-util/cmake"

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	local opengl_imp="glshim"
	local opengl_dir="/usr/$(get_libdir)/opengl/${opengl_imp}"
	local mesa_opengl_dir="/usr/$(get_libdir)/opengl/xorg-x11"

	insinto "${opengl_dir}/lib"
	doins "${BUILD_DIR}/src/libGL.so.1"
	dosym libGL.so.1 "${opengl_dir}/lib/libGL.so"

	dosym "/usr/$(get_libdir)/libGLUES.so" "${opengl_dir}/lib/libGLU.so"
	dosym "/usr/$(get_libdir)/libGLUES.so.1" "${opengl_dir}/lib/libGLU.so.1"

	dosym "${mesa_opengl_dir}/lib/libEGL.so" "${opengl_dir}/lib/libEGL.so"
	dosym "${mesa_opengl_dir}/lib/libEGL.so.1" "${opengl_dir}/lib/libEGL.so.1"
	dosym "${mesa_opengl_dir}/lib/libGLESv1_CM.so" "${opengl_dir}/lib/libGLESv1_CM.so"
	dosym "${mesa_opengl_dir}/lib/libGLESv1_CM.so.1" "${opengl_dir}/lib/libGLESv1_CM.so.1"
	dosym "${mesa_opengl_dir}/lib/libGLESv1_CM.so" "${opengl_dir}/lib/libGLES_CM.so"
	dosym "${mesa_opengl_dir}/lib/libGLESv1_CM.so.1" "${opengl_dir}/lib/libGLES_CM.so.1"
	dosym "${mesa_opengl_dir}/lib/libGLESv2.so" "${opengl_dir}/lib/libGLESv2.so"
	dosym "${mesa_opengl_dir}/lib/libGLESv2.so.2" "${opengl_dir}/lib/libGLESv2.so.2"
}
