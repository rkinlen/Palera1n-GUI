import os
import subprocess
import time
import tkinter as tk
from tkinter import *
from tkinter import messagebox
from tkinter.messagebox import showinfo
import webbrowser
from PIL import ImageTk, Image

path = os.getcwd()

print(path)

LAST_CONNECTED_UDID = ""
LAST_CONNECTED_IOS_VER = ""

def execute_command(command):
    osascript_command = 'osascript -e \'tell application "Terminal" to do script "{}"\''.format(command)
    subprocess.call(osascript_command, shell=True)

def detectDevice():
    global LAST_CONNECTED_UDID, LAST_CONNECTED_IOS_VER
    print("Searching for connected device...")
    os.system("idevicepair unpair")
    os.system("idevicepair pair")
    os.system("./palera1n/kinlen_scripts/ideviceinfo > ./palera1n/kinlen_scripts/lastdevice.txt")
    time.sleep(2)

    with open("./palera1n/kinlen_scripts/lastdevice.txt", "r") as f:
        fileData = f.read()

    if "ERROR:" in fileData:
        print("ERROR: No device found!")
        messagebox.showinfo("No device detected! 0x404", "Try disconnecting and reconnecting your device.")
    else:
        start = 'UniqueDeviceID: '
        end = 'UseRaptorCerts:'
        s = str(fileData)
        foundData = s[s.find(start) + len(start):s.rfind(end)]
        UDID = str(foundData)
        LAST_CONNECTED_UDID = str(UDID)

        start2 = 'ProductVersion: '
        end2 = 'ProductionSOC:'
        s2 = str(fileData)
        foundData2 = s2[s.find(start2) + len(start2):s2.rfind(end2)]
        deviceIOS = str(foundData2)
        LAST_CONNECTED_IOS_VER = str(deviceIOS)

        if len(UDID) > 38:
            print("Found UDID: " + LAST_CONNECTED_UDID)
            messagebox.showinfo("iDevice is detected!", "Found iDevice on iOS " + LAST_CONNECTED_IOS_VER)
            cbeginExploit10["state"] = "normal"
        else:
            print("Couldn't find your device")
            messagebox.showinfo("Somethings missing! 0x405", "Try disconnecting and reconnecting your device.")

def rootfull_jailbreak():
    command = "bash /Users/rorykinlen/Downloads/Palera1nGUI/rootfull/jailbreak.sh"
    execute_command(command)
    print("Device is jailbroken!\n")
    showinfo('Jailbreak Success!', 'Device is now jailbroken!')

def rootfull_rejailbreak():
    command = "bash /Users/rorykinlen/Downloads/Palera1nGUI/rootfull/rejailbreak.sh"
    execute_command(command)
    print("Device is jailbroken!\n")
    showinfo('Jailbreak Success!', 'Device is now jailbroken!')

def rootless_jailbreak():
    command = "bash /Users/rorykinlen/Downloads/Palera1nGUI/rootless/jailbreak.sh"
    execute_command(command)
    print("Device is jailbroken!\n")
    showinfo('Jailbreak Success!', 'Device is now jailbroken!')

def rootless_rejailbreak():
    command = "bash /Users/rorykinlen/Downloads/Palera1nGUI/rootless/rejailbreak.sh"
    execute_command(command)
    print("Device is jailbroken!\n")
    showinfo('Jailbreak Success!', 'Device is now jailbroken!')

def exitRecMode():
    print("Kicking device out of recovery mode...")
    os.system("./palera1n/kinlen_scripts/exitrecovery.sh")
    messagebox.showinfo("Sent command!", "Kicked device out of recovery mode!\n\nNow if your device is not exiting recovery mode still and keeps looping to it, either re-jailbreak with the same jailbreak you did or remove the jailbreak you installed.")

def showDFUMessage():
    messagebox.showinfo("Step 1", "Put your iDevice into DFU mode.\n\nClick Ok once it's ready in DFU mode to proceed.")

def startDFUCountdown():
    print("Get ready to put device into DFU mode...")

def enterRecMode():
    print("Kicking device into recovery mode...")
    os.system("./palera1n/kinlen_scripts/enterrecovery.sh")

def installDependenciesSH():
    print("Running install dep script...")
    os.system("bash ./install_deps.sh")
    print("Ran install deps!")
    messagebox.showinfo("Dependencies done!", "We installed the required dependencies!\n\nNow you should be able to use the program without issues!")

def callback(url):
    webbrowser.open_new_tab(url)

def quitProgram():
    print("Exiting...")
    os.system("exit")


root = tk.Tk()
frame = tk.Frame(root, width="600", height="300")

frame.pack(fill=BOTH, expand=True)
root.iconphoto(False, tk.PhotoImage(file='logo.png'))
root.title('Palera1n GUI v1.2.4 - Made by @MrCreator1 updated by @RoryKinlen + thanks to @palera1n team')
frame.pack()

image = Image.open("logo.png")
new_width = 100
new_height = 100
resized_image = image.resize((new_width, new_height))
img = ImageTk.PhotoImage(resized_image)
label = Label(frame, image=img)
label.place(x=150, y=30)

my_label2 = Label(frame, text="Designed for iOS 15.0 - 16.x")
my_label2.place(x=300, y=100)

my_label3 = Label(frame, text="ver 1.2.5")
my_label3.place(x=10, y=290)

cdetectDevice = tk.Button(frame, text="Pair iDevice", command=detectDevice)
cdetectDevice.place(x=40, y=150)

cbeginExploit10 = tk.Button(frame, text="Rootfull Jailbreak", command=rootfull_jailbreak)
cbeginExploit10.place(x=150, y=170)

cbeginExploit12 = tk.Button(frame, text=" Rootfull Rejailbreak", command=rootfull_rejailbreak)
cbeginExploit12.place(x=150, y=200)

cbeginExploit13 = tk.Button(frame, text="Rootless Jailbreak", command=rootless_jailbreak)
cbeginExploit13.place(x=350, y=170)

cbeginExploit14 = tk.Button(frame, text=" Rootless Rejailbreak", command=rootless_rejailbreak)
cbeginExploit14.place(x=350, y=200)

cexitRecovery = tk.Button(frame, text="Exit Recovery Mode", command=exitRecMode)
cexitRecovery.place(x=50, y=250)

link = Label(root, text="Made this GUI @MrCreator1 updated by @RoryKinlen", font=('Helveticabold', 12), cursor="hand2")
link.place(x=100, y=350)
link.bind("<Button-1>", lambda e: callback("https://twitter.com/RoryKinlen"))

link2 = Label(root, text="Thanks to Jailbreak @palera1n team", font=('Helveticabold', 12), cursor="hand2")
link2.place(x=300, y=290)
link2.bind("<Button-1>", lambda e: callback("https://twitter.com/palera1n"))

root.geometry("600x320")
root.resizable(False, False)
root.eval('tk::PlaceWindow . center')

root.mainloop()
