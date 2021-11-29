### After installation of Fedora run script in teminal

```bash
mkdir ~/.gc && cd ~/.gc && git clone https://github.com/pietryszak/fedora-installer.git && cd fedora-installer && chmod +x install.sh && ./install.sh 
```

### If You install inside VmWare use vm-vmware-install.sh after script above
It's a mandatory because vm mashines need another polybar config and use terminator terminal insted kitty, because kitty is not usable in vm.
```bash
cd ~/.gc && cd fedora-installer && chmod +x vm-vmware-install.sh && ./vm-vmware-install.sh
```

---

### After installation you can add extra futures:
*  OpenWeader in Polybar 

In right side of polybar is small arrow, after click it an additionall bar shows a few information included a weather. To use it, you need to add OpenWeather API.
Create an API key in [OpenWeatherMap](https://home.openweathermap.org)

```bash
sed -i 's/KEY=""/KEY="YOUR_API_KEY_HERE"/g' ~/.config/polybar/scripts/openweathermap-fullfeatured.sh
```


* Configure Spotify

In system is installed 3 version of Spotify. Spotify flatpak, ncspot and spotify-tui. First is standard version on Spotify, second and third is a cli version of Spotify with low ram usage.

<p>You can choose a spotify-tui and configure it with this tutorial:</p>

Connecting to Spotify API [spotify-tui](https://github.com/Rigellute/spotify-tui#connecting-to-spotifys-api)

You can choose a ncspot. After first startup of ncspot, prompt ask for login and password to Spotify and open a new tab in Firefox for confirm Spotify credentials. I prefer a spotify-tui insted of ncspot because, spotify-tui is new project written in fast rust programming language.


* If You need a succesor of i3-gaps - Sway atfer install.sh use install-sway.sh. At this moment Sway has problems with vmware/virtualbox, so I don't use it.
```bash
cd ~/.gc && cd fedora-installer && chmod +x install-sway.sh && ./install-sway.sh
```
