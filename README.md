This is setup for stow

https://addons.mozilla.org/firefox/downloads/file/4259790/vimium_ff-2.1.2.xpi

chmod +x gh_setup.sh
chmod +x ubuntu.sh
./ubuntu_apps.sh
./gh_setup.sh

git clone git@github.com:MyMOC/front-end.git
git clone git@github.com:MyMOC/mymoc.git
git clone git@github.com:johnMocingbird/mydots-stow.git


cd /home/parallels/Desktop/Parallels Shared Folders/iCloud
cp latest.dump ~/mymoc/docker/
cp env.development.local ~/mymoc/.env.development.local

cd mymoc/docker


# Focus Kitty
bindsym Control+t [class="Kitty"] focus

# Focus Firefox
bindsym Control+w [class="Firefox"] focus
