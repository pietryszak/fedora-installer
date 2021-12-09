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
* Polish date and time format in system

If you not need polish date and time format in system just use this script
```bash
sudo sed -i 's/LC_NUMERIC=pl_PL.UTF-8/#LC_NUMERIC=pl_PL.UTF-8/g' /etc/locale.conf
sudo sed -i 's/LC_TIME=pl_PL.UTF-8/#LC_TIME=pl_PL.UTF-8/g' /etc/locale.conf
sudo sed -i 's/LC_MONETARY=pl_PL.UTF-8/#LC_MONETARY=pl_PL.UTF-8/g' /etc/locale.conf
sudo sed -i 's/LC_PAPER=pl_PL.UTF-8/#LC_PAPER=pl_PL.UTF-8/g' /etc/locale.conf
sudo sed -i 's/LC_MEASUREMENT=pl_PL.UTF-8/#LC_MEASUREMENT=pl_PL.UTF-8/g' /etc/locale.conf
```

* Redshift - Blue light remover 

[Redshift](https://github.com/jonls/redshift) adjusts the color temperature of your screen according to your surroundings. This may help your eyes hurt less if you are working in front of the screen at night. You can add your location to RedShift.

To take yours location use script:
```bash
redshift -l $(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq '.location.lat, .location.lng' | tr '\n' ':' | sed 's/:$//')
```

To add yours location to Redshift use this script:
```bash
sed -i -e '/lat/s/52.23/FIRST VALUE OF SCRIPT/' ~/.config/redshift/redshift.conf
sed -i -e '/lat/s/21.00/SECOND VALUE OF SCRIPT/' ~/.config/redshift/redshift.conf
```

*  OpenWeader in Polybar 

In right side of polybar is small arrow, after click it an additionall bar shows a few information included a weather. To use it, you need to add OpenWeather API.
Create an API key in [OpenWeatherMap](https://home.openweathermap.org)

```bash
sed -i 's/KEY=""/KEY="YOUR_API_KEY_HERE"/g' ~/.config/polybar/scripts/openweathermap-fullfeatured.sh
```


* Configure Spotify

In system is installed 2 version of Spotify. Spotify snap and spotify-tui. First is standard version on Spotify, second is a cli version of Spotify with low ram usage.

<p>You can choose a spotify-tui and configure it with this tutorial:</p>

Connecting to Spotify API [spotify-tui](https://github.com/Rigellute/spotify-tui#connecting-to-spotifys-api)

I prefer a spotify snap insted of spotify-tui because, spotify-tui is new project without few features.


* If You need a succesor of i3-gaps - Sway atfer install.sh use install-sway.sh. At this moment Sway has problems with vmware/virtualbox, so I don't use it.
```bash
cd ~/.gc && cd fedora-installer && chmod +x install-sway.sh && ./install-sway.sh
```
