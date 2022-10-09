# Dropdowns

In the result of our last dropdown you may have noticed that our dissection got a little large.

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/2%20More%20Protos/photos/results1.PNG?raw=true)

 A few more fields and we might have to start scrolling. We'll add a dropdown to simplify it.
 
 ![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/3%20Dropdowns/photos/results1.PNG?raw=true)
 
We'll be using [this](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/2%20More%20Protos/dissectors/soildissector.lua "this") dissector and [this](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/2%20More%20Protos/sample_captures/BigEndian.cap "this") packet capture.

## New subtrees

We are going to create two new subtrees called `Device Fields` and `Plant Fields` to separate our fields.

```
local deviceSubtree = subtree:add(soilmessage_protocol, buffer(), "Device Fields")
local plantSubtree = subtree:add(soilmessage_protocol, buffer(), "Plant Fields")
```

Since these will be dropdowns within our existing `subtree`, we must call `subtree:add` instead of `tree:add`.

## Adding the fields

Switching these fields from the main `subtree` to our child subtrees is as simple as changing which `subtree` adds them.

```
	deviceSubtree:add(device_id, buffer(0, 1))
	deviceSubtree:add(message_counter, buffer(1,4))
	
	plantSubtree:add(plant_type, buffer(5, 1))
	plantSubtree:add(soil_moisture, buffer(6, 4))
	plantSubtree:add(humidity, buffer(10, 8))
	plantSubtree:add(days_watered, buffer(18, 4))
```

After this change they will be added to the dropdown with no extra calls necessary. 


## Results

Click `Analyze->Reload Lua Plugins` in Wireshark

The dissection should look like this with the dropdowns expanded

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/3%20Dropdowns/photos/results1.PNG?raw=true)

And this with the dropdowns closed

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/3%20Dropdowns/photos/results2.PNG?raw=true)

## References

[Completed Dissector](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/3%20Dropdowns/sample_dissectors/soildissector.lua "Completed Dissector")




