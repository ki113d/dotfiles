import weechat
import subprocess

def onQuit(data, signal, signal_data):
    """ Callback executed when the user decideds to quit weechat. """
    subprocess.call(['notify-send', 'killWeechat'], shell=False)
    return weechat.WEECHAT_RC_OK


if __name__ == "__main__":
    weechat.register("onQuit", "Ki113d", "1.0", "GPL3",
                     "Closes tmux/screen on Weechat exit.", "", "")
    weechat.hook_signal('quit', 'onQuit', '')

