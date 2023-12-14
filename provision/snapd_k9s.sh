#!/bin/bash

sudo dnf install epel-release -y
sudo dnf install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

# Wait for snapd to be ready (finish seeding)
while ! sudo snap changes | grep -q "Done.*Initialize system state"; do
    echo "Waiting for snapd to initialize..."
    sleep 5
done
sudo snap install k9s

#Snap application name
SNAP_APP="k9s"
#Target symbolic link (should be in $PATH)
LINK_TARGET_DIR="/usr/bin"

# Check if the snap app is installed
if [ -d "/var/lib/snapd/snap/$SNAP_APP" ]; then
    # Construct the full path to the current binary
    SNAP_BIN_PATH="/var/lib/snapd/snap/$SNAP_APP/current/bin/$SNAP_APP"

    # Create a symbolic link in a directory that is in $PATH
    sudo ln -s "$SNAP_BIN_PATH" "$LINK_TARGET_DIR/$SNAP_APP"

    echo "Symbolic link created for $SNAP_APP in $LINK_TARGET_DIR"
else
    echo "Snap application $SNAP_APP not found."
fi
