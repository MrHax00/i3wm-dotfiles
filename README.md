# What is this?
This is my first ever i3wm config!<br>
I've been refining it for the past few months but having seen swayfx and how much smoother it runs I've decided to publish what I've managed to make before switching over.<br>
<br><b>BEWARE OF THE EDGE CASES!!</b><br>
<sup>like the lock screen image not showing up if you have something full screened</sup>

# Screenshots:
![](https://github.com/MrHax00/i3wmConfig/blob/main/Screenshots/Screenshot_20250622_231022.png?raw=true)
![](https://github.com/MrHax00/i3wmConfig/blob/main/Screenshots/Screenshot_20250622_231528.png?raw=true)
![](https://github.com/MrHax00/i3wmConfig/blob/main/Screenshots/Screenshot_20250622_231710.png?raw=true)

# What you need:
<ul>
  <li><b>Picom</b> as the compositor (this adds rounded corners, transparency support, blur yata yata)</li>
  <li>
    <b>Rofi</b> as the sound mixer/app launcher/app switcher
    <ul>
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
    <b>MPV</b> (for the animated wallpaper)
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
  <li><b>Autotiling</b> (obv)</li>
</ul>
