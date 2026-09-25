FROM ghcr.io/ublue-os/bluefin:stable

ARG IMAGE_NAME="orca"

# Copy system files and default configurations into rootfs
COPY system_files/ /

# Run customization and package installation script
RUN chmod +x /tmp/build.sh && /tmp/build.sh && rm -rf /tmp/build.sh
