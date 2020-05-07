import gi
gi.require_version('Gtk', '3.0')
from gi.repository import GLib
import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop


class LyricsService(dbus.service.Object):
    def __init__(self):
        bus_name = dbus.service.BusName(
            'org.musicbox.Bus', bus=dbus.SessionBus())
        dbus.service.Object.__init__(
            self, bus_name, '/')
        self.text=''
    @dbus.service.method('local.musicbox.Lyrics',
                         in_signature='s')
    def refresh_lyrics(self, text):
        if text != self.text:
            self.text=text
            self.lyrics_update(text)
    
    @dbus.service.method('local.musicbox.Lyrics',
                         out_signature='s')
    def current_lyrics(self):
        return self.text

    @dbus.service.signal('local.musicbox.Lyrics')
    def lyrics_update(self, text):
        # The signal is emitted when this method exits
        # You can have code here if you wish
        pass

DBusGMainLoop(set_as_default=True)
myservice = LyricsService()

loop= GLib.MainLoop()
loop.run()