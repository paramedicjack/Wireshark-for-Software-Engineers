soilmessage_protocol = Proto("SOI", "Soil Message Protocol")

device_id = ProtoField.uint8("soilmessage.deviceid", "Device ID", base.DEC)
plant_type = ProtoField.uint8("soilmessage.planttype", "Plant Type", base.DEC)


soilmessage_protocol.fields = { device_id, plant_type }

function soilmessage_protocol.dissector(buffer, pinfo, tree)
    length = buffer:len()
    if length == 0 then return end

    pinfo.cols.protocol = soilmessage_protocol.name

    local subtree = tree:add(soilmessage_protocol, buffer(), "Soil Message Protocol Data")

    subtree:add_le(device_id, buffer(0, 1))
    subtree:add_le(plant_type, buffer(1, 1))


end
udp_table = DissectorTable.get("udp.port"):add(40000, soilmessage_protocol)