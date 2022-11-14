Project status
:warning: :warning: :warning:

The project has been archived. I don't use Fedora anymore. No updates, fixes provided at future.

#
#
#

### After installation of Fedora i3 spin https://spins.fedoraproject.org/en/i3/ run script in teminal

```bash
sudo dnf install git -y && mkdir ~/.gc && cd ~/.gc && git clone --quiet https://github.com/pietryszak/fedora-installer.git && cd fedora-installer && chmod +x install.sh && ./install.sh 
```

### After installation you can add/remove extra futures:
* Dropbox

Just open Dropbox and automatic install configure it for you

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
sed -i -e '/lon/s/21.00/SECOND VALUE OF SCRIPT/' ~/.config/redshift/redshift.conf
```

*  OpenWeader in Polybar 

In right side of polybar is small arrow, after click it an additionall bar shows a few information included a weather. To use it, you need to add OpenWeather API.
Create an API key in [OpenWeatherMap](https://home.openweathermap.org)

```bash
sed -i 's/KEY=""/KEY="YOUR_API_KEY_HERE"/g' ~/.config/polybar/scripts/openweathermap-fullfeatured.sh
```
