#!/bin/sh

# Run after buildroot has built the image, and path to the built
# output/image dir is passed as first arg.  We copy the built ISO
# out of the container.

cp ${TARGET_DIR}/usr/lib/libpthread_nonshared.a ${TARGET_DIR}/usr/lib/libpthread.a