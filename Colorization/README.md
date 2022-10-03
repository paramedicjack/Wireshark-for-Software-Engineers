# Colorization

Wireshark is deeply configurable down to the colors of filtered traffic.

## Colorize a conversation

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Colorization/photos/colorization1.PNG?raw=true)

1. Select `View->Coloring Rules` from the Wireshark toolbar
2. Press the `+` button to create a new coloring rule
3. Name the coloring rule anything you would like
4. Enter a filter and/or filter macro into the `Filter` column
5. Check the box to enable a coloring rule
6. Select the foreground and background colors by clicking on their respective boxes

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Colorization/photos/colorization2.PNG?raw=true)

Unlike default filter bookmarks, it is not recommended to delete default colorization rules, especially with common packet types like UDP and TCP. 

## Uses for colorized packets

1. Can be used to highlight important messages or errors in a log
2. Can be used in conjunction with dissectors to highlight changes in traffic
