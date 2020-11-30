## Welcome to GitHub Pages

What is cheApR?

cheApR is an open-source Augmented Reality goggles system that you can build easily with the low-cost ESP32 microcontroller from Espressif and two off the shelves LCD displays.

## Why did I build it:

This project began when I saw this AR goggles project from […] on Youtube. I did a quick google search to learn more about this amazing device. Sadly like every cutting-edge hardware, it is hard and pricey to put your hands on the early models, so I decided to try to build one for myself.

A few projects inspired me while I was doing some early research, but none were as mind-blowing and eye-opening as the ScreenshotSender by Lovyan03. Without his help and amazing Lovyan03 GFX library this project would not have been possible. So feel free to go visit his blog, Twitter, and Github to get inspired.
*
*


## Is it easy to DIY:

I tried my best to make this project as easy as possible to build even for beginners. But it requires some intermediate coding and circuit building skills to complete it. You will also need a 3D printer to print all the necessary parts I said it would be easy, but believe me, you’ll be happy to play with this thing once you’re done

# Pros & cons:

This project is a proof of concept. It uses parts that can be easily ordered online. It is not fast, the total resolution is only 480x240px, it doesn’t have an HD display, sound, or any of the fancy things you see currently on the market. But it is yours to do whatever you want with, it is fully open. Just don’t steal it, it’s not cool.

 

## I’M NOT AN ENGINEER
It may come as a surprise but I have no engineering nor electronics background, which means I will use my own way to explain things that I often don’t understand myself. But you read until here so it means you are ready to proceed.

As you have seen above, cheApR doesn’t process the data onboard but only displays what your machine sends to it. To make all of this possible I was guided by Lovyan03 on how to rewrite his image sender to work on my mac, I sadly do not own a PC. My version doesn’t work as well as his sadly, you can not decide which sections of the screen you want to view independently only the exact center of your desktop. 


let’s assemble it:
If you already have an ESP32 microcontroller and some TFT or LCDs laying around, I rather you give this setup a try before ordering new parts. Go to the code section and download all project files. 

This project requires a 3D printer to generate the parts needed for the body. But I build an early prototype out of cardboard so it’s up to you.

# Parts to build cheApR:
for the frame:
* A few pairs of second hands or cheap sunglasses (for the lenses)
* 2 x 1.54 LCDs based on the ST7789 driver
* Wemos D1 Mini esp32 (tested on Node32S and TTGO Display boards)
* 1mm thickness mirrors
* TP4056 battery manager (using the Type C, but all models should be ok)
* 3.7V LiPo battery – the bigger the better
* 2x6mm Pushbuttons 
* Slide switch to control power
* Resistors: 100K & 10K value


The first level of “Fun”

# Add an ESP32 camera to spice up your build
*  I recommend the ESP-EYE from Espressif it doesn’t have the same camera issues as the ESP32CAM. 
but use whatever model you want as long as it is an esp32 based one.

More info here


The second level of Fun & Pain

# Add an ESP32 Headtracker

* I recommend the M5Stack Nano Lite for size, but any ESP32 Board should do.
* Even though the M5Stack has a built-in MPU, but I recommend using the MPU6050 gyroscope for ease of use
DOWNLOAD HERE

There are also plenty of other project that do it better
*
*

Now That you know which parts are needed to build cheApR, follow the steps below to set up Arduino and Processing.

3D Print the body
Choose one of the link and download the print files.
Thingiverse
Myminifactory

Software prep Arduino
“Arduino is an open-source electronics platform based on easy-to-use hardware and software.”

• Arduino IDE: Download here
• Esp32: Download here > or easy setup with Arduino IDE boards Manager
• Arduino Esp32FS: download here
• LittleFS: Download here
• M5Stack Library: Download here
• ESP32 Cam Webserver: Download here
• ESp32-BLE-Combo: Download here
• Button Fever: Download here

Software prep Processing
“Processing is a flexible software sketchbook and a language for learning how to code within the context of the visual arts.”

• Processing: Download here
Once you’ve installed it go to File > Examples > Add Examples > libraries
Search and install the following libraries
* Video
* ControlP5: Download and install from Source
* IPCapture: Download and install from Source
* nyar4psg: Download and install from Source
* OBJLoader: Download and install from Source
* OpenCV for processing: Download and install from Source
* PixelFlow: Download and install from Source
* ToxicLibs: Download and install from Source


LovyanGFX and ScreenShotReceiver
I’ve always wanted to build something like cheApR. but I could not get any decent frame rate on any of my previous prototypes. Then one day I stumbled upon a post on Reddit showing someone sending JPG data to an ESP32 at incredible speed. It blew me away and I knew I had to give it a go. This post led me to this blog post by HomemadeGarbage. After installing lovyanGFX and running some initial tests on a TTGO Display ESP32 microcontroller, I instantly knew lovyanGFX was steps ahead of any LCD graphics libraries, it is fast, quite easy to use.

But let’s talk about the most amazing work by Lovyan03 his ESP32_ScreenShotReceiver experiment. According to him, this is what it does: “The screen of the PC is converted to JPEG and transmitted by TCP, and received and displayed by ESP32.”. For me it does a lot more, it free any makers to build more powerful intelligent apps because the ESP32 is now only a passive tool and the heavy lifting is done by the sender app. 
 
Let’s set up the library and screenshot receiver.
LovyanGFX Github > Follow the instructions to install it.
Easier method > Arduino IDE > Tools > Manage libraries… > Search: LovyanGFX > install.

ScreenShotSender > Follow the instructions to install it.
[At this time screenshotSender is only available for PC but no worry, I wrote a buggier version that should run on your Mac/Pc/RaspberryPi machine, go to the Processing section to give it a try.]

 

Download cheApR AR suite
You will find everything you need in here to get started with your cheApR goggles. I wrote it using Processing because it allows me to easily run and test the codes on different operating systems.

* cheApR ScreenShotSender: my version of Lovyan03 ScreenShotSender app
* cheApR video: Easy way to transfer MP4 videos from your machine
* cheApR Drawing: Simple demo on how to draw on your device
* cheApR Webcam: Send webcam image, can be used with the Snapchat app, etc
* cheApR AR (ESP-EYE needed): Use this example to read AR Markers and display 3D models (very slow and buggy)
* cheApR 3D world (M5Stack HeadTracker needed): This setup allows you to navigate 3D worlds. 

Make sure to read the README.txt files contained in each folder.

Follow this link to my Github and download the package.

As I previously said I’m not the greatest coder in the world, so if you find a way to make any of the codes faster, please come to my Discord folder or fork it.

Breadboard prototype
Assemble the circuit in the way shown in the image below.

 

once done, compile and upload the codes for cheApR.

Assemble the body
I assume you have put together and tested cheApR. Print and assemble each part in the following order.

 

Once you’re done, follow the next steps to assemble your goggles.

Almost there
Now comes the most tedious part of this project, finding the right optics. It took me a long time to find the right pair of lenses and mirror combination for this project. I had to destroy a half dozen cheap and pricey pairs of glasses until I found the best type.

Finding the right mirror wasn’t easier either, it doesn’t matter if the mirror is glass or plastic. What matters is its thickness, the slimmer the mirror the better the reflection will be. 

What works:
Aviator-type lenses work best, but it’s not the shape or size that counts, it’s the curvature of the lens itself. To make cheApR work, it needs a flat but slightly curved lens. This type of lens will offer the best reflection without distorting the image too much.

Warning. Be careful with using glass mirrors, they will break and shatter when you drop them.

Make it yours
As I said I build this project to demonstrate that making Open Source A.R. goggles was possible. I hope you are as thrilled as me to see where this project could lead in a few years as faster microcontroller enters the market.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/neofuturism/cheApR/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
