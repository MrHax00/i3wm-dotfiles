# What is this?
This is my first ever i3WM config!<br>
I've been refining it for the past few months but having seen SwayFX and how much smoother SwayWM runs I've decided to publish what I've managed to make before switching over.<br>

# BEWARE
<b>BEWARE OF EDGE CASES!!</b><br>
<sup>The lock screen image won't show up if you full screen something.</sup>
<br>

<b>BEWARE OF APRIL FOOLS STUFF</b><br>
<sup>When the date is april first the bashrc file will inject a warning before every command and a watermark similar to the activate windows one will appear upon config reload.<br>
These can be disabled by removing the april first sections from .bashrc and i3/config files.</sup>

# Screenshots:
![](https://github.com/MrHax00/i3wm-dotfiles/blob/main/Screenshots/Screenshot_20250622_231022.png?raw=true)
![](https://github.com/MrHax00/i3wm-dotfiles/blob/main/Screenshots/Screenshot_20250622_231528.png?raw=true)
![](https://github.com/MrHax00/i3wm-dotfiles/blob/main/Screenshots/Screenshot_20250622_231710.png?raw=true)
![](https://github.com/MrHax00/i3wm-dotfiles/blob/main/Screenshots/Screenshot_20250623_121016.png?raw=true)

# How to setup:
Once you've installed all the dependencies below put the following files into the following places:
<ul>
  <li><b>.bashrc</b>: your home directory</li>
  <li><b>Bashrc</b>: your home directory</li>
  <li><b>i3</b>: ~/.config/</li>
  <li><b>kitty</b>: ~/.config/</li>
  <li><b>rofi</b>: ~/.config/</li>
  <li><b>picom.conf</b>: ~/.config/</li>
</ul>

# What you need:
<ul>
  <li><b>Picom</b> as the compositor (this adds rounded corners, transparency support, blur, animations yata yata)</li>
  <li>
    <b>Rofi</b> as the sound mixer/app launcher/app switcher/emoji picker/calculator
    <ul>
      <li><b>Rofi-Calc</b></li>
      <li><b>Rofi-Emoji</b></li>
      <li>
        The sound mixer script I wrote requires the following:
        <ul>
          <li><b>Pactl</b></li>
          <li><b>Amixer</b></li>
          <li><b>AWK</b></li>
          <li><b>XDoTool</b></li>
          <li><b>XProp</b></li>
          <li><b>Perl</b></li>
          <li><b>Netpbm</b></li>
        </ul>
      </li>
    </ul>
  </li>
  <li><b>Spectacle</b> as the screen shot util (couldn't figure out how to change its theme from light to dark for the life of me as well as any other KDE application)</li>
  <li>
    <b>I3Lock</b>
    <ul>
      <li>
        The lock screen script I wrote requires the following:
        <ul>
          <li><b>Feh</b></li>
          <li><b>XDoTool</b></li>
          <li><b>WMCtrl</b></li>
        </ul>
      </li>
    </ul>
  </li>
  <li>
    <b>MPV</b> for the animated wallpaper
    <ul>
      <li>
        The wall paper script requires the following:
        <ul>
          <li><b>XRandr</b></li>
          <li><b>XDoTool</b></li>
        </ul>
      </li>
    </ul>
  </li>
  <li><b>Autotiling</b> (if you don't know what Autotiling is you're missing out)</li>
  <li><b>Activate-Linux</b> for april first</li>
  <li><b>Kitty</b> as the terminal (art by Nona/NotNona)</li>
  <li><b>JetBrains Mono</b> as the terminal font etc.</li>
  <li><b>FontAwesome</b> for workspace icons etc.</li>
</ul>
