After installation of Fedora run script in teminal.

```bash
mkdir ~/.gc && cd ~/.gc && git clone https://github.com/pietryszak/fedora-installer.git && cd fedora-installer && chmod +x install.sh && ./install.sh 
```

If You intall inside VmWare use vm-vmware-install.sh after install.sh
```bash
cd ~/.gc && cd fedora-installer && chmod +x vm-vmware-install.sh && ./vm-vmware-install.sh
```

If You need a succesor of i3-gaps - Sway atfer install.sh use install-sway.sh. At this moment Sway has problems with vmware/virtualbox so I don't use it.
```bash
cd ~/.gc && cd fedora-installer && chmod +x sway-install.sh && ./sway-install.sh 
```
