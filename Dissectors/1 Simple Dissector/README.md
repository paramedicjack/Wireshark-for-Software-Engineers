# Simple Dissector

In this example you will be learning how to write your first lua dissector. We will write the dissector from scratch. 

The full dissector will be included in the tutorial and as a link in the `References` section.

## System characteristics

* You have a series of Raspberry Pi-based soil monitors (IP addresses `10.0.0.20-10.0.0.24`) connected to your computer (IP address `10.0.0.10`) via an ethernet switch.
* Each Raspberry PI sends a message to your PC over port `40000`. 
* The message payload has two bytes. The bytes represent `uint8t's` `device ID` and `plant type`. Each of these fields is `1 byte` long. 

## The task

You must create a LUA dissector that shows a decoded version of message in a human readable format.

## The code

### Setup

1. Download the [sample capture](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/1%20Simple%20Dissector/sample_captures/Packets.cap "sample capture") and open it in wireshark
1. Go to `Help->About Wireshark->Folders`
3. Double click the `Personal lua Plugins` directory
4. Create a new file in this folder called `soildissector.lua` and open it in your favorite text editor

### Step 1 - Create a Protocol object

The first line of your dissector should be the `Proto` object

```
soilmessage_protocol = Proto("SOI", "Soil Message Protocol")
```

* The two fields of the Proto object are the `Name` and the `Description`. 

* The name can be any acronym that is not already in use by another protocol (`UDP`, `TCP`, etc).

* The description should describe what the protocol actually is in a couple words.

### Step 2 - Create ProtoFields

Next, you should add `ProtoFields`. They have many types such as `uint8`, `float`, `string`, and more. 

```
device_id = ProtoField.uint8("soilmessage.deviceid", "Device ID", base.DEC)
plant_type = ProtoField.uint8("soilmessage.planttype", "Plant Type", base.DEC)
```

These are the fields which we are dissecting and outputting in a readable format. 

* variable name can be anything
* first argument will be used for filters
* second argument will be the label on the field itself
* base can be DEC, HEX, OCT, etc based on encoding

In this case we are using two `uint8` fields which are `1 byte` wide with base `DEC`

### Step 3 - Add ProtoFields to Protocol object

Before using the fields in our table, they must be added to the `Proto` object

```
soilmessage_protocol.fields = { device_id, plant_type }
```

### Step 4 - Create the Dissector Function Skeleton

```
function soilmessage_protocol.dissector(buffer, pinfo, tree)
    length = buffer:len()
    if length == 0 then return end

    pinfo.cols.protocol = soilmessage_protocol.name

    local subtree = tree:add(soilmessage_protocol, buffer(), "Soil Message Protocol Data")

end
```

* function call will be in the above format with parameters `buffer`, `pinfo`, `tree`
* determine the `length` of the payload by calling `buffer:len()`
* if `length` is `0` then we should `return end` meaning that a 0 length payload will not be considered part of our Soil Message Protocol
* `pinfo` means `packet info`
* subtree is the packet details which we will be adding data to

### Step 5 - Add the fields to the subtree


```
    subtree:add(device_id, buffer(0, 1))
    subtree:add(plant_type, buffer(1, 1))
```

* we can `add` (big endian encoding) or `add_le` (little endian encoding)
* `buffer(x, y)` is the buffer starting at position `x` with length `y`

### Step 6 - Add to the udp_table

```
udp_table = DissectorTable.get("udp.port"):add(40000, soilmessage_protocol)
```

* dissector is now bound to UDP port 40000
* we can bind it to more ports by adding more copies of this line
* we can't bind two dissectors to one port
* port binding is optional for `heuristic` dissectors don't require ports to be bound

### The final product

```
soilmessage_protocol = Proto("SOI", "Soil Message Protocol")

device_id = ProtoField.uint8("soilmessage.deviceid", "Device ID", base.DEC)
plant_type = ProtoField.uint8("soilmessage.planttype", "Plant Type", base.DEC)

soilmessage_protocol.fields = { device_id, plant_type }

function soilmessage_protocol.dissector(buffer, pinfo, tree)
    length = buffer:len()
    if length == 0 then return end

    pinfo.cols.protocol = soilmessage_protocol.name

    local subtree = tree:add(soilmessage_protocol, buffer(), "Soil Message Protocol Data")

    subtree:add(device_id, buffer(0, 1))
    subtree:add(plant_type, buffer(1, 1))


end
udp_table = DissectorTable.get("udp.port"):add(40000, soilmessage_protocol)
```

### Testing 

Click `Analyze->Reload Lua Plugins` in Wireshark

Observe that the new dissector looks like this when you click on a packet

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/photos/dissectors1.PNG?raw=true)

Click on the other packets. See that the `Device ID` and `Plant Type` fields change between each activity

## Activities

Create a UDP filter that only shows packets with plants of type `2`

<details><summary>Possible solution</summary>
    <pre>
    soilmessage.planttype == 2
    </pre>
</details>

## References

[Lua Dissector used in this tutorial](https://wiki.wireshark.org/Lua/Dissectors "Lua Dissector used in this tutorial")

[Wireshark Lua Dissector Documentation](https://wiki.wireshark.org/Lua/Dissectors "Wireshark Lua Dissector Documentation")

[Wireshark Obtaining Packet Information](https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Pinfo.html "Wireshark Obtaining Packet Information")
