soilmessage_protocol = Proto("SOI", "Soil Message Protocol")

device_id = ProtoField.uint8("soilmessage.deviceid", "Device ID", base.DEC)
message_counter = ProtoField.uint32("soilmessage.message_counter", "Message Counter", base.DEC)
plant_type = ProtoField.uint8("soilmessage.planttype", "Plant Type", base.DEC)
soil_moisture = ProtoField.float("soilmessage.soilmoisture", "Soil Moisture", base.DEC)
humidity = ProtoField.double("soilmessage.double", "Humidity", base.DEC)
days_watered = ProtoField.int32("soilmessage.dayswatered", "Days Watered", base.DEC)


soilmessage_protocol.fields = { device_id, message_counter, plant_type, soil_moisture, humidity, days_watered }

function soilmessage_protocol.dissector(buffer, pinfo, tree)
    length = buffer:len()
    if length == 0 then return end

    pinfo.cols.protocol = soilmessage_protocol.name

    local subtree = tree:add(soilmessage_protocol, buffer(), "Soil Message Protocol Data")

    subtree:add(device_id, buffer(0, 1))
	subtree:add(message_counter, buffer(1,4))
	subtree:add(plant_type, buffer(5, 1))
	subtree:add(soil_moisture, buffer(6, 4))
	subtree:add(humidity, buffer(10, 8))
	subtree:add(days_watered, buffer(18, 4))

end
udp_table = DissectorTable.get("udp.port"):add(40000, soilmessage_protocol)
