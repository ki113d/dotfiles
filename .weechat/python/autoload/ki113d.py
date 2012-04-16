import time
import subprocess

from os import popen
import weechat

settings = {
    "message": "I'm not here at the moment."
}

def npCommandCB(data, buffer, args):
    """
        Sends a string to the current buffer containing the now playing
        status of ncmpcpp.
    """
    pipe = popen("echo $(ncmpcpp --now-playing '{{{{%a - }%t}}|{%f}}')")
    weechat.command(buffer, " ".join(["/me np -", pipe.readline().strip()]))
    return weechat.WEECHAT_RC_OK

def dJoinCommandCB(data, buffer, args):
    """
        Callback for the djoin command.
        Joins a certain channel after a certain delay.
    """
    args = args.split()
    if len(args) > 3:
        weechat.prnt("", "Error: Invalid arguments!")
        return weechat.WEECHAT_RC_OK
    time.sleep(int(args[0]))
    weechat.command(buffer, " ".join(["/join",] + args[1:]))
    return weechat.WEECHAT_RC_OK

def afkCommandCB(data, buffer, args):
    """
        Callback for the afk command.
        Set's nick to 'nick|away' and executes the /away command.
    """
    if not args:
        args = weechat.config_get_plugin("message")
    if away:
        weechat.command(buffer, "/away")
        weechat.command(buffer, "/nick ki113d")
    elif not away:
        weechat.command(buffer, " ".join(["/away", args]))
        weechat.command(buffer, "/nick ki113d|away")
    weechat.config_set_plugin("away", repr(not away))
    return weechat.WEECHAT_RC_OK

def onQuit(data, signal, signalData):
    subprocess.call(["notify-send", "killWeechat"], shell=False)
    return weechat.WEECHAT_RC_OK

def scrotCommandCB(data, buffer, args):
    subprocess.call(["scrot", time.strftime("%a_%d_%b_%Y_%H-%M-%S.png") if not args else args], shell=False)
    return weechat.WEECHAT_RC_OK

if __name__ == "__main__":
    weechat.register("ki113d", "Ki113d", "1.0", "GPL3",
                     "", "", "")
    weechat.hook_command("djoin", "", "", "", "", "dJoinCommandCB", "")
    weechat.hook_command("afk", "", "", "", "", "afkCommandCB", "")
    weechat.hook_command("np", "", "", "", "", "npCommandCB", "")
    weechat.hook_command("scrot", "", "", "", "", "scrotCommandCB", "")
    weechat.hook_signal('quit', 'onQuit', '')
