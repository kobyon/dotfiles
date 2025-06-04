# Hiearchy for local user files
Personal reminder for what the different folders under ~/.local/ is used for.

bin - binary files.  Systemlinkes to lib, opt or scripts
src - git repos and other source code.  Should contain little to no compiled code
lib - compiled software used for programs not intended to be launced by the user (me)
opt - downloaded software as .tar.xx or AppImages.  Usually systemlinked to bin, or launced by .desktop files
