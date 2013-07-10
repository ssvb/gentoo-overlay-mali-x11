# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit multilib

DESCRIPTION="Symlinks for closed source userspace drivers for Mali 3D graphics accelerator"

LICENSE="unknown"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=">=app-admin/eselect-opengl-1.2.6"
RDEPEND="${DEPEND} media-libs/mesa[gles1,gles2]"

RESTRICT="test"

pkg_setup() {
	# expect the real libMali.so blob in /opt/mali-x11/lib/ directory
	if [ ! -e /opt/mali-x11/lib/libMali.so ] ; then
		einfo
		einfo "Please obtain the libMali.so library (with DRI2/X11 support enabled)"
		einfo "from your silicon vendor and put it into /opt/mali-x11/lib/libMali.so"
		einfo "before emerging this package."
		einfo
		einfo "    http://forums.arm.com/index.php?/topic/16259-how-can-i-upgrade-mali-device-driver/page__p__39744#entry39744"
		einfo
		einfo "If the Mali binary drivers get a clear license, which explicitly"
		einfo "allows redistribution, then this ebuild can be updated to make"
		einfo "the installation process easier. Thanks for your patience"
		einfo "and understanding."
		einfo
		die
	fi
}

src_compile() {
	# HACK: build dummy library stubs with the right sonames
	# to satisfy eselect-opengl
	gcc -shared -Wl,-soname,libEGL.so.1 -o libEGLcore.so \
		-L/opt/mali-x11/lib -lMali || die
	gcc -shared -Wl,-soname,libGLESv1_CM.so.1 -o libGLESv1_CM_core.so \
		-L/opt/mali-x11/lib -lMali || die
	gcc -shared -Wl,-soname,libGLESv2.so.2 -o libGLESv2_core.so \
		-L/opt/mali-x11/lib -lMali || die
	touch .gles-only
}

src_install() {
	local opengl_imp="mali"
	local opengl_dir="/usr/$(get_libdir)/opengl/${opengl_imp}"

	into "${opengl_dir}"
	# install dummy libraries
	dolib.so libEGLcore.so
	dolib.so libGLESv1_CM_core.so
	dolib.so libGLESv2_core.so

	# symlink for libMali.so
	dosym "/opt/mali-x11/lib/libMali.so" "/usr/$(get_libdir)/libMali.so"

	# make the symlinks for EGL/GLES stuff
	dosym "/usr/$(get_libdir)/libMali.so" "${opengl_dir}/lib/libEGL.so" 
	dosym "/usr/$(get_libdir)/libMali.so" "${opengl_dir}/lib/libEGL.so.1" 
	dosym "/usr/$(get_libdir)/libMali.so" "${opengl_dir}/lib/libGLESv1_CM.so"
	dosym "/usr/$(get_libdir)/libMali.so" "${opengl_dir}/lib/libGLESv1_CM.so.1"
	dosym "/usr/$(get_libdir)/libMali.so" "${opengl_dir}/lib/libGLESv2.so"
	dosym "/usr/$(get_libdir)/libMali.so" "${opengl_dir}/lib/libGLESv2.so.2"

	# udev rules to get the right ownership/permission for /dev/ump and /dev/mali
	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/99-mali-drivers.rules

	insinto "${opengl_dir}"
	doins .gles-only
}

pkg_postinst() {
	elog "You must be in the video group to use the Mali 3D acceleration."
	elog
	elog "To use the Mali OpenGL ES libraries, run \"eselect opengl set mali\""
}

pkg_prerm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old --ignore-missing xorg-x11
}

pkg_postrm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old --ignore-missing xorg-x11
}
