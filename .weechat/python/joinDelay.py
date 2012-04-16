import time
import weechat

def commandCB(data, buffer, args):
    args = args.split()    
    if len(args) > 3:
        weechat.prnt("", "Error: Invalid arguments!")
        return weechat.WEECHAT_RC_OK
    time.sleep(int(args[0]))
    weechat.command(buffer, " ".join(["/join",] + args[1:]))
    return weechat.WEECHAT_RC_OK



if __name__ == "__main__":
    weechat.register("djoin", "Ki113d", "1.0", "GPL3",
                     "", "", "")
    weechat.hook_command("djoin", "", "", "", "", "commandCB", "")
