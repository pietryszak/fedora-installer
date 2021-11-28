**After installation of Fedora run script in teminal.**

```bash
mkdir ~/.gc && cd ~/.gc && git clone https://github.com/pietryszak/fedora-installer.git && cd fedora-installer && chmod +x install.sh && ./install.sh 
```

**If You install inside VmWare use vm-vmware-install.sh after script above**
```bash
cd ~/.gc && cd fedora-installer && chmod +x vm-vmware-install.sh && ./vm-vmware-install.sh
```
---
**After installation you can add extra futures:**
* ###### OpenWeader in Polybar
###### Create a api key in [OpenWeaderMap](https://home.openweathermap.org/.)
```bash
sed -i 's/KEY=""/KEY="YOUR_API_KEY_HERE"/g' ~/.config/polybar/scripts/openweathermap-fullfeatured.sh
```

* ###### Configure Spotify
###### In system is instaled 3 version of Spotify. Spotify flatpak, ncspot and spotify-tui. First is standard version on Spotify, second and third is a cli version of Spotify with low ram usage. 
###### After first startup of ncspot, prompt ask for login and password to Spotify and open a new tab in Firefox for confirm Spotify credentials. I prefer a ncspot insted of spotify-tui because, spotify-tui is new project without few futures.
###### You can choose a spotify-tui and configure it with this tutorial:

###### Connecting to Spotify api [spotify-tui](https://github.com/Rigellute/spotify-tui#connecting-to-spotifys-api)


* ###### If You need a succesor of i3-gaps - Sway atfer install.sh use install-sway.sh. At this moment Sway has problems with vmware/virtualbox, so I don't use it.
```bash
cd ~/.gc && cd fedora-installer && chmod +x install-sway.sh && ./install-sway.sh
```
