# Dissectors

## What are dissectors?

Dissectors are a core part of Wireshark that allow you to quickly decode message bytes into readable data. 

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/photos/dissectors1.PNG?raw=true)

Dissectors can be written in lua or C. 
* lua dissectors are openly viewable, simple, and do not require compilation
* C dissectors have increased performance but require compilation


## How to install lua dissectors

1. Download a LUA dissector (ex [sample LUA dissector](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/1%20Simple%20Dissector/dissectors/soildissector.lua "sample LUA dissector"))
2. Go to `Help->About Wireshark->Folders`
3. Double click the `Personal lua Plugins` directory
4. Move the LUA dissector to this folder
5. Click `Analyze->Reload lua Plugins` in Wireshark

## Tutorials

[1 Simple Dissector](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/tree/main/Dissectors/1%20Simple%20Dissector "1 Simple Dissector")

[2 More Protos](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/tree/main/Dissectors/2%20More%20Protos "2 More Protos")

[3 Dropdowns](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/3%20Dropdowns/README.md "3 Dropdowns")

[4 Add Text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/4%20Add%20Text/README.md "4 Add Text")
