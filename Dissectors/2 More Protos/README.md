# More Protos

In this example we will be expanding our dissector to include more fields than just the two uint8s. 

TODO: add little endian examples

## New fields

Here are the fields which our dissector will have

| Message Name  | Message Type | Start Byte | Width | Endianness |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Device ID  | uint8  | 0 | 1 | Big |
| Message Counter  | uint32  | 1 | 4 | Big |
| Plant ID  | uint8  | 5 | 1 | Big |
| Soil Moisture  | float  | 6 | 4 | Big |
| Humidity  | double  | 10 | 8 | Big |
| Days Watered | int32 | 18 | 4 | Big |

Now that we are dealing with byte widths larger than `1` it's important to know what the byte width is for each data type.

## Sample Capture and values

The packet capture used for the big endian encoded dissector can be found here

[Big Endian](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/2%20More%20Protos/sample_captures/BigEndian.cap "Big Endian")

The encoded values are these

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/2%20More%20Protos/photos/values1.PNG?raw=true)

## Dissector 

We will be buidling off of [this dissector](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/1%20Simple%20Dissector/dissectors/soildissector.lua "ThisDissector")

### New Proto Fields

We have four new ProtoFields. The format stays the same for each including the base. However, we must change the ProtoField type for each.

```
message_counter = ProtoField.uint32("soilmessage.message_counter", "Message Counter", base.DEC)
soil_moisture = ProtoField.float("soilmessage.soilmoisture", "Soil Moisture", base.DEC)
humidity = ProtoField.double("soilmessage.double", "Humidity", base.DEC)
days_watered = ProtoField.int32("soilmessage.dayswatered", "Days Watered", base.DEC)
```

Don't forget to add them to the `soilmessage_protocol.fields` as well!

```
soilmessage_protocol.fields = { device_id, message_counter, plant_type, soil_moisture, humidity, days_watered }
```

### New subtree adds

We have four new buffer dissections to add to the subtree and one to reorganize as well.

```
subtree:add(device_id, buffer(0, 1))
subtree:add(message_counter, buffer(1,4))
subtree:add(plant_type, buffer(5, 1))
subtree:add(soil_moisture, buffer(6, 4))
subtree:add(humidity, buffer(10, 8))
subtree:add(days_watered, buffer(18, 4))
```

The format is is `subtree:add(ProtoField, buffer(startByte, width))`. Knowing the width of these buffers, we can increment the start byte appopriately.

### The final product

After you've edited your dissector, `Analyze->Reload` and check out the results.

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/2%20More%20Protos/photos/results1.PNG?raw=true)

All of the fields, including ones with decimal points and negatives should be present.

## References

[Completed Dissector](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/2%20More%20Protos/dissectors/soildissector.lua "Completed Dissector")


[Wireshark Obtaining Packet Information](https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Pinfo.html "Wireshark Obtaining Packet Information")


