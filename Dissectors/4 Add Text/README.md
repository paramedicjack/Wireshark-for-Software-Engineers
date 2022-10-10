# Add text

Now we'll be adding labels to our existing dissector fields. Afterwards our fields will look something like this.

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/4%20Add%20Text/photos/results1.PNG?raw=true)
 
We'll be using [this](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/3%20Dropdowns/sample_dissectors/soildissector.lua "this") dissector and [this](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/2%20More%20Protos/sample_captures/BigEndian.cap "this") packet capture.

## Plain text labels

The easiest way to add text to your field is to `append_text("[text]")` to any of your existing fields.

```
plantSubtree:add(soil_moisture, buffer(6, 4)):append_text("%")
plantSubtree:add(humidity, buffer(10, 8)):append_text("%")
plantSubtree:add(days_watered, buffer(18, 4)):append_text(" days ago")
```

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/4%20Add%20Text/photos/results3.PNG?raw=true)

This is a quick, easy solution to add unit types or other static symbols to your data fields.

## Adding variable fields

### From tables

We can also add variable labels to our fields based on our buffer bytes. 

Let's take our field `plantSubtree:add(plant_type, buffer(5, 1))`

The `uint8` value `plant_type` is a number that represents our plant. We'll say `0` is `Zanzibar Gem`, `1` is `Aloe Vera`, etc etc

We can create a `table` in Lua that will act as a `key value pair` for our values to the top of our file.

```
local plantTypes = {
	[0] = "Zanzibar Gem",
	[1] = "Aloe Vera",
	[2] = "Sansevieria",
	[3] = "Jade Plant",
	[4] = "Philodendron"
}
```

and then we can call it when it's time to add the field

`plantSubtree:add(plant_type, buffer(5, 1)):append_text(" (" .. plantTypes[buffer(5,1):uint()] .. ")")`

Note: we must specify that `buffer(5,1)` is a `uint()` for it to be a valid parameter.

If you are using this method, it's recommended to add error checking, probably via a function.

### From functions

`key value pair` is a good way to reference a set of values, however, we might want to determine the appended text based on a function.

Let's say that, although `days_watered` is an `int32`, it's invalid for `days_watered` to be lower than `0`.

```
local function getDaysWateredValid(days)
	if days >= 0 then return " (valid)" end
	return " (invalid)"
end
```

This function returns the text string `(valid)` if `days_watered` is greater than `0` and `(invalid)` if it isn't.

We can then call this function from our tree add. 

`plantSubtree:add(days_watered, buffer(18, 4)):append_text(getDaysWateredValid(buffer(18,4):int()))`

The results will look something like this

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/4%20Add%20Text/photos/results4.PNG?raw=true)


## Results

Click `Analyze->Reload Lua Plugins` in Wireshark

The dissection should look like this

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/4%20Add%20Text/photos/results1.PNG?raw=true)

## References

[Completed Dissector](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Dissectors/4%20Add%20Text/sample_dissectors/soildissector.lua "Completed Dissector")




