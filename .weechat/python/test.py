import weechat

def ktestCB(data, buffer, args):
    weechat.prnt("", str(type(buffer)))
    return weechat.WEECHAT_RC_OK

weechat.register("test", "Ki113d", "lolz", "YO MUMMA", "", "", "")
weechat.hook_command("ktest", "", "", "", "", "ktestCB", "")
