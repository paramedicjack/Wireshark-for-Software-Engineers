# Analyzing and Exporting Data

Wireshark is a self-contained logging tool with many configuration and dissector options.

However, it is often necessary to present logged data in a non-packet based format.

Wireshark has options for alternative data displays and exporting to other formats that are useful.

## Statistics tab

The statistics tab has several options for data analysis. Most are niche, but some are useful for all traffic.

### I/O Graphs

`I/O Graphs` are an option for graphically representing data within wireshark.

To create an I/O Graph for your capture, open a capture and go select `Statistics->IO Graphs` from the toolbar

This is the result of creating an `IO Graph` from this [Packets.cap](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Filters/sample_captures/Packets.cap "Packets") sample capture

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Analyzing%20and%20Exporting%20Data/photos/iographs1.PNG?raw=true)

Note that I have changed the interval to `20ms` and selected `Time Of Day` to display this data.

You can also use data filters to isolate certain packets to be part of these `IO Graphs`. Here I used the filter `soilmessage.deviceid == 2` for the red line and `soilmessage.planttype == 1` for the purple line.

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Analyzing%20and%20Exporting%20Data/photos/iographs2.PNG?raw=true)

`I/O Graphs` have limited functionality but have the ability to be modified with Wireshark filters which can make them preferable to illustrating traffic from an Excel `CSV`, for example

### Packet Lengths

The `Statistics->Packet Lengths` tab is useful for capturing rate data for packets based on their size. 

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Analyzing%20and%20Exporting%20Data/photos/packetlengths1.PNG?raw=true)

### Conversaions

The `Statistics->Conversations` tab is useful for identifying conversations in a non-sequential format.

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Analyzing%20and%20Exporting%20Data/photos/conversations1.PNG?raw=true)

TODO: more

