local plantTypes = {
	[0] = "Zanzibar Gem",
	[1] = "Aloe Vera",
	[2] = "Sansevieria",
	[3] = "Jade Plant",
	[4] = "Philodendron"
}

local function getDaysWateredValid(days)
	if days >= 0 then return " (valid)" end
	return " (invalid)"
end

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
	
	local deviceSubtree = subtree:add(soilmessage_protocol, buffer(), "Device Fields")
	
	local plantSubtree = subtree:add(soilmessage_protocol, buffer(), "Plant Fields")

    deviceSubtree:add(device_id, buffer(0, 1))
	deviceSubtree:add(message_counter, buffer(1,4))
	
	plantSubtree:add(plant_type, buffer(5, 1)):append_text(" (" .. plantTypes[buffer(5,1):uint()] .. ")")
	plantSubtree:add(soil_moisture, buffer(6, 4)):append_text("%")
	plantSubtree:add(humidity, buffer(10, 8)):append_text("%")
	plantSubtree:add(days_watered, buffer(18, 4)):append_text(getDaysWateredValid(buffer(18,4):int()))

end
udp_table = DissectorTable.get("udp.port"):add(40000, soilmessage_protocol)
